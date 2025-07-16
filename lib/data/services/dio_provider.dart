// import 'package:dio/dio.dart';
// import 'package:dio/io.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:synchronized/synchronized.dart';
// import 'dart:io';
//
// import 'api_service.dart';
// import 'token_storage.dart'; // Для HttpClient
//
// part 'dio_provider.g.dart';
//
// @riverpod
// Dio dio(Ref ref) {
//   final dio = Dio(
//     BaseOptions(
//       baseUrl: 'https://37.46.132.144/',
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//       headers: {'Content-Type': 'application/json; charset=utf-8'},
//     ),
//   );
//
//   // Обход проверки самоподписанного сертификата
//   (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
//     client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     return client;
//   };
//
//   dio.interceptors.add(InterceptorsWrapper(
//     onRequest: (options, handler) async {
//       final token = await ref.read(tokenStorageProvider).getAccessToken();
//
//       if (token != null) {
//         options.headers['Authorization'] = 'Bearer $token';
//       }
//
//       print('Request: ${options.method} ${options.uri}');
//       return handler.next(options);
//     },
//     onResponse: (response, handler) {
//       print('Response: ${response.statusCode} ${response.data}');
//       return handler.next(response);
//     },
//     onError: (DioException e, handler) async {
//       print('Error: ${e.message}, Response: ${e.response?.data}, Status: ${e.response?.statusCode}');
//       if (e.response?.statusCode == 401) {
//         // Пытаемся обновить токен
//         final tokenStorage = ref.read(tokenStorageProvider);
//         final refreshToken = await tokenStorage.getRefreshToken();
//         if (refreshToken != null) {
//           try {
//             // Синхронизируем доступ к токенам
//             final lock = dio.options.extra['lock'] ?? Lock();
//             await lock.synchronized(() async {
//               // Повторная проверка
//               final currentToken = await tokenStorage.getAccessToken();
//               if (currentToken != null && !JwtDecoder.isExpired(currentToken)) {
//                 return handler.resolve(await dio.fetch(e.requestOptions));
//               }
//
//               // Обновляем токен
//               final apiService = ref.read(apiServiceProvider);
//               final newTokens = await apiService.refreshToken(refreshToken);
//               // Сохраняем новый токен
//               await tokenStorage.saveTokens(
//                 accessToken: newTokens['accessToken'],
//                 refreshToken: newTokens['refresh_token'],
//               );
//
//               // Повторяем исходный запрос с новым токеном
//               e.requestOptions.headers['Authorization'] =
//               'Bearer ${newTokens['access_token']}';
//               final response = await dio.fetch(e.requestOptions);
//               return handler.resolve(response);
//             });
//           } catch (refreshError) {
//             print('Refresh Error: $refreshError');
//             await tokenStorage.clearTokens();
//             return handler.reject(e);
//           }
//         } else {
//           return handler.next(e);
//         }
//       } else {
//         return handler.next(e);
//       }
//     },
//   ));
//   return dio;
// }


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
      baseUrl: 'http://37.46.132.144:1337/', // Убедитесь, что используете http или https
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    ),
  );

  // Обход проверки самоподписанного сертификата (остается без изменений)
  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };

  dio.interceptors.add(InterceptorsWrapper(
    // --- onRequest ИЗМЕНЕН ---
    onRequest: (options, handler) async {
      // Получаем наш единственный токен
      final token = await ref.read(tokenStorageProvider).getJwt();

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      print('Request: ${options.method} ${options.uri}');
      return handler.next(options);
    },

    // onResponse остается для логгирования
    onResponse: (response, handler) {
      print('Response: ${response.statusCode} ${response.data}');
      return handler.next(response);
    },

    // --- onError РАДИКАЛЬНО УПРОЩЕН ---
    onError: (DioException e, handler) async {
      print('Error: ${e.message}, Response: ${e.response?.data}, Status: ${e.response?.statusCode}');

      // Логика обновления токена ПОЛНОСТЬЮ УДАЛЕНА.
      // Если пришла ошибка 401, это значит, что токен невалиден.
      // Ваше UI должно обработать это и, например, показать экран логина.
      // Мы просто пробрасываем ошибку дальше.
      if (e.response?.statusCode == 401) {
        // Можно дополнительно очистить токен, чтобы не пытаться снова
        await ref.read(tokenStorageProvider).clearToken();
      }

      return handler.next(e);
    },
  ));
  return dio;
}