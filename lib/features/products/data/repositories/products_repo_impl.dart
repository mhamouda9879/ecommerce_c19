import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/error_handler.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/products/domain/entities/products_query.dart';
import 'package:ecommerce_c19/features/products/data/data_sources/remote/products_remote_ds.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_c19/features/products/domain/repositories/products_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImpl({required this.productsRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
    ProductsQuery query,
  ) => safeApiCall(() async {
    final response = await productsRemoteDataSource.getProducts(query);
    return response.data;
  });

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(String productId) =>
      safeApiCall(() => productsRemoteDataSource.getProductDetails(productId));
}
