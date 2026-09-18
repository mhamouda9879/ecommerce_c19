import 'package:ecommerce_c19/core/network/api_constants.dart';
import 'package:ecommerce_c19/core/network/dio_helper.dart';
import 'package:ecommerce_c19/features/categories/data/data_sources/remote/categories_remote_ds.dart';
import 'package:ecommerce_c19/features/categories/data/models/categories_response.dart';
import 'package:ecommerce_c19/features/categories/data/models/sub_categories_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRemoteDataSource)
class CategoriesRemoteDsImpl implements CategoriesRemoteDataSource {
  final DioHelper dioHelper;

  CategoriesRemoteDsImpl({required this.dioHelper});

  @override
  Future<CategoriesResponse> getCategories({
    int? limit,
    int? page,
    String? keyword,
  }) async {
    final result = await dioHelper.get(
      ApiConstants.categories,
      // `?value` leaves the param out when it's null.
      queryParameters: {'limit': ?limit, 'page': ?page, 'keyword': ?keyword},
    );
    return CategoriesResponse.fromJson(result.data);
  }

  // The nested /categories/{id}/subcategories ignores the id, so filter here.
  @override
  Future<SubCategoriesResponse> getSubCategories({
    String? categoryId,
    int? limit,
    int? page,
  }) async {
    final result = await dioHelper.get(
      ApiConstants.subCategories,
      queryParameters: {
        'category': ?categoryId,
        'limit': ?limit,
        'page': ?page,
      },
    );
    return SubCategoriesResponse.fromJson(result.data);
  }
}
