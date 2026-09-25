import 'package:ecommerce_c19/core/utils/request_status.dart';

class CartStates {
  RequestStatus? requestStatus;
  String? errorMessage;
  bool? isAddedToCart;

  CartStates({
    this.requestStatus = RequestStatus.init,
    this.errorMessage,
    this.isAddedToCart,
  });

  copyWith({
    RequestStatus? requestStatus,
    String? errorMessage,
    bool? isAddedToCart,
  }) {
    return CartStates(
      requestStatus: requestStatus ?? this.requestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
    );
  }
}
