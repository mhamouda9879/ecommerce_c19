import 'package:bloc/bloc.dart';
import 'package:ecommerce_c19/features/categories/domain/use_cases/get_categories_usecase.dart';
import 'package:ecommerce_c19/features/categories/domain/use_cases/get_sub_categories_usecase.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_events.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetSubCategoriesUseCase getSubCategoriesUseCase;

  CategoriesBloc(this.getCategoriesUseCase, this.getSubCategoriesUseCase)
    : super(const CategoriesState()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(state.copyWith(categoriesRequestStatus: RequestStatus.loading));

      final result = await getCategoriesUseCase(
        limit: event.limit,
        page: event.page,
        keyword: event.keyword,
      );
      result.fold(
        (failure) => emit(
          state.copyWith(
            categoriesRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (categories) => emit(
          state.copyWith(
            categoriesRequestStatus: RequestStatus.success,
            categories: categories,
          ),
        ),
      );
    });

    on<GetSubCategoriesEvent>((event, emit) async {
      emit(
        state.copyWith(
          subCategoriesRequestStatus: RequestStatus.loading,
          subCategoriesCategoryId: event.categoryId,
          subCategories: const [],
        ),
      );

      final result = await getSubCategoriesUseCase(
        categoryId: event.categoryId,
      );
      // Another category was picked while this one was loading.
      if (state.subCategoriesCategoryId != event.categoryId) return;
      result.fold(
        (failure) => emit(
          state.copyWith(
            subCategoriesRequestStatus: RequestStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (subCategories) => emit(
          state.copyWith(
            subCategoriesRequestStatus: RequestStatus.success,
            subCategories: subCategories,
          ),
        ),
      );
    });
  }
}
