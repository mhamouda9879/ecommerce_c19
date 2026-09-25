import 'package:ecommerce_c19/core/network/api_constants.dart';
import 'package:ecommerce_c19/core/network/dio_helper.dart';
import 'package:ecommerce_c19/core/storage/token_storage.dart';
import 'package:ecommerce_c19/features/products/data/models/product_model.dart';
import 'package:ecommerce_c19/features/wishlist/data/data_sources/remote/wishlist_remote_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WishlistRemoteDataSource)
class WishlistRemoteDsImpl implements WishlistRemoteDataSource {
  final DioHelper dioHelper;
  final TokenStorage tokenStorage;

  WishlistRemoteDsImpl({required this.dioHelper, required this.tokenStorage});

  @override
  Future<List<ProductModel>> getWishlist() async {
    final result = await dioHelper.get(
      ApiConstants.wishlist,
      token: await tokenStorage.getToken(),
    );
    return [
      for (final item in result.data['data'] as List? ?? [])
        ProductModel.fromJson(item as Map<String, dynamic>),
    ];
  }

  // Add and remove answer with the ids left in the wishlist.
  @override
  Future<List<String>> addToWishlist(String productId) async {
    final result = await dioHelper.post(
      ApiConstants.wishlist,
      data: {'productId': productId},
      token: await tokenStorage.getToken(),
    );
    return [for (final id in result.data['data'] as List? ?? []) '$id'];
  }

  @override
  Future<List<String>> removeFromWishlist(String productId) async {
    final result = await dioHelper.delete(
      '${ApiConstants.wishlist}/$productId',
      token: await tokenStorage.getToken(),
    );
    return [for (final id in result.data['data'] as List? ?? []) '$id'];
  }
}
