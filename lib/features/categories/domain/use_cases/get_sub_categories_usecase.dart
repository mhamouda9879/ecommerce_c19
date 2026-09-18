import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/sub_category_entity.dart';
import 'package:ecommerce_c19/features/categories/domain/repositories/categories_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubCategoriesUseCase {
  final CategoriesRepository categoriesRepository;

  GetSubCategoriesUseCase({required this.categoriesRepository});

  Future<Either<Failure, List<SubCategoryEntity>>> call({
    String? categoryId,
    int? limit,
    int? page,
  }) {
    return categoriesRepository.getSubCategories(
      categoryId: categoryId,
      limit: limit,
      page: page,
    );
  }
}
