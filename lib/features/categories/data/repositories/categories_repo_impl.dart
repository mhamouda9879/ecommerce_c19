import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/error_handler.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/categories/data/data_sources/remote/categories_remote_ds.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/category_entity.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/sub_category_entity.dart';
import 'package:ecommerce_c19/features/categories/domain/repositories/categories_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource categoriesRemoteDataSource;

  CategoriesRepositoryImpl({required this.categoriesRemoteDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    int? limit,
    int? page,
    String? keyword,
  }) => safeApiCall(() async {
    final response = await categoriesRemoteDataSource.getCategories(
      limit: limit,
      page: page,
      keyword: keyword,
    );
    return response.data;
  });

  @override
  Future<Either<Failure, List<SubCategoryEntity>>> getSubCategories({
    String? categoryId,
    int? limit,
    int? page,
  }) => safeApiCall(() async {
    final response = await categoriesRemoteDataSource.getSubCategories(
      categoryId: categoryId,
      limit: limit,
      page: page,
    );
    return response.data;
  });
}
