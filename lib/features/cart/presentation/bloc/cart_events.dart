abstract class CartEvents {}

class AddToCartEvent extends CartEvents {
  final String productId;
  AddToCartEvent(this.productId);
}
