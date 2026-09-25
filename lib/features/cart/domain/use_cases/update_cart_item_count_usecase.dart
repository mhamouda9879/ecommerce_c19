import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/cart/domain/entities/cart_entity.dart';
import 'package:ecommerce_c19/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCartItemCountUseCase {
  final CartRepository cartRepository;

  UpdateCartItemCountUseCase({required this.cartRepository});

  Future<Either<Failure, CartEntity>> call(String productId, int count) =>
      cartRepository.updateItemCount(productId, count);
}
