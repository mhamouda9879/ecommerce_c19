import 'package:dio/dio.dart';
import 'package:ecommerce_c19/core/network/api_constants.dart';
import 'package:ecommerce_c19/core/network/dio_helper.dart';
import 'package:ecommerce_c19/core/storage/token_storage.dart';
import 'package:ecommerce_c19/di.dart';
import 'package:ecommerce_c19/features/cart/data/data_sources/remote/cart_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartDataSource)
class CartDataSourceImpl implements CartDataSource {
  DioHelper dioHelper;

  CartDataSourceImpl({required this.dioHelper});

  @override
  Future<bool> addToCart(String productId) async {
    print('Adding product to cart: $productId');
    Response res = await dioHelper.post(
      ApiConstants.cart,
      data: {'productId': productId},
      token: await getIt<TokenStorage>().getToken(),
    );

    return res.data['status'] == 'success';
  }
}
