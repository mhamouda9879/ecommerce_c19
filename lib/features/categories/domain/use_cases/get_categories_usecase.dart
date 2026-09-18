import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/category_entity.dart';
import 'package:ecommerce_c19/features/categories/domain/repositories/categories_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  final CategoriesRepository categoriesRepository;

  GetCategoriesUseCase({required this.categoriesRepository});

  Future<Either<Failure, List<CategoryEntity>>> call({
    int? limit,
    int? page,
    String? keyword,
  }) {
    return categoriesRepository.getCategories(
      limit: limit,
      page: page,
      keyword: keyword,
    );
  }
}
