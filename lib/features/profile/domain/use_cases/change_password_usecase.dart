import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ProfileRepository profileRepository;

  ChangePasswordUseCase({required this.profileRepository});

  Future<Either<Failure, Unit>> call({
    required String currentPassword,
    required String newPassword,
  }) => profileRepository.changePassword(
    currentPassword: currentPassword,
    newPassword: newPassword,
  );
}
