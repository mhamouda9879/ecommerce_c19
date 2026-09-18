import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  );

  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  );
}
