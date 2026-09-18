import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';
import 'package:ecommerce_c19/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<AuthResponse> call({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    return await authRepository.signUpWithEmailAndPassword(
      email,
      password,
      name,
      phone,
    );
  }
}
