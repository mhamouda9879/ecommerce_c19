import 'package:ecommerce_c19/features/categories/data/models/sub_category_model.dart';

class SubCategoriesResponse {
  final int results;
  final List<SubCategoryModel> data;

  const SubCategoriesResponse({required this.results, required this.data});

  factory SubCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoriesResponse(
      results: json['results'] as int? ?? 0,
      data: [
        for (final item in json['data'] as List? ?? [])
          SubCategoryModel.fromJson(item as Map<String, dynamic>),
      ],
    );
  }
}
