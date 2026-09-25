import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/error_handler.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';
import 'package:ecommerce_c19/features/wishlist/data/data_sources/remote/wishlist_remote_ds.dart';
import 'package:ecommerce_c19/features/wishlist/domain/repositories/wishlist_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WishlistRepository)
class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource wishlistRemoteDataSource;

  WishlistRepositoryImpl({required this.wishlistRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getWishlist() =>
      safeApiCall(wishlistRemoteDataSource.getWishlist);

  @override
  Future<Either<Failure, List<String>>> addToWishlist(String productId) =>
      safeApiCall(() => wishlistRemoteDataSource.addToWishlist(productId));

  @override
  Future<Either<Failure, List<String>>> removeFromWishlist(String productId) =>
      safeApiCall(() => wishlistRemoteDataSource.removeFromWishlist(productId));
}
