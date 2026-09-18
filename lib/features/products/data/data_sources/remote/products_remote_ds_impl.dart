import 'package:ecommerce_c19/core/network/api_constants.dart';
import 'package:ecommerce_c19/core/network/dio_helper.dart';
import 'package:ecommerce_c19/features/products/domain/entities/products_query.dart';
import 'package:ecommerce_c19/features/products/data/data_sources/remote/products_remote_ds.dart';
import 'package:ecommerce_c19/features/products/data/models/product_model.dart';
import 'package:ecommerce_c19/features/products/data/models/products_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRemoteDataSource)
class ProductsRemoteDsImpl implements ProductsRemoteDataSource {
  final DioHelper dioHelper;

  ProductsRemoteDsImpl({required this.dioHelper});

  @override
  Future<ProductsResponse> getProducts(ProductsQuery query) async {
    final result = await dioHelper.get(
      ApiConstants.products,
      queryParameters: {
        'category[in]': ?query.categoryIds,
        'subcategory[in]': ?query.subCategoryIds,
        'brand': ?query.brandId,
        'price[gte]': ?query.minPrice,
        'price[lte]': ?query.maxPrice,
        'sort': ?query.sort,
        'page': ?query.page,
        'limit': ?query.limit,
      },
    );
    return ProductsResponse.fromJson(result.data);
  }

  @override
  Future<ProductModel> getProductDetails(String productId) async {
    final result = await dioHelper.get('${ApiConstants.products}/$productId');
    return ProductModel.fromJson(result.data['data']);
  }
}
