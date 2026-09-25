import 'package:ecommerce_c19/features/cart/data/models/cart_model.dart';

abstract class CartDataSource {
  Future<bool> addToCart(String product);

  Future<CartModel> getCart();

  Future<CartModel> updateItemCount(String productId, int count);

  Future<CartModel> removeItem(String productId);

  Future<void> clearCart();
}
