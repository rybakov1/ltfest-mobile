import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:io';

import 'token_storage.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://37.46.132.144:1337/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    ),
  );

  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await ref.read(tokenStorageProvider).getJwt();

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      print('Request: ${options.method} ${options.uri}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print('Response: ${response.statusCode} ${response.data}');
      return handler.next(response);
    },
    onError: (DioException e, handler) async {
      print(
          'Error: ${e.message}, Response: ${e.response?.data}, Status: ${e.response?.statusCode}');

      if (e.response?.statusCode == 401) {
        await ref.read(tokenStorageProvider).clearToken();
      }

      return handler.next(e);
    },
  ));
  return dio;
}
