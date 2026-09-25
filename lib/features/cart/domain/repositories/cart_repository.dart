import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';

abstract class CartRepository {
  Future<Either<Failure, bool>> addToCart(String product);
}
