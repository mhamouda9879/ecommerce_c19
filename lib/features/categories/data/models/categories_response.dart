import 'package:ecommerce_c19/features/categories/data/models/category_model.dart';

/// `GET /api/v1/categories` →
/// `{"results": 10, "metadata": {...}, "data": [{"_id", "name", "image", ...}]}`
class CategoriesResponse {
  /// Total matching categories (not just this page).
  final int results;
  final List<CategoryModel> data;

  const CategoriesResponse({required this.results, required this.data});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      results: json['results'] as int? ?? 0,
      data: [
        for (final item in json['data'] as List? ?? [])
          CategoryModel.fromJson(item as Map<String, dynamic>),
      ],
    );
  }
}
