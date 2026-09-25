import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/cart/domain/entities/cart_entity.dart';
import 'package:ecommerce_c19/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveCartItemUseCase {
  final CartRepository cartRepository;

  RemoveCartItemUseCase({required this.cartRepository});

  Future<Either<Failure, CartEntity>> call(String productId) =>
      cartRepository.removeItem(productId);
}
