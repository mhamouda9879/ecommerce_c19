import 'package:ecommerce_c19/core/utils/request_status.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/category_entity.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/sub_category_entity.dart';

export 'package:ecommerce_c19/core/utils/request_status.dart';

class CategoriesState {
  final List<CategoryEntity> categories;
  final List<SubCategoryEntity> subCategories;
  final String? subCategoriesCategoryId;
  final String? errorMessage;
  final RequestStatus categoriesRequestStatus;
  final RequestStatus subCategoriesRequestStatus;

  const CategoriesState({
    this.categories = const [],
    this.subCategories = const [],
    this.subCategoriesCategoryId,
    this.errorMessage,
    this.categoriesRequestStatus = RequestStatus.init,
    this.subCategoriesRequestStatus = RequestStatus.init,
  });

  CategoriesState copyWith({
    List<CategoryEntity>? categories,
    List<SubCategoryEntity>? subCategories,
    String? subCategoriesCategoryId,
    String? errorMessage,
    RequestStatus? categoriesRequestStatus,
    RequestStatus? subCategoriesRequestStatus,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      subCategoriesCategoryId:
          subCategoriesCategoryId ?? this.subCategoriesCategoryId,
      errorMessage: errorMessage ?? this.errorMessage,
      categoriesRequestStatus:
          categoriesRequestStatus ?? this.categoriesRequestStatus,
      subCategoriesRequestStatus:
          subCategoriesRequestStatus ?? this.subCategoriesRequestStatus,
    );
  }
}
