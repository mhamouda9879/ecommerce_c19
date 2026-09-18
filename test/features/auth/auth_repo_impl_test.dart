import 'package:dio/dio.dart';
import 'package:ecommerce_c19/core/storage/token_storage.dart';
import 'package:ecommerce_c19/features/auth/data/data_sources/remote/auth_remote_ds.dart';
import 'package:ecommerce_c19/features/auth/data/models/auth_response.dart';
import 'package:ecommerce_c19/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRemote implements AuthRemoteDataSource {
  Object? signInError;

  @override
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (signInError case final error?) throw error;
    return AuthResponse(message: 'success', token: 'jwt-123');
  }

  @override
  Future<AuthResponse> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  ) async => AuthResponse(message: 'success', token: 'signup-token');
}

void main() {
  late _FakeRemote remote;
  late TokenStorage tokenStorage;
  late AuthRepositoryImpl repository;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    remote = _FakeRemote();
    tokenStorage = TokenStorage(const FlutterSecureStorage());
    repository = AuthRepositoryImpl(
      authRemoteDataSource: remote,
      tokenStorage: tokenStorage,
    );
  });

  test('successful sign in saves the token', () async {
    expect(await repository.isLoggedIn(), isFalse);

    final result = await repository.signInWithEmailAndPassword('a@b.com', 'x');

    expect(result.isRight(), isTrue);
    expect(await tokenStorage.getToken(), 'jwt-123');
    expect(await repository.isLoggedIn(), isTrue);
  });

  test('failed sign in saves nothing', () async {
    remote.signInError = DioException(
      requestOptions: RequestOptions(path: '/signin'),
      type: DioExceptionType.connectionError,
    );

    final result = await repository.signInWithEmailAndPassword('a@b.com', 'x');

    expect(result.isLeft(), isTrue);
    expect(await repository.isLoggedIn(), isFalse);
  });

  test('sign up does not log the user in', () async {
    await repository.signUpWithEmailAndPassword('a@b.com', 'x', 'A', '010');

    expect(await repository.isLoggedIn(), isFalse);
  });

  test('logout deletes the token', () async {
    await repository.signInWithEmailAndPassword('a@b.com', 'x');

    await repository.logout();

    expect(await tokenStorage.getToken(), isNull);
    expect(await repository.isLoggedIn(), isFalse);
  });
}
