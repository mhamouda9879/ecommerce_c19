import 'package:ecommerce_c19/features/products/domain/entities/products_query.dart';

abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {
  final ProductsQuery query;

  GetProductsEvent([this.query = const ProductsQuery()]);
}

class GetProductDetailsEvent extends ProductsEvent {
  final String productId;

  GetProductDetailsEvent(this.productId);
}

class AddToCartEvent extends ProductsEvent {
  final String productId;
  final int quantity;

  AddToCartEvent(this.productId, {this.quantity = 1});
}
