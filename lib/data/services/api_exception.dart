import 'package:dio/dio.dart';

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
  String toString() => 'ApiException: $message (Status: $statusCode, Data: $data)';

  factory ApiException.fromDioError(DioException e) {
    final response = e.response;
    return ApiException(
      message: response?.data['detail'] ?? e.message ?? 'Unknown error',
      statusCode: response?.statusCode,
      data: response?.data,
    );
  }

  factory ApiException.unauthorized() {
    return ApiException(
      message: 'Unauthorized access',
      statusCode: 401,
    );
  }

  factory ApiException.notFound(String resource) {
    return ApiException(
      message: '$resource not found',
      statusCode: 404,
    );
  }
}