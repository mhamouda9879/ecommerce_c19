import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';
import 'package:ecommerce_c19/features/auth/domain/repositories/auth_repo.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<AuthResponse> call(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    return await authRepository.signUpWithEmailAndPassword(
      email,
      password,
      name,
      phone,
    );
  }
}
