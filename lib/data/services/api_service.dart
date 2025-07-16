// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'dio_provider.dart';
// import '../models/news.dart';
// import '../models/upcoming_events.dart';
// import '../models/user.dart';
// import '../models/activity.dart';
// import '../models/direction.dart';
// import '../models/festival.dart';
// import '../models/laboratory.dart';
// import '../models/teacher.dart';
// import '../models/jury.dart';
// import 'api_endpoints.dart';
// import 'api_exception.dart';
// import 'token_storage.dart';
//
// part 'api_service.g.dart';
//
// // Кодогенерация: dart run build_runner build --delete-conflicting-outputs
//
// @riverpod
// ApiService apiService(Ref ref) {
//   final dio = ref.watch(dioProvider);
//   final tokenStorage = ref.watch(tokenStorageProvider);
//   return ApiService(dio: dio, tokenStorage: tokenStorage);
// }
//
// class ApiService {
//   final Dio _dio;
//   final TokenStorage _tokenStorage;
//
//   ApiService({required Dio dio, required TokenStorage tokenStorage})
//       : _dio = dio,
//         _tokenStorage = tokenStorage;
//
//   // // OTP: Запрос OTP
//   // Future<void> requestOtp(String phone) async {
//   //   try {
//   //     final response =
//   //         await _dio.post(ApiEndpoints.requestOtp, data: {'phone': phone});
//   //     if (response.statusCode != 200) {
//   //       throw ApiException(
//   //           message: 'Failed to request OTP',
//   //           statusCode: response.statusCode,
//   //           data: response.data);
//   //     }
//   //   } catch (e) {
//   //     throw ApiException.fromDioError(e as DioException);
//   //   }
//   // }
//
//   Future<void> requestOtp(String phone) async {
//     try {
//       final response =
//           await _dio.post(ApiEndpoints.requestOtp, data: {'phone': phone});
//       if (response.statusCode != 200) {
//         throw ApiException(
//             message: 'Failed to request OTP',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//       // final otp = response.data['otp'] as String;
//       // if (otp.isEmpty) throw Exception("OTP не пришел в ответе от сервера.");
//       // return otp;
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // OTP: Подтверждение OTP и получение токенов
//   Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
//     try {
//       final response = await _dio.post(ApiEndpoints.verifyOtp, data: {
//         'phone': phone,
//         'otp': otp,
//       });
//       if (response.statusCode == 200) {
//         final result = {
//           'access_token': response.data['access_token'],
//           'refresh_token': response.data['refresh_token'],
//           'user_id': response.data['user_id'],
//         };
//         await _tokenStorage.saveTokens(
//           accessToken: result['access_token'],
//           refreshToken: result['refresh_token'],
//         );
//         return result;
//       } else {
//         throw ApiException(
//             message: 'Failed to verify OTP',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Обновление токена
//   Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
//     try {
//       final response = await _dio.post(ApiEndpoints.refreshToken, data: {
//         'refresh_token': refreshToken,
//       });
//       if (response.statusCode == 200) {
//         return {
//           'access_token': response.data['access_token'],
//           'refresh_token': response.data['refresh_token'],
//         };
//       } else {
//         throw ApiException(
//             message: 'Failed to refresh token',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Пользователи: Получение текущего пользователя
//   Future<User> getMe() async {
//     try {
//       final response = await _dio.get(ApiEndpoints.me);
//       if (response.statusCode == 200) {
//         return User.fromJson(response.data);
//       } else {
//         throw ApiException(
//             message: 'Failed to load current user',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Пользователи: Обновление текущего пользователя
//   Future<User> updateProfile({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String birthDate,
//     required String residence,
//     required int directionId,
//     required int activityId,
//     String? collectiveName,
//     String? collectiveCity,
//     int? bonuses,
//   }) async {
//     try {
//       final response = await _dio.put(
//         ApiEndpoints.me,
//         data: {
//           'firstname': firstName,
//           'lastname': lastName,
//           'email': email,
//           'birthdate': birthDate,
//           'residence': residence,
//           'directionid': directionId,
//           'activityid': activityId,
//           'collectivename': collectiveName,
//           'collectivecity': collectiveCity,
//           'bonuses': 0,
//         },
//       );
//       print(response);
//       if (response.statusCode == 200) {
//         return User.fromJson(response.data);
//       } else {
//         throw ApiException(
//             message: 'Failed to update user profile',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Пользователи: GET списка всех и POST для регистрации
//   Future<List<User>> getUsers() async {
//     try {
//       final response = await _dio.get(ApiEndpoints.users);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         return data.map((json) => User.fromJson(json)).toList();
//       } else {
//         throw ApiException(
//             message: 'Failed to load users',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   Future<User> registerUser(User user) async {
//     try {
//       final response = await _dio.post(
//         ApiEndpoints.users,
//         data: jsonEncode(user.toJson()),
//       );
//       if (response.statusCode == 201) {
//         return User.fromJson(response.data);
//       } else {
//         throw ApiException(
//             message: 'Failed to register user',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Избранное: Добавление фестиваля в избранное
//   Future<void> addFavourite(int festivalId) async {
//     try {
//       final response = await _dio.post(
//         ApiEndpoints.favourites,
//         data: {
//           'festival_id': festivalId,
//         },
//       );
//       if (response.statusCode != 200) {
//         throw ApiException(
//             message: 'Failed to add favourite',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Активности: Только GET
//   Future<List<Activity>> getActivities() async {
//     try {
//       final response = await _dio.get(ApiEndpoints.activities);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         return data.map((json) => Activity.fromJson(json)).toList();
//       } else {
//         throw ApiException(
//             message: 'Failed to load activities',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Направления: Только GET
//   Future<List<Direction>> getDirections() async {
//     try {
//       final response = await _dio.get(ApiEndpoints.directions);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         return data.map((json) => Direction.fromJson(json)).toList();
//       } else {
//         throw ApiException(
//             message: 'Failed to load directions',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Фестивали
//   Future<List<Festival>> getFestivals({String? direction}) async {
//     try {
//       final response = await _dio.get(
//         ApiEndpoints.festivals,
//         queryParameters: direction != null ? {'direction': direction} : null,
//       );
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         return data.map((json) => Festival.fromJson(json)).toList();
//       } else {
//         throw ApiException(
//             message: 'Failed to load festivals',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   Future<Festival> getFestivalById(String id) async {
//     try {
//       final response = await _dio.get(ApiEndpoints.festivalById(id));
//       if (response.statusCode == 200) {
//         return Festival.fromJson(response.data);
//       } else {
//         throw ApiException(
//             message: 'Failed to load festival: $id',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Лаборатории
//   Future<List<Laboratory>> getLaboratories({String? direction}) async {
//     try {
//       final response = await _dio.get(
//         ApiEndpoints.laboratories,
//         queryParameters: direction != null ? {'direction': direction} : null,
//       );
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         return data.map((json) => Laboratory.fromJson(json)).toList();
//       } else {
//         throw ApiException(
//             message: 'Failed to load laboratories',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   Future<Laboratory> getLaboratoryById(String id) async {
//     try {
//       final response = await _dio.get(ApiEndpoints.laboratoryById(id));
//       if (response.statusCode == 200) {
//         return Laboratory.fromJson(response.data);
//       } else {
//         throw ApiException(
//             message: 'Failed to load laboratory: $id',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Учителя: Только GET
//   Future<List<Teacher>> getTeachers() async {
//     try {
//       final response = await _dio.get(ApiEndpoints.teachers);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         return data.map((json) => Teacher.fromJson(json)).toList();
//       } else {
//         throw ApiException(
//             message: 'Failed to load teachers',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Жюри: Только GET
//   Future<List<Jury>> getJury() async {
//     try {
//       final response = await _dio.get(ApiEndpoints.jury);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         return data.map((json) => Jury.fromJson(json)).toList();
//       } else {
//         throw ApiException(
//             message: 'Failed to load jury',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // События
//   Future<List<UpcomingEvent>> fetchUpcomingEvents() async {
//     try {
//       final response = await _dio.get(ApiEndpoints.upcomingEvents);
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonList = response.data;
//         return jsonList.map((json) => UpcomingEvent.fromJson(json)).toList();
//       } else {
//         throw ApiException(
//             message: 'Failed to load events',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Новости
//   Future<List<News>> getNews() async {
//     try {
//       final response = await _dio.get(ApiEndpoints.news);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         return data.map((json) => News.fromJson(json)).toList();
//       } else {
//         throw ApiException(
//             message: 'Failed to load news',
//             statusCode: response.statusCode,
//             data: response.data);
//       }
//     } catch (e) {
//       throw ApiException.fromDioError(e as DioException);
//     }
//   }
//
//   // Получение полного URL для изображения
//   String getImageUrl(String? imagePath) {
//     if (imagePath == null || imagePath.isEmpty) {
//       return ''; // Или путь к заглушке
//     }
//     return '${_dio.options.baseUrl}images/$imagePath';
//   }
// }
// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dio_provider.dart';
import '../models/news.dart';
import '../models/upcoming_events.dart';
import '../models/user.dart';
import '../models/activity.dart';
import '../models/direction.dart';
import '../models/festival.dart';
import '../models/laboratory.dart';
import '../models/teacher.dart';
import '../models/jury.dart';
import 'api_endpoints.dart';
import 'api_exception.dart';
import 'token_storage.dart';

part 'api_service.g.dart';

// Кодогенерация: dart run build_runner build --delete-conflicting-outputs

@riverpod
ApiService apiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  return ApiService(dio: dio, tokenStorage: tokenStorage);
}

class ApiService {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  ApiService({required Dio dio, required TokenStorage tokenStorage})
      : _dio = dio,
        _tokenStorage = tokenStorage;

  // Вспомогательный метод для обработки ошибок
  Never _handleError(Object e) {
    if (e is DioException) {
      throw ApiException.fromDioError(e);
    }
    // Для других типов ошибок
    throw ApiException(message: e.toString());
  }

  // --- АУТЕНТИФИКАЦИЯ ---

  /// Запрос OTP (теперь это phoneLoginOrRegister)
  Future<void> requestOtp(String phone) async {
    try {
      // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Используется новый эндпоинт из ApiEndpoints
      final response = await _dio.post(ApiEndpoints.requestOtp, data: {'phone': phone});
      if (response.statusCode != 200) {
        throw ApiException(
            message: response.data['error']?['message'] ?? 'Failed to request OTP',
            statusCode: response.statusCode);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  /// Подтверждение OTP и получение JWT токена
  Future<User> verifyOtp(String phone, String otp) async {
    try {
      // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Используется новый эндпоинт для верификации
      final response = await _dio.post(ApiEndpoints.verifyOtp, data: {
        'phone': phone,
        'otp': otp,
      });

      if (response.statusCode == 200) {
        // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Strapi возвращает 'jwt' и вложенный объект 'user'
        final jwt = response.data['jwt'] as String;
        final userData = response.data['user'] as Map<String, dynamic>;

        // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Сохраняем единственный токен с помощью нового метода
        await _tokenStorage.saveToken(jwt: jwt);

        // Возвращаем модель пользователя, созданную из полученных данных
        return User.fromJson(userData);
      } else {
        throw ApiException(
            message: response.data['error']?['message'] ?? 'Failed to verify OTP',
            statusCode: response.statusCode);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  // --- ПОЛЬЗОВАТЕЛИ ---

  /// Получение данных о текущем пользователе
  Future<User> getMe() async {
    try {
      // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Добавляем populate для загрузки связанных данных
      final response = await _dio.get(
        ApiEndpoints.me,
        queryParameters: {'populate': '*'},
      );
      if (response.statusCode == 200) {
        // Эндпоинт /api/users/me не оборачивает ответ в 'data',
        // поэтому мы можем напрямую парсить его. Убедитесь, что
        // ваша модель User.fromJson может обрабатывать это.
        return User.fromJson(response.data);
      } else {
        throw ApiException(
            message: 'Failed to load current user',
            statusCode: response.statusCode);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  /// Обновление профиля текущего пользователя
  Future<User> updateProfile({
    required int userId, // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Нужен ID для обновления
    required String firstName,
    required String lastName,
    required String email,
    required String birthDate,
    required String residence,
    int? directionId, // Связи могут быть null
    int? activityId,
    String? collectiveName,
    String? collectiveCity,
  }) async {
    try {
      // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Формируем эндпоинт для конкретного пользователя
      final endpoint = ApiEndpoints.userById(userId);

      // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Strapi ожидает данные в обертке 'data'
      final payload = {
        'data': {
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
          'birthdate': birthDate,
          'residence': residence,
          // Для связей передаем только ID.
          // Убедитесь, что названия полей совпадают с API ID в Strapi.
          'direction': directionId,
          'activity': activityId,
          'collectivename': collectiveName,
          'collectivecity': collectiveCity,
        }
      };

      final response = await _dio.put(endpoint, data: payload);

      if (response.statusCode == 200) {
        // Ответ от Strapi также обернут в 'data'
        return User.fromJson(response.data['data']);
      } else {
        throw ApiException(
            message: 'Failed to update user profile',
            statusCode: response.statusCode);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  // --- ОБЩИЕ МЕТОДЫ ДЛЯ ПОЛУЧЕНИЯ ДАННЫХ ---

  /// Универсальный метод для получения списка элементов из коллекции Strapi
  Future<List<T>> _fetchCollection<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    try {
      // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Всегда запрашиваем связанные данные с `populate`
      final response = await _dio.get(endpoint, queryParameters: {'populate': '*'});

      if (response.statusCode == 200) {
        // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Извлекаем список из `response.data['data']`
        final List<dynamic> data = response.data['data'];
        return data.map((json) => fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw ApiException(message: 'Failed to load collection $endpoint');
      }
    } catch (e) {
      _handleError(e);
    }
  }

  /// Универсальный метод для получения одного элемента по ID
  Future<T> _fetchOne<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: {'populate': '*'});
      if (response.statusCode == 200) {
        // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Извлекаем объект из `response.data['data']`
        final data = response.data['data'] as Map<String, dynamic>;
        return fromJson(data);
      } else {
        throw ApiException(message: 'Failed to load item $endpoint');
      }
    } catch (e) {
      _handleError(e);
    }
  }

  // --- КОНКРЕТНЫЕ МЕТОДЫ API ---

  // Используем универсальные методы для чистоты кода
  Future<List<Activity>> getActivities() => _fetchCollection(ApiEndpoints.activities, Activity.fromJson);
  Future<List<Direction>> getDirections() => _fetchCollection(ApiEndpoints.directions, Direction.fromJson);
  Future<List<Festival>> getFestivals() => _fetchCollection(ApiEndpoints.festivals, Festival.fromJson);
  Future<Festival> getFestivalById(String id) => _fetchOne(ApiEndpoints.festivalById(id), Festival.fromJson);
  Future<List<Laboratory>> getLaboratories() => _fetchCollection(ApiEndpoints.laboratories, Laboratory.fromJson);
  Future<Laboratory> getLaboratoryById(String id) => _fetchOne(ApiEndpoints.laboratoryById(id), Laboratory.fromJson);
  Future<List<Teacher>> getTeachers() => _fetchCollection(ApiEndpoints.teachers, Teacher.fromJson);
  Future<List<Jury>> getJury() => _fetchCollection(ApiEndpoints.jury, Jury.fromJson);
  Future<List<News>> getNews() => _fetchCollection(ApiEndpoints.news, News.fromJson);
  Future<List<UpcomingEvent>> fetchUpcomingEvents() => _fetchCollection(ApiEndpoints.upcomingEvents, UpcomingEvent.fromJson);


  // --- ИЗБРАННОЕ ---

  /// Добавление фестиваля в избранное
  Future<void> addFavourite({required int userId, required int festivalId}) async {
    try {
      // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: При создании связи нужно передать ID пользователя и ID фестиваля
      final payload = {
        'data': {
          'user': userId,
          'festival': festivalId,
        }
      };
      final response = await _dio.post(ApiEndpoints.favourites, data: payload);
      if (response.statusCode != 200) {
        throw ApiException(message: 'Failed to add favourite');
      }
    } catch (e) {
      _handleError(e);
    }
  }

  // --- URL ИЗОБРАЖЕНИЙ ---

  /// Получение полного URL для изображения из Strapi
  String getImageUrl(String? relativeUrl) {
    if (relativeUrl == null || relativeUrl.isEmpty) {
      return ''; // Или URL к изображению-заглушке
    }
    // КЛЮЧЕВОЕ ИЗМЕНЕНИЕ: Просто добавляем базовый URL.
    // Убедитесь, что в dio.options.baseUrl нет слеша в конце.
    // Пример: 'http://localhost:1337'
    return '${_dio.options.baseUrl}$relativeUrl';
  }
}