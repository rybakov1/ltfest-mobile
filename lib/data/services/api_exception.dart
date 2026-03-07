import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() =>
      'ApiException: $message (Status: $statusCode, Data: $data)';

  factory ApiException.fromDioError(DioException e) {
    final response = e.response;
    final data = response?.data;
    String message;
    if (data is Map<String, dynamic>) {
      message = data['error']?['message'] ??
          data['detail'] ??
          data['message'] ??
          e.message ??
          'Unknown error';
    } else {
      message = e.message ?? 'Unknown error';
    }
    return ApiException(
      message: message,
      statusCode: response?.statusCode,
      data: data,
    );
  }

  factory ApiException.unauthorized() {
    return ApiException(
      message: 'Пользователь не аутентифицирован для выполнения этого запроса.',
      statusCode: 401,
    );
  }

  factory ApiException.notFound(String resource) {
    return ApiException(
      message: '$resource не найдено.',
      statusCode: 404,
    );
  }
}

/// Миксин для единообразной обработки ошибок в репозиториях.
mixin ApiErrorHandler {
  Never handleError(Object e) {
    if (e is DioException) {
      final msg = e.response?.data?['error']?['message'] ??
          e.message ??
          'Network request failed';
      debugPrint('[Repository] Dio error: $msg');
      throw ApiException.fromDioError(e);
    }
    debugPrint('[Repository] Unexpected error: $e');
    throw ApiException(message: e.toString());
  }
}
