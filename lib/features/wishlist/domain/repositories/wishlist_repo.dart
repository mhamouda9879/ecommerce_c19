import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';

abstract class WishlistRepository {
  Future<Either<Failure, List<ProductEntity>>> getWishlist();

  Future<Either<Failure, List<String>>> addToWishlist(String productId);

  Future<Either<Failure, List<String>>> removeFromWishlist(String productId);
}
