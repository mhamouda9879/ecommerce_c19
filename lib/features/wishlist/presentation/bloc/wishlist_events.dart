import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';

abstract class WishlistEvent {}

class GetWishlistEvent extends WishlistEvent {}

class ToggleWishlistEvent extends WishlistEvent {
  final ProductEntity product;

  ToggleWishlistEvent(this.product);
}
