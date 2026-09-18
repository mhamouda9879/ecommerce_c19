import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DioHelper {
  DioHelper(this._dio);

  final Dio _dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    String? token,
  }) => _dio.get(
    path,
    queryParameters: queryParameters,
    options: _options(token),
  );

  Future<Response<dynamic>> post(String path, {Object? data, String? token}) =>
      _dio.post(path, data: data, options: _options(token));

  Future<Response<dynamic>> put(String path, {Object? data, String? token}) =>
      _dio.put(path, data: data, options: _options(token));

  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    String? token,
  }) => _dio.delete(path, data: data, options: _options(token));

  Options? _options(String? token) =>
      token == null ? null : Options(headers: {'token': token});
}
