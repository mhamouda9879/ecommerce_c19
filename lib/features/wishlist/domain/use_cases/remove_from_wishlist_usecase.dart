import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/wishlist/domain/repositories/wishlist_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveFromWishlistUseCase {
  final WishlistRepository wishlistRepository;

  RemoveFromWishlistUseCase({required this.wishlistRepository});

  Future<Either<Failure, List<String>>> call(String productId) =>
      wishlistRepository.removeFromWishlist(productId);
}
