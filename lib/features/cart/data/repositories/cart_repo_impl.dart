import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/cart/data/data_sources/remote/cart_ds.dart';
import 'package:ecommerce_c19/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  CartDataSource cartDataSource;

  CartRepositoryImpl({required this.cartDataSource});
  @override
  Future<Either<Failure, bool>> addToCart(String productId) async {
    try {
      final result = await cartDataSource.addToCart(productId);
      return Right(result);
    } catch (e) {
      return Left(
        ServerFailure("Error adding product to cart: ${e.toString()}"),
      );
    }
  }
}
