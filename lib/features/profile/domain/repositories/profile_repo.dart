import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getProfile();

  Future<Either<Failure, UserEntity>> updateProfile({
    String? name,
    String? email,
    String? phone,
  });

  Future<Either<Failure, Unit>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
