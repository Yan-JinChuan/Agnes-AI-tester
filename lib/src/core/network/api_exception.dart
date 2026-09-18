import 'package:dio/dio.dart';

class ApiException implements Exception {
  const ApiException({required this.message, this.statusCode, this.data});

  factory ApiException.fromDio(DioException error) {
    final body = _asMap(error.response?.data);
    final apiError = body['error'];
    if (apiError is Map && apiError['message'] is String) {
      return ApiException(
        message: '请求失败：${apiError['message']}',
        statusCode: error.response?.statusCode,
        data: error.response?.data,
      );
    }
    if (body['message'] is String) {
      return ApiException(
        message: '请求失败：${body['message']}',
        statusCode: error.response?.statusCode,
        data: error.response?.data,
      );
    }
    final statusCode = error.response?.statusCode;
    if (statusCode != null) {
      return ApiException(
        message: '请求失败（HTTP $statusCode）：${error.message ?? '未知错误'}',
        statusCode: statusCode,
        data: error.response?.data,
      );
    }
    return ApiException(
      message: '网络请求失败：${error.message ?? error.type.name}',
      data: error.response?.data,
    );
  }

  final String message;
  final int? statusCode;
  final Object? data;

  @override
  String toString() => message;

  static Map<String, dynamic> _asMap(Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return <String, dynamic>{};
  }
}
