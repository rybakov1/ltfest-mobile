import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/ltstory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/ltbanner.dart';
import 'dio_provider.dart';
import '../models/news.dart';
import '../models/upcoming_events.dart';
import '../models/user.dart';
import '../models/activity.dart';
import '../models/direction.dart';
import '../models/festival.dart';
import '../models/laboratory.dart';
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

  Never _handleError(Object e) {
    if (e is DioException) {
      print(e.error);
      throw ApiException.fromDioError(e);
    }
    print(e.toString());
    throw ApiException(message: e.toString());
  }

  Future<void> requestOtp(String phone) async {
    try {
      final response =
          await _dio.post(ApiEndpoints.sendOtp, data: {"phone": phone});
      if (response.statusCode != 200) {
        throw ApiException(
            message:
                response.data['error']?['message'] ?? 'Failed to request OTP',
            statusCode: response.statusCode);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<User> verifyOtp(String phone, String code) async {
    try {
      final response = await _dio.post(ApiEndpoints.verifyOtp, data: {
        'phone': phone,
        'code': code,
      }, queryParameters: {
        'populate': '*'
      });

      if (response.statusCode == 200) {
        final jwt = response.data['jwt'] as String?;
        final userData = response.data['user'] as Map<String, dynamic>?;

        if (jwt == null || userData == null) {
          throw ApiException(
              message: 'Invalid response: Missing jwt or user data');
        }

        await _tokenStorage.saveToken(jwt: jwt);
        return User.fromJson(userData);
      } else {
        throw ApiException(
            message:
                response.data['error']?['message'] ?? 'Failed to verify OTP',
            statusCode: response.statusCode);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  // Future<User> verifyOtp(String phone, String code) async {
  //   try {
  //     final response = await _dio.post(ApiEndpoints.verifyOtp, data: {
  //       'phone': phone,
  //       'code': code,
  //     }, queryParameters: {'populate': '*'});
  //
  //     if (response.statusCode == 200) {
  //       final jwt = response.data['jwt'] as String;
  //       final userData = response.data['user'] as Map<String, dynamic>;
  //
  //       await _tokenStorage.saveToken(jwt: jwt);
  //
  //       return User.fromJson(userData);
  //     } else {
  //       throw ApiException(
  //           message:
  //               response.data['error']?['message'] ?? 'Failed to verify OTP',
  //           statusCode: response.statusCode);
  //     }
  //   } catch (e) {
  //     _handleError(e);
  //   }
  // }
  Future<User> getMe() async {
    try {
      final response = await _dio.get(ApiEndpoints.me);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          throw ApiException(message: 'Invalid response: No data found');
        }
        if (data is! Map<String, dynamic>) {
          throw ApiException(
              message:
                  'Invalid response format: Expected a Map, got ${data.runtimeType}');
        }
        print('Response data: $data'); // Для отладки
        return User.fromJson(data);
      } else {
        throw ApiException(
            message: 'Failed to load current user',
            statusCode: response.statusCode);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  // Future<User> getMe() async {
  //   try {
  //     final response = await _dio.get(ApiEndpoints.me, queryParameters: {'populate': '*'});
  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       return User.fromJson(data);
  //     } else {
  //       throw ApiException(
  //           message: 'Failed to load current user',
  //           statusCode: response.statusCode);
  //     }
  //   } catch (e) {
  //     _handleError(e);
  //   }
  // }

  // Future<User> getMe() async {
  //   try {
  //     final response =
  //         await _dio.get(ApiEndpoints.me, queryParameters: {'populate': '*'});
  //     if (response.statusCode == 200) {
  //       return User.fromJson(response.data);
  //     } else {
  //       throw ApiException(
  //           message: 'Failed to load current user',
  //           statusCode: response.statusCode);
  //     }
  //   } catch (e) {
  //     _handleError(e);
  //   }
  // }

  Future<User> updateProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String email,
    required String birthDate,
    required String residence,
    int? directionId,
    int? activityId,
    String? collectiveName,
    String? collectiveCity,
    String? educationPlace,
    String? masterName,
  }) async {
    try {
      final endpoint = ApiEndpoints.userById(userId);

      final data = {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'birthdate': birthDate,
        'residence': residence,
        'direction': directionId,
        'activity': activityId,
        'collectiveName': collectiveName,
        'collectiveCity': collectiveCity,
        'educationPlace': educationPlace,
        'masterName': masterName,
      };

      final response = await _dio.put(endpoint, data: data);

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw ApiException(
            message: 'Failed to update user profile',
            statusCode: response.statusCode);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<List<T>> _fetchCollection<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: {'populate': '*'});

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(message: 'Failed to load collection $endpoint');
      }
    } catch (e) {
      _handleError(e);
    }
  }

  // Future<T> _fetchOne<T>(
  //     String endpoint, T Function(Map<String, dynamic>) fromJson) async {
  //   try {
  //     final response = await _dio.get(endpoint, queryParameters: {'populate': '*'});
  //     if (response.statusCode == 200) {
  //       final data = response.data['data'] as Map<String, dynamic>;
  //       return fromJson(data);
  //     } else {
  //       throw ApiException(message: 'Failed to load item $endpoint');
  //     }
  //   } catch (e) {
  //     _handleError(e);
  //   }
  // }

  Future<T> _fetchOneWithArrayWithoutPopulate<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'];
        final Map<String, dynamic> festivalData = dataList[0];

        return fromJson(festivalData);
      } else {
        throw ApiException(message: 'Failed to load item $endpoint');
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<T> _fetchOneWithArray<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: {'populate': '*'});

      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'];
        final Map<String, dynamic> festivalData = dataList[0];

        return fromJson(festivalData);
      } else {
        throw ApiException(message: 'Failed to load item $endpoint');
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<List<Activity>> getActivities() =>
      _fetchCollection(ApiEndpoints.activities, Activity.fromJson);

  Future<List<Direction>> getDirections() =>
      _fetchCollection(ApiEndpoints.directions, Direction.fromJson);

  Future<List<Festival>> getFestivals() =>
      _fetchCollection(ApiEndpoints.festivals, Festival.fromJson);

  Future<List<LTStory>> getLTStories() =>
      _fetchCollection(ApiEndpoints.stories, LTStory.fromJson);

  Future<Festival> getFestivalById(String id) =>
      _fetchOneWithArrayWithoutPopulate(
          ApiEndpoints.festivalById(id), Festival.fromJson);

  Future<List<Laboratory>> getLaboratories() =>
      _fetchCollection(ApiEndpoints.laboratories, Laboratory.fromJson);

  Future<Laboratory> getLaboratoryById(String id) =>
      _fetchOneWithArrayWithoutPopulate(
          ApiEndpoints.laboratoryById(id), Laboratory.fromJson);

  Future<List<Laboratory>> getLaboratoriesByDirection(String direction) =>
      _fetchCollection(
          ApiEndpoints.laboratoriesByDirection(direction), Laboratory.fromJson);

  Future<List<Festival>> getFestivalsByDirection(String direction) =>
      _fetchCollection(
          ApiEndpoints.festivalsByDirection(direction), Festival.fromJson);

  Future<News> getNewsById(String id) =>
      _fetchOneWithArray(ApiEndpoints.newsById(id), News.fromJson);

  Future<List<LTBanner>> getBanners() =>
      _fetchCollection(ApiEndpoints.banners, LTBanner.fromJson);

  Future<List<News>> getNews() =>
      _fetchCollection(ApiEndpoints.news, News.fromJson);

  Future<List<UpcomingEvent>> fetchUpcomingEvents() =>
      _fetchCollection(ApiEndpoints.upcomingEvents, UpcomingEvent.fromJson);

  // Future<void> addFavourite(
  //     {required int userId, required int festivalId}) async {
  //   try {
  //     final payload = {
  //       'data': {
  //         'user': userId,
  //         'festival': festivalId,
  //       }
  //     };
  //     final response = await _dio.post(ApiEndpoints.favourites, data: payload);
  //     if (response.statusCode != 200) {
  //       throw ApiException(message: 'Failed to add favourite');
  //     }
  //   } catch (e) {
  //     _handleError(e);
  //   }
  // }

  // Future<void> addFavoriteFestival(int festivalId) async {
  //   try {
  //     final response = await _dio.put(ApiEndpoints.me, data: {
  //       'favourites_festivals': {'connect': [festivalId]},
  //     });
  //     if (response.statusCode != 200) {
  //       throw ApiException(message: 'Failed to add favorite festival');
  //     }
  //   } catch (e) {
  //     _handleError(e);
  //   }
  // }
  //
  // Future<void> removeFavoriteFestival(int festivalId) async {
  //   try {
  //     final response = await _dio.put(ApiEndpoints.me, data: {
  //       'favourites_festivals': {'disconnect': [festivalId]},
  //     });
  //     if (response.statusCode != 200) {
  //       throw ApiException(message: 'Failed to remove favorite festival');
  //     }
  //   } catch (e) {
  //     _handleError(e);
  //   }
  // }
  //
  // Future<void> addFavoriteLaboratory(int laboratoryId) async {
  //   try {
  //     final response = await _dio.put(ApiEndpoints.me, data: {
  //       'favourites_laboratories': {'connect': [laboratoryId]},
  //     });
  //     if (response.statusCode != 200) {
  //       throw ApiException(message: 'Failed to add favorite laboratory');
  //     }
  //   } catch (e) {
  //     _handleError(e);
  //   }
  // }
  //
  // Future<void> removeFavoriteLaboratory(int laboratoryId) async {
  //   try {
  //     final response = await _dio.put(ApiEndpoints.me, data: {
  //       'favourites_laboratories': {'disconnect': [laboratoryId]},
  //     });
  //     if (response.statusCode != 200) {
  //       throw ApiException(message: 'Failed to remove favorite laboratory');
  //     }
  //   } catch (e) {
  //     _handleError(e);
  //   }
  // }

  Future<void> addFavoriteFestival(int userId, int festivalId) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.userById(userId),
        data: {
          'favourites_festivals': {
            'connect': [festivalId]
          }
        },
      );
      if (response.statusCode! ~/ 100 != 2) {
        // Проверяем 2xx
        throw ApiException(
            message:
                'Failed to add favorite festival: ${response.statusMessage}');
      }
      print('Added favorite festival, response: ${response.data}');
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> removeFavoriteFestival(int userId, int festivalId) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.userById(userId),
        data: {
          'favourites_festivals': {
            'disconnect': [festivalId]
          }
        },
      );
      if (response.statusCode! ~/ 100 != 2) {
        throw ApiException(
            message:
                'Failed to remove favorite festival: ${response.statusMessage}');
      }
      print('Removed favorite festival, response: ${response.data}');
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> addFavoriteLaboratory(int userId, int laboratoryId) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.userById(userId),
        data: {
          'favourites_laboratories': {
            'connect': [laboratoryId]
          }
        },
      );
      if (response.statusCode! ~/ 100 != 2) {
        throw ApiException(
            message:
                'Failed to add favorite laboratory: ${response.statusMessage}');
      }
      print('Added favorite laboratory, response: ${response.data}');
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> removeFavoriteLaboratory(int userId, int laboratoryId) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.userById(userId),
        data: {
          'favourites_laboratories': {
            'disconnect': [laboratoryId]
          }
        },
      );
      if (response.statusCode! ~/ 100 != 2) {
        throw ApiException(
            message:
                'Failed to remove favorite laboratory: ${response.statusMessage}');
      }
      print('Removed favorite laboratory, response: ${response.data}');
    } catch (e) {
      _handleError(e);
    }
  }

  String getImageUrl(String? relativeUrl) {
    if (relativeUrl == null || relativeUrl.isEmpty) {
      return '';
    }
    return '${_dio.options.baseUrl}$relativeUrl';
  }
}
