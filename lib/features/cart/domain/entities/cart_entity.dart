class CartEntity {
  final String? cartId;
  final num totalPrice;
  final List<CartItemEntity> items;

  const CartEntity({
    this.cartId,
    required this.totalPrice,
    required this.items,
  });
}

class CartItemEntity {
  final String productId;
  final String title;
  final String imageCover;
  final num price;
  final int count;

  const CartItemEntity({
    required this.productId,
    required this.title,
    required this.imageCover,
    required this.price,
    required this.count,
  });
}
