import 'package:ecommerce_c19/core/utils/request_status.dart';
import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';

export 'package:ecommerce_c19/core/utils/request_status.dart';

class ProductsState {
  final List<ProductEntity> products;
  final ProductEntity? productDetails;
  final String? errorMessage;
  final RequestStatus productsRequestStatus;
  final RequestStatus productDetailsRequestStatus;

  const ProductsState({
    this.products = const [],
    this.productDetails,
    this.errorMessage,
    this.productsRequestStatus = RequestStatus.init,
    this.productDetailsRequestStatus = RequestStatus.init,
  });

  ProductsState copyWith({
    List<ProductEntity>? products,
    ProductEntity? productDetails,
    String? errorMessage,
    RequestStatus? productsRequestStatus,
    RequestStatus? productDetailsRequestStatus,
  }) {
    return ProductsState(
      products: products ?? this.products,
      productDetails: productDetails ?? this.productDetails,
      errorMessage: errorMessage ?? this.errorMessage,
      productsRequestStatus:
          productsRequestStatus ?? this.productsRequestStatus,
      productDetailsRequestStatus:
          productDetailsRequestStatus ?? this.productDetailsRequestStatus,
    );
  }
}
