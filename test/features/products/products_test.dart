import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_c19/core/network/dio_helper.dart';
import 'package:ecommerce_c19/features/products/data/data_sources/remote/products_remote_ds_impl.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/products/data/models/product_model.dart';
import 'package:ecommerce_c19/features/products/data/models/products_response.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_c19/features/products/domain/entities/products_query.dart';
import 'package:ecommerce_c19/features/products/domain/repositories/products_repo.dart';
import 'package:ecommerce_c19/features/products/domain/use_cases/get_product_details_usecase.dart';
import 'package:ecommerce_c19/features/products/domain/use_cases/get_products_usecase.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_bloc.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_events.dart';
import 'package:ecommerce_c19/features/products/presentation/bloc/products_states.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _productJson({Object? priceAfterDiscount = 379}) => {
  '_id': '6428dfa0dc1175abc65ca067',
  'title': 'Logo T-Shirt Green',
  'description': 'Soft and comfortable cotton fabric\nCrew neck',
  'imageCover': 'https://x/cover.jpeg',
  'images': ['https://x/1.jpeg', 'https://x/2.jpeg'],
  'price': 744,
  'priceAfterDiscount': ?priceAfterDiscount,
  'ratingsAverage': 5,
  'ratingsQuantity': 13,
  'sold': 779,
  'category': {'_id': 'c1', 'name': "Men's Fashion"},
};

class _FakeDioHelper implements DioHelper {
  String? lastPath;
  Map<String, dynamic>? lastQueryParameters;

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    lastPath = path;
    lastQueryParameters = queryParameters;
    return Response(
      requestOptions: RequestOptions(path: path),
      data: {
        'results': 1,
        'data': [_productJson()],
      },
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeProductsRepository implements ProductsRepository {
  ProductsQuery? lastQuery;
  Either<Failure, ProductEntity> detailsResult = const Left(
    ServerFailure('No document for this id', statusCode: 404),
  );

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
    ProductsQuery query,
  ) async {
    lastQuery = query;
    return Right([ProductModel.fromJson(_productJson())]);
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(
    String productId,
  ) async => detailsResult;
}

void main() {
  group('ProductModel.fromJson', () {
    test('reads the API fields', () {
      final product = ProductModel.fromJson(_productJson());

      expect(product.id, '6428dfa0dc1175abc65ca067');
      expect(product.images, hasLength(2));
      expect(product.price, 744);
      expect(product.priceAfterDiscount, 379);
      expect(product.finalPrice, 379);
      expect(product.ratingsAverage, 5.0);
    });

    test('treats a missing or 0 discount as no discount', () {
      final missing = ProductModel.fromJson(
        _productJson(priceAfterDiscount: null),
      );
      final zero = ProductModel.fromJson(_productJson(priceAfterDiscount: 0));

      expect(missing.priceAfterDiscount, isNull);
      expect(zero.priceAfterDiscount, isNull);
      expect(zero.finalPrice, 744);
    });

    test('ProductsResponse parses the list', () {
      final response = ProductsResponse.fromJson({
        'results': 22,
        'data': [_productJson(), _productJson()],
      });

      expect(response.results, 22);
      expect(response.data, hasLength(2));
    });
  });

  group('ProductsBloc', () {
    late _FakeProductsRepository repository;
    late ProductsBloc bloc;

    setUp(() {
      repository = _FakeProductsRepository();
      bloc = ProductsBloc(
        GetProductsUseCase(productsRepository: repository),
        GetProductDetailsUseCase(productsRepository: repository),
      );
    });

    tearDown(() => bloc.close());

    test('loads products for a category', () async {
      final states = bloc.stream.take(2).toList();
      bloc.add(GetProductsEvent(const ProductsQuery(categoryIds: ['c1'])));

      expect((await states).map((s) => s.productsRequestStatus), [
        RequestStatus.loading,
        RequestStatus.success,
      ]);
      expect(repository.lastQuery?.categoryIds, ['c1']);
      expect(bloc.state.products.single.title, 'Logo T-Shirt Green');
    });

    test('reports a details error', () async {
      final states = bloc.stream.take(2).toList();
      bloc.add(GetProductDetailsEvent('missing'));

      expect(
        (await states).last.productDetailsRequestStatus,
        RequestStatus.error,
      );
      expect(bloc.state.errorMessage, 'No document for this id');
      expect(bloc.state.productDetails, isNull);
    });
  });

  group('ProductsRemoteDsImpl', () {
    test('maps every query field to the API param name', () async {
      final dioHelper = _FakeDioHelper();
      final dataSource = ProductsRemoteDsImpl(dioHelper: dioHelper);

      await dataSource.getProducts(
        const ProductsQuery(
          categoryIds: ['c1', 'c2'],
          subCategoryIds: ['s1'],
          brandId: 'b1',
          minPrice: 100,
          maxPrice: 2000,
          sort: '-price',
          page: 2,
          limit: 10,
        ),
      );

      expect(dioHelper.lastPath, '/api/v1/products');
      expect(dioHelper.lastQueryParameters, {
        'category[in]': ['c1', 'c2'],
        'subcategory[in]': ['s1'],
        'brand': 'b1',
        'price[gte]': 100,
        'price[lte]': 2000,
        'sort': '-price',
        'page': 2,
        'limit': 10,
      });
    });

    test('sends no params for an empty query', () async {
      final dioHelper = _FakeDioHelper();

      await ProductsRemoteDsImpl(
        dioHelper: dioHelper,
      ).getProducts(const ProductsQuery());

      expect(dioHelper.lastQueryParameters, isEmpty);
    });
  });
}
