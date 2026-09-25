abstract class CartEvents {}

class AddToCartEvent extends CartEvents {
  final String productId;
  AddToCartEvent(this.productId);
}

class GetCartEvent extends CartEvents {}

class UpdateCartItemCountEvent extends CartEvents {
  final String productId;
  final int count;
  UpdateCartItemCountEvent(this.productId, this.count);
}

class RemoveCartItemEvent extends CartEvents {
  final String productId;
  RemoveCartItemEvent(this.productId);
}

class ClearCartEvent extends CartEvents {}
