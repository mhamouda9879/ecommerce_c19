import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:ecommerce_c19/core/errors/failures.dart';

/// Runs an API call and returns its result, or the [Failure] it threw.
///
/// Wrap every repository method in this so all APIs report errors the same
/// way:
/// ```dart
/// return safeApiCall(() => remoteDataSource.signIn(email, password));
/// ```
Future<Either<Failure, T>> safeApiCall<T>(Future<T> Function() call) async {
  try {
    return Right(await call());
  } catch (error) {
    return Left(mapErrorToFailure(error));
  }
}

Failure mapErrorToFailure(Object error) => switch (error) {
  DioException(
    type: DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout,
  ) =>
    const NetworkFailure('The connection timed out, please try again'),
  DioException(type: DioExceptionType.connectionError) => const NetworkFailure(
    'No internet connection',
  ),
  DioException(type: DioExceptionType.badResponse, :final response) =>
    ServerFailure(_serverMessage(response), statusCode: response?.statusCode),
  DioException(type: DioExceptionType.cancel) => const UnknownFailure(
    'The request was cancelled',
  ),
  _ => const UnknownFailure(),
};

/// Route API errors come in two shapes:
/// `{"statusMsg": "fail", "message": "Incorrect email or password"}` and
/// `{"message": "fail", "errors": {"msg": "Invalid email", ...}}`.
String _serverMessage(Response<dynamic>? response) {
  final data = response?.data;
  if (data is Map) {
    final errors = data['errors'];
    if (errors is Map && errors['msg'] is String) {
      return (errors['msg'] as String).trim();
    }
    final message = data['message'];
    if (message is String && message != 'fail') return message;
  }
  final statusCode = response?.statusCode ?? 0;
  return statusCode >= 500
      ? 'Server error, please try again later'
      : 'Something went wrong, please try again';
}
