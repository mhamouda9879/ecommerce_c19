class ProductEntity {
  final String id;
  final String title;
  final String description;
  final String imageCover;
  final List<String> images;
  final num price;
  final num? priceAfterDiscount;
  final double ratingsAverage;
  final int ratingsQuantity;
  final int sold;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageCover,
    required this.images,
    required this.price,
    this.priceAfterDiscount,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.sold,
  });

  num get finalPrice => priceAfterDiscount ?? price;
}
