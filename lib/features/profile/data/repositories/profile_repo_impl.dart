import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/error_handler.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/core/storage/token_storage.dart';
import 'package:ecommerce_c19/core/storage/user_storage.dart';
import 'package:ecommerce_c19/features/profile/data/data_sources/remote/profile_remote_ds.dart';
import 'package:ecommerce_c19/features/profile/domain/entities/user_entity.dart';
import 'package:ecommerce_c19/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final UserStorage userStorage;
  final TokenStorage tokenStorage;

  ProfileRepositoryImpl({
    required this.profileRemoteDataSource,
    required this.userStorage,
    required this.tokenStorage,
  });

  // The API has no "get my profile" endpoint, so this is what was saved
  // at sign-in, sign-up, or the last update.
  @override
  Future<UserEntity> getProfile() async {
    final user = await userStorage.getUser();
    return UserEntity(
      name: user.name ?? '',
      email: user.email ?? '',
      phone: user.phone ?? '',
    );
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile({
    String? name,
    String? email,
    String? phone,
  }) => safeApiCall(() async {
    await profileRemoteDataSource.updateProfile(
      name: name,
      email: email,
      phone: phone,
    );
    await userStorage.saveUser(name: name, email: email, phone: phone);
    return getProfile();
  });

  @override
  Future<Either<Failure, Unit>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) => safeApiCall(() async {
    final token = await profileRemoteDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    await tokenStorage.saveToken(token);
    return unit;
  });
}
