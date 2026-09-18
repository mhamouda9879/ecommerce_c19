import 'package:ecommerce_c19/core/network/api_constants.dart';
import 'package:ecommerce_c19/core/network/dio_helper.dart';
import 'package:ecommerce_c19/features/auth/data/data_sources/remote/auth_remote_ds.dart';
import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDsImpl implements AuthRemoteDataSource {
  final DioHelper dioHelper;

  AuthRemoteDsImpl({required this.dioHelper});

  @override
  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    final result = await dioHelper.post(
      ApiConstants.signUp,
      data: {
        "email": email,
        "password": password,
        "rePassword": password,
        "name": name,
        "phone": phone,
      },
    );
    return AuthResponse.fromJson(result.data);
  }

  @override
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final result = await dioHelper.post(
      ApiConstants.signIn,
      data: {"email": email, "password": password},
    );
    return AuthResponse.fromJson(result.data);
  }
}
