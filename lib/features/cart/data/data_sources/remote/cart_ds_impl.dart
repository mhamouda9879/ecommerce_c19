import 'package:dio/dio.dart';
import 'package:ecommerce_c19/core/network/api_constants.dart';
import 'package:ecommerce_c19/core/network/dio_helper.dart';
import 'package:ecommerce_c19/core/storage/token_storage.dart';
import 'package:ecommerce_c19/features/cart/data/data_sources/remote/cart_ds.dart';
import 'package:ecommerce_c19/features/cart/data/models/cart_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartDataSource)
class CartDataSourceImpl implements CartDataSource {
  DioHelper dioHelper;
  TokenStorage tokenStorage;

  CartDataSourceImpl({required this.dioHelper, required this.tokenStorage});

  @override
  Future<bool> addToCart(String productId) async {
    Response res = await dioHelper.post(
      ApiConstants.cart,
      data: {'productId': productId},
      token: await tokenStorage.getToken(),
    );

    return res.data['status'] == 'success';
  }

  @override
  Future<CartModel> getCart() async {
    try {
      final res = await dioHelper.get(
        ApiConstants.cart,
        token: await tokenStorage.getToken(),
      );
      return CartModel.fromJson(res.data);
    } on DioException catch (e) {
      // The API answers 404 until the user adds their first product.
      if (e.response?.statusCode == 404) {
        return const CartModel(totalPrice: 0, items: []);
      }
      rethrow;
    }
  }

  @override
  Future<CartModel> updateItemCount(String productId, int count) async {
    final res = await dioHelper.put(
      '${ApiConstants.cart}/$productId',
      data: {'count': count},
      token: await tokenStorage.getToken(),
    );
    return CartModel.fromJson(res.data);
  }

  @override
  Future<CartModel> removeItem(String productId) async {
    final res = await dioHelper.delete(
      '${ApiConstants.cart}/$productId',
      token: await tokenStorage.getToken(),
    );
    return CartModel.fromJson(res.data);
  }

  @override
  Future<void> clearCart() async {
    await dioHelper.delete(
      ApiConstants.cart,
      token: await tokenStorage.getToken(),
    );
  }
}
