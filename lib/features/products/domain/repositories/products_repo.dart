import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/products/domain/entities/products_query.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts(ProductsQuery query);

  Future<Either<Failure, ProductEntity>> getProductDetails(String productId);
}
