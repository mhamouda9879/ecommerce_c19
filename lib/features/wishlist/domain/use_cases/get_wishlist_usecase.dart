import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_c19/features/wishlist/domain/repositories/wishlist_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWishlistUseCase {
  final WishlistRepository wishlistRepository;

  GetWishlistUseCase({required this.wishlistRepository});

  Future<Either<Failure, List<ProductEntity>>> call() =>
      wishlistRepository.getWishlist();
}
