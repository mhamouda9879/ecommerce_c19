import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductToCartUsecase {
  CartRepository cartRepository;

  AddProductToCartUsecase({required this.cartRepository});

  Future<Either<Failure, bool>> call(String productId) async {
    return await cartRepository.addToCart(productId);
  }
}
