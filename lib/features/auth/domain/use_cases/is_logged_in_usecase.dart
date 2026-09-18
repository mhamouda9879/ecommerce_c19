import 'package:ecommerce_c19/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsLoggedInUseCase {
  final AuthRepository authRepository;

  IsLoggedInUseCase({required this.authRepository});

  Future<bool> call() => authRepository.isLoggedIn();
}
