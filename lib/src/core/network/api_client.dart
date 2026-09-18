import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config_provider.dart';
import 'agnes_dio_log_interceptor.dart';
import 'api_exception.dart';

part 'api_client.g.dart';

abstract interface class ApiClient {
  Future<T> execute<T>(Future<T> Function() request);
}

@riverpod
DioApiClient apiClient(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return DioApiClient(baseUrl: config.baseUrl, apiKey: config.apiKey);
}

class DioApiClient implements ApiClient {
  DioApiClient({required String baseUrl, required String apiKey, Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: _normalizeBaseUrl(baseUrl),
              connectTimeout: const Duration(seconds: 15),
              sendTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 90),
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
            ),
          ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (apiKey.trim().isNotEmpty) {
            options.headers['Authorization'] = 'Bearer ${apiKey.trim()}';
          }
          options.headers['Content-Type'] = Headers.jsonContentType;
          handler.next(options);
        },
      ),
    );
    if (kDebugMode) {
      _dio.interceptors.add(AgnesDioLogInterceptor());
    }
  }

  final Dio _dio;

  /// The configured Dio instance used by feature-specific Retrofit APIs.
  Dio get dio => _dio;

  @override
  Future<T> execute<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  static String _normalizeBaseUrl(String value) {
    final trimmed = value.trim().replaceFirst(RegExp(r'/+$'), '');
    return trimmed.isEmpty ? 'https://apihub.agnes-ai.com/v1/' : '$trimmed/';
  }
}
