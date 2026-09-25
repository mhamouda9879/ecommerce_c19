import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/error_handler.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/cart/data/data_sources/remote/cart_ds.dart';
import 'package:ecommerce_c19/features/cart/domain/entities/cart_entity.dart';
import 'package:ecommerce_c19/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  CartDataSource cartDataSource;

  CartRepositoryImpl({required this.cartDataSource});

  @override
  Future<Either<Failure, bool>> addToCart(String productId) =>
      safeApiCall(() => cartDataSource.addToCart(productId));

  @override
  Future<Either<Failure, CartEntity>> getCart() =>
      safeApiCall(cartDataSource.getCart);

  @override
  Future<Either<Failure, CartEntity>> updateItemCount(
    String productId,
    int count,
  ) => safeApiCall(() => cartDataSource.updateItemCount(productId, count));

  @override
  Future<Either<Failure, CartEntity>> removeItem(String productId) =>
      safeApiCall(() => cartDataSource.removeItem(productId));

  @override
  Future<Either<Failure, Unit>> clearCart() => safeApiCall(() async {
    await cartDataSource.clearCart();
    return unit;
  });
}
