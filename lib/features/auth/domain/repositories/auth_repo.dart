import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  );

  Future<Either<Failure, AuthResponse>> signInWithEmailAndPassword(
    String email,
    String password,
  );
}
