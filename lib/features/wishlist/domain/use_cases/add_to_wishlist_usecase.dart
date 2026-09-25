import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/wishlist/domain/repositories/wishlist_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToWishlistUseCase {
  final WishlistRepository wishlistRepository;

  AddToWishlistUseCase({required this.wishlistRepository});

  Future<Either<Failure, List<String>>> call(String productId) =>
      wishlistRepository.addToWishlist(productId);
}
