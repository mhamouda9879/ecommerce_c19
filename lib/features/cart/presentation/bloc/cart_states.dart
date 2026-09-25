import 'package:ecommerce_c19/core/utils/request_status.dart';
import 'package:ecommerce_c19/features/cart/domain/entities/cart_entity.dart';

export 'package:ecommerce_c19/core/utils/request_status.dart';

class CartStates {
  RequestStatus? requestStatus;
  String? errorMessage;
  bool? isAddedToCart;
  CartEntity? cart;
  RequestStatus getCartRequestStatus;
  RequestStatus updateCartRequestStatus;

  CartStates({
    this.requestStatus = RequestStatus.init,
    this.errorMessage,
    this.isAddedToCart,
    this.cart,
    this.getCartRequestStatus = RequestStatus.init,
    this.updateCartRequestStatus = RequestStatus.init,
  });

  CartStates copyWith({
    RequestStatus? requestStatus,
    String? errorMessage,
    bool? isAddedToCart,
    CartEntity? cart,
    RequestStatus? getCartRequestStatus,
    RequestStatus? updateCartRequestStatus,
  }) {
    return CartStates(
      requestStatus: requestStatus ?? this.requestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
      cart: cart ?? this.cart,
      getCartRequestStatus: getCartRequestStatus ?? this.getCartRequestStatus,
      updateCartRequestStatus:
          updateCartRequestStatus ?? this.updateCartRequestStatus,
    );
  }
}
