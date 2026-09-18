import 'package:ecommerce_c19/features/categories/domain/entities/sub_category_entity.dart';

class SubCategoryModel extends SubCategoryEntity {
  const SubCategoryModel({
    required super.id,
    required super.name,
    required super.categoryId,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      categoryId: json['category'] as String,
    );
  }
}
