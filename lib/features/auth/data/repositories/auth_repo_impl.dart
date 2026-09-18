import 'package:ecommerce_c19/features/auth/data/data_sources/remote/auth_remote_ds.dart';
import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';
import 'package:ecommerce_c19/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  ) {
    try {
      return authRemoteDataSource.signUpWithEmailAndPassword(
        email,
        password,
        name,
        phone,
      );
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
