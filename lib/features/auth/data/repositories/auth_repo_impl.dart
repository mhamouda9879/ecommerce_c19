import 'package:dartz/dartz.dart';
import 'package:ecommerce_c19/core/errors/error_handler.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:ecommerce_c19/core/storage/token_storage.dart';
import 'package:ecommerce_c19/core/storage/user_storage.dart';
import 'package:ecommerce_c19/features/auth/data/data_sources/remote/auth_remote_ds.dart';
import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';
import 'package:ecommerce_c19/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  TokenStorage tokenStorage;
  UserStorage userStorage;
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.tokenStorage,
    required this.userStorage,
  });

  @override
  Future<Either<Failure, AuthResponse>> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  ) => safeApiCall(() async {
    final response = await authRemoteDataSource.signUpWithEmailAndPassword(
      email,
      password,
      name,
      phone,
    );
    await userStorage.saveUser(name: name, email: email, phone: phone);
    return response;
  });

  @override
  Future<Either<Failure, AuthResponse>> signInWithEmailAndPassword(
    String email,
    String password,
  ) => safeApiCall(() async {
    final response = await authRemoteDataSource.signInWithEmailAndPassword(
      email,
      password,
    );
    final token = response.token;
    if (token != null) await tokenStorage.saveToken(token);
    // Keep the phone saved at sign-up only if it's the same account.
    final storedUser = await userStorage.getUser();
    if (storedUser.email != response.user?.email) {
      await userStorage.deleteUser();
    }
    await userStorage.saveUser(
      name: response.user?.name,
      email: response.user?.email,
    );
    return response;
  });

  @override
  Future<bool> isLoggedIn() async {
    try {
      return await tokenStorage.getToken() != null;
    } catch (_) {
      // Unreadable storage (e.g. after an Android restore): start signed out.
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await tokenStorage.deleteToken();
    await userStorage.deleteUser();
  }
}
