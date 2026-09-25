import 'package:ecommerce_c19/core/utils/request_status.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';

export 'package:ecommerce_c19/core/utils/request_status.dart';

class ProductsState {
  final List<ProductEntity> products;
  final ProductEntity? productDetails;
  final String? errorMessage;
  final bool isAddedToCart;
  final RequestStatus productsRequestStatus;
  final RequestStatus addProductToCartRequestStatus;
  final RequestStatus productDetailsRequestStatus;

  const ProductsState({
    this.products = const [],
    this.productDetails,
    this.errorMessage,
    this.isAddedToCart = false,
    this.productsRequestStatus = RequestStatus.init,
    this.addProductToCartRequestStatus = RequestStatus.init,
    this.productDetailsRequestStatus = RequestStatus.init,
  });

  ProductsState copyWith({
    List<ProductEntity>? products,
    ProductEntity? productDetails,
    String? errorMessage,
    bool? isAddedToCart,
    RequestStatus? productsRequestStatus,
    RequestStatus? addProductToCartRequestStatus,
    RequestStatus? productDetailsRequestStatus,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
      addProductToCartRequestStatus:
          addProductToCartRequestStatus ?? this.addProductToCartRequestStatus,
      productDetails: productDetails ?? this.productDetails,
      errorMessage: errorMessage ?? this.errorMessage,
      productsRequestStatus:
          productsRequestStatus ?? this.productsRequestStatus,
      productDetailsRequestStatus:
          productDetailsRequestStatus ?? this.productDetailsRequestStatus,
    );
  }
}
