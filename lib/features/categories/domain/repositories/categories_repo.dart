import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/category_entity.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/sub_category_entity.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    int? limit,
    int? page,
    String? keyword,
  });

  Future<Either<Failure, List<SubCategoryEntity>>> getSubCategories({
    String? categoryId,
    int? limit,
    int? page,
  });
}
