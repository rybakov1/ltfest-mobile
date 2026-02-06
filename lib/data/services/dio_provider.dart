import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:io';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:sentry_dio/sentry_dio.dart';
import '../../providers/connectivity_provider.dart';
import 'api_endpoints.dart';
import 'token_storage.dart';

part 'dio_provider.g.dart';

class DioConnectivityInterceptor extends Interceptor {
  final Ref _ref;

  DioConnectivityInterceptor(this._ref);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final connectivityStatus = _ref.read(connectivityStatusProvider);
    if (connectivityStatus.value == ConnectivityStatus.isDisconnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: "Нет подключения к интернету",
        ),
      );
    }

    return handler.next(options);
  }
}

class AuthInterceptor extends Interceptor {
  // Мы передаем Ref, чтобы иметь доступ к TokenStorage
  final Ref _ref;

  AuthInterceptor(this._ref);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Читаем провайдер прямо перед запросом - это гарантирует свежесть
    final token = await _ref.read(tokenStorageProvider).getJwt();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    print('Request: ${options.method} ${options.uri}');
    if (options.headers['Authorization'] != null) {
      print('Authorization header sent.');
    } else {
      print('Authorization header NOT sent.');
    }

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    print('Error: ${err.message}, Response: ${err.response?.data}, Status: ${err.response?.statusCode}');

    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      await _ref.read(tokenStorageProvider).clearToken();
      _ref.read(authInvalidationProvider.notifier).state++;
    }

    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ${response.statusCode}'); // Убрал data для краткости лога
    super.onResponse(response, handler);
  }
}

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseStrapiUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    ),
  );

  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  
  dio.interceptors.add(DioConnectivityInterceptor(ref));
  dio.interceptors.add(RetryInterceptor(
    dio: dio,
    logPrint: print,
    retries: 3,
    retryDelays: const [
      Duration(seconds: 2),
      Duration(seconds: 4),
      Duration(seconds: 6),
    ],
  ));

  dio.interceptors.add(AuthInterceptor(ref));
  dio.addSentry();

  return dio;
}
