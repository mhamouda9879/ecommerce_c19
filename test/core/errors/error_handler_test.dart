import 'package:dio/dio.dart';
import 'package:ecommerce_c19/core/errors/error_handler.dart';
import 'package:ecommerce_c19/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _badResponse(int statusCode, Object? data) {
  final options = RequestOptions(path: '/test');
  return DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response(
      requestOptions: options,
      statusCode: statusCode,
      data: data,
    ),
  );
}

DioException _ofType(DioExceptionType type) => DioException(
  requestOptions: RequestOptions(path: '/test'),
  type: type,
);

void main() {
  group('mapErrorToFailure', () {
    test('reads "message" from a statusMsg-style error', () {
      final failure = mapErrorToFailure(
        _badResponse(401, {
          'statusMsg': 'fail',
          'message': 'Incorrect email or password',
        }),
      );

      expect(failure, isA<ServerFailure>());
      expect(failure.message, 'Incorrect email or password');
      expect((failure as ServerFailure).statusCode, 401);
    });

    test('reads "errors.msg" from a validation error', () {
      final failure = mapErrorToFailure(
        _badResponse(400, {
          'message': 'fail',
          'errors': {'value': 'x', 'msg': 'Invalid email ', 'param': 'email'},
        }),
      );

      expect(failure.message, 'Invalid email');
    });

    test('falls back to a generic message by status code', () {
      expect(
        mapErrorToFailure(_badResponse(500, null)).message,
        'Server error, please try again later',
      );
      expect(
        mapErrorToFailure(_badResponse(404, '<html>')).message,
        'Something went wrong, please try again',
      );
    });

    test('maps connection problems to NetworkFailure', () {
      final offline = mapErrorToFailure(
        _ofType(DioExceptionType.connectionError),
      );
      final timeout = mapErrorToFailure(
        _ofType(DioExceptionType.receiveTimeout),
      );

      expect(offline, isA<NetworkFailure>());
      expect(offline.message, 'No internet connection');
      expect(timeout, isA<NetworkFailure>());
    });

    test('maps anything else to UnknownFailure', () {
      expect(
        mapErrorToFailure(const FormatException('bad json')),
        isA<UnknownFailure>(),
      );
    });
  });

  group('safeApiCall', () {
    test('returns Right with the result on success', () async {
      final result = await safeApiCall(() async => 42);

      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => 0), 42);
    });

    test('returns Left with a Failure when the call throws', () async {
      final result = await safeApiCall<int>(
        () async => throw _ofType(DioExceptionType.connectionError),
      );

      result.fold(
        (failure) => expect(failure.message, 'No internet connection'),
        (_) => fail('expected a failure'),
      );
    });
  });
}
