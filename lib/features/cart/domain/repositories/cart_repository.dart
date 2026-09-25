import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, bool>> addToCart(String product);

  Future<Either<Failure, CartEntity>> getCart();

  Future<Either<Failure, CartEntity>> updateItemCount(
    String productId,
    int count,
  );

  Future<Either<Failure, CartEntity>> removeItem(String productId);

  Future<Either<Failure, Unit>> clearCart();
}
