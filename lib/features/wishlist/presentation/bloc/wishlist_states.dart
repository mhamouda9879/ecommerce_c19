import 'package:ecommerce_c19/core/utils/request_status.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';

export 'package:ecommerce_c19/core/utils/request_status.dart';

class WishlistState {
  final List<ProductEntity> products;
  final Set<String> ids;
  final String? errorMessage;
  final RequestStatus getWishlistRequestStatus;
  final RequestStatus toggleRequestStatus;

  const WishlistState({
    this.products = const [],
    this.ids = const {},
    this.errorMessage,
    this.getWishlistRequestStatus = RequestStatus.init,
    this.toggleRequestStatus = RequestStatus.init,
  });

  bool isFavorite(String productId) => ids.contains(productId);

  WishlistState copyWith({
    List<ProductEntity>? products,
    Set<String>? ids,
    String? errorMessage,
    RequestStatus? getWishlistRequestStatus,
    RequestStatus? toggleRequestStatus,
  }) {
    return WishlistState(
      products: products ?? this.products,
      ids: ids ?? this.ids,
      errorMessage: errorMessage ?? this.errorMessage,
      getWishlistRequestStatus:
          getWishlistRequestStatus ?? this.getWishlistRequestStatus,
      toggleRequestStatus: toggleRequestStatus ?? this.toggleRequestStatus,
    );
  }
}
