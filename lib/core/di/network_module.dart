import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:ecommerce_c19/core/network/api_constants.dart';

/// Registers the single [Dio] instance that `DioHelper` uses.
@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    if (kDebugMode) {
      // Request bodies are left out so passwords never reach the console.
      dio.interceptors.add(LogInterceptor(responseBody: true));
    }
    return dio;
  }
}
