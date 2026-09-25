import 'package:ecommerce_c19/features/products/data/models/product_model.dart';

abstract class WishlistRemoteDataSource {
  Future<List<ProductModel>> getWishlist();

  Future<List<String>> addToWishlist(String productId);

  Future<List<String>> removeFromWishlist(String productId);
}
