import 'package:ecommerce_c19/features/profile/domain/entities/user_entity.dart';
import 'package:ecommerce_c19/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepository profileRepository;

  GetProfileUseCase({required this.profileRepository});

  Future<UserEntity> call() => profileRepository.getProfile();
}
