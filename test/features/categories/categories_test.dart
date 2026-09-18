import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/categories/data/models/categories_response.dart';
import 'dart:async';

import 'package:ecommerce_c19/features/categories/data/models/sub_categories_response.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/category_entity.dart';
import 'package:ecommerce_c19/features/categories/domain/entities/sub_category_entity.dart';
import 'package:ecommerce_c19/features/categories/domain/repositories/categories_repo.dart';
import 'package:ecommerce_c19/features/categories/domain/use_cases/get_categories_usecase.dart';
import 'package:ecommerce_c19/features/categories/domain/use_cases/get_sub_categories_usecase.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_events.dart';
import 'package:ecommerce_c19/features/categories/presentation/bloc/categories_states.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeCategoriesRepository implements CategoriesRepository {
  _FakeCategoriesRepository(this.result);

  final Either<Failure, List<CategoryEntity>> result;
  ({int? limit, int? page, String? keyword})? lastParams;

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    int? limit,
    int? page,
    String? keyword,
  }) async {
    lastParams = (limit: limit, page: page, keyword: keyword);
    return result;
  }

  final subCategoryResponses =
      <String, Completer<Either<Failure, List<SubCategoryEntity>>>>{};

  @override
  Future<Either<Failure, List<SubCategoryEntity>>> getSubCategories({
    String? categoryId,
    int? limit,
    int? page,
  }) => subCategoryResponses.putIfAbsent(categoryId!, Completer.new).future;
}

CategoriesBloc _blocWith(_FakeCategoriesRepository repository) =>
    CategoriesBloc(
      GetCategoriesUseCase(categoriesRepository: repository),
      GetSubCategoriesUseCase(categoriesRepository: repository),
    );

void main() {
  test('CategoriesResponse parses the API response', () {
    final response = CategoriesResponse.fromJson({
      'results': 10,
      'metadata': {'currentPage': 2, 'numberOfPages': 4, 'limit': 3},
      'data': [
        {
          '_id': '6439d41c67d9aa4ca97064d5',
          'name': 'SuperMarket',
          'slug': 'supermarket',
          'image': 'https://ecommerce.routemisr.com/x.png',
          'createdAt': '2023-04-14T22:30:52.689Z',
        },
      ],
    });

    expect(response.results, 10);
    expect(response.data.single.id, '6439d41c67d9aa4ca97064d5');
    expect(response.data.single.name, 'SuperMarket');
    expect(response.data.single.image, 'https://ecommerce.routemisr.com/x.png');
  });

  test('CategoriesResponse handles an empty page', () {
    final response = CategoriesResponse.fromJson({'results': 0, 'data': []});

    expect(response.data, isEmpty);
  });

  test('bloc emits loading then success with the categories', () async {
    const categories = [CategoryEntity(id: '1', name: 'Music', image: 'm')];
    final repository = _FakeCategoriesRepository(const Right(categories));
    final bloc = _blocWith(repository);

    final states = bloc.stream.take(2).toList();
    bloc.add(GetCategoriesEvent(limit: 2, page: 2));

    expect((await states).map((s) => s.categoriesRequestStatus), [
      RequestStatus.loading,
      RequestStatus.success,
    ]);
    expect(bloc.state.categories, categories);
    expect(repository.lastParams, (limit: 2, page: 2, keyword: null));
    await bloc.close();
  });

  test('bloc emits loading then error with the failure message', () async {
    final bloc = _blocWith(
      _FakeCategoriesRepository(
        const Left(ServerFailure('Server error', statusCode: 500)),
      ),
    );

    final states = bloc.stream.take(2).toList();
    bloc.add(GetCategoriesEvent());

    expect((await states).last.categoriesRequestStatus, RequestStatus.error);
    expect(bloc.state.errorMessage, 'Server error');
    await bloc.close();
  });

  test('SubCategoriesResponse parses the API response', () {
    final response = SubCategoriesResponse.fromJson({
      'results': 2,
      'data': [
        {
          '_id': '6407f243b575d3b90bf957ac',
          'name': "Men's Clothing",
          'slug': "men's-clothing",
          'category': '6439d5b90049ad0b52b90048',
        },
      ],
    });

    expect(response.data.single.name, "Men's Clothing");
    expect(response.data.single.categoryId, '6439d5b90049ad0b52b90048');
  });

  test('a late answer for a previous category is ignored', () async {
    final repository = _FakeCategoriesRepository(const Right([]));
    final bloc = _blocWith(repository);

    bloc.add(GetSubCategoriesEvent('men'));
    bloc.add(GetSubCategoriesEvent('women'));
    await pumpEventQueue();

    repository.subCategoryResponses['women']!.complete(
      const Right([
        SubCategoryEntity(id: 'w', name: 'Dresses', categoryId: 'women'),
      ]),
    );
    await pumpEventQueue();
    repository.subCategoryResponses['men']!.complete(
      const Right([
        SubCategoryEntity(id: 'm', name: 'Shirts', categoryId: 'men'),
      ]),
    );
    await pumpEventQueue();

    expect(bloc.state.subCategoriesCategoryId, 'women');
    expect(bloc.state.subCategories.single.name, 'Dresses');
    expect(bloc.state.subCategoriesRequestStatus, RequestStatus.success);
    await bloc.close();
  });
}
