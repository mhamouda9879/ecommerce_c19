import 'package:ecommerce_c19/features/cart/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    super.cartId,
    required super.totalPrice,
    required super.items,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return CartModel(
      cartId: json['cartId'] as String?,
      totalPrice: data['totalCartPrice'] as num? ?? 0,
      items: [
        for (final item in data['products'] as List? ?? [])
          CartItemModel.fromJson(item as Map<String, dynamic>),
      ],
    );
  }
}

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.productId,
    required super.title,
    required super.imageCover,
    required super.price,
    required super.count,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] as Map<String, dynamic>;
    return CartItemModel(
      productId: product['_id'] as String,
      title: product['title'] as String? ?? '',
      imageCover: product['imageCover'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      count: json['count'] as int? ?? 1,
    );
  }
}
