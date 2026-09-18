import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  );
}
