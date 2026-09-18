import 'package:ecommerce_c19/features/categories/data/models/categories_response.dart';
import 'package:ecommerce_c19/features/categories/data/models/sub_categories_response.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoriesResponse> getCategories({
    int? limit,
    int? page,
    String? keyword,
  });

  Future<SubCategoriesResponse> getSubCategories({
    String? categoryId,
    int? limit,
    int? page,
  });
}
