import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClearCartUseCase {
  final CartRepository cartRepository;

  ClearCartUseCase({required this.cartRepository});

  Future<Either<Failure, Unit>> call() => cartRepository.clearCart();
}
