import 'package:dio/dio.dart';
import 'package:ecommerce_c19/features/auth/data/data_sources/remote/auth_remote_ds.dart';
import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDsImpl implements AuthRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    try {
      var result = await dio.post(
        "https://ecommerce.routemisr.com/api/v1/auth/signup",
        data: {
          "email": email,
          "password": password,
          "rePassword": password,
          "name": name,
          "phone": phone,
        },
      );

      return AuthResponse.fromJson(result.data);
    } catch (e) {
      rethrow;
    }
  }
}
