import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/profile/domain/entities/user_entity.dart';
import 'package:ecommerce_c19/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfileUseCase {
  final ProfileRepository profileRepository;

  UpdateProfileUseCase({required this.profileRepository});

  Future<Either<Failure, UserEntity>> call({
    String? name,
    String? email,
    String? phone,
  }) => profileRepository.updateProfile(name: name, email: email, phone: phone);
}
