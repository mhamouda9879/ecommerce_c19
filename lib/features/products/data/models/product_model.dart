import 'package:ecommerce_c19/features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageCover,
    required super.images,
    required super.price,
    super.priceAfterDiscount,
    required super.ratingsAverage,
    required super.ratingsQuantity,
    required super.sold,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final priceAfterDiscount = json['priceAfterDiscount'] as num?;
    return ProductModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      imageCover: json['imageCover'] as String,
      images: [for (final image in json['images'] as List? ?? []) '$image'],
      price: json['price'] as num,
      // The API sends 0 (or nothing) when there is no discount.
      priceAfterDiscount: priceAfterDiscount == 0 ? null : priceAfterDiscount,
      ratingsAverage: (json['ratingsAverage'] as num? ?? 0).toDouble(),
      ratingsQuantity: json['ratingsQuantity'] as int? ?? 0,
      sold: json['sold'] as int? ?? 0,
    );
  }
}
