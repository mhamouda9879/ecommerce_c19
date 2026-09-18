import 'package:ecommerce_c19/features/products/data/models/product_model.dart';

class ProductsResponse {
  final int results;
  final List<ProductModel> data;

  const ProductsResponse({required this.results, required this.data});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      results: json['results'] as int? ?? 0,
      data: [
        for (final item in json['data'] as List? ?? [])
          ProductModel.fromJson(item as Map<String, dynamic>),
      ],
    );
  }
}
