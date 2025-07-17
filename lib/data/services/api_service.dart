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
          await _dio.post(ApiEndpoints.sendOtp, data: {'phone': phone});
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
      });

      if (response.statusCode == 200) {
        final jwt = response.data['jwt'] as String;
        final userData = response.data['user'] as Map<String, dynamic>;

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

  Future<User> getMe() async {
    try {
      final response = await _dio.get(ApiEndpoints.me);
      if (response.statusCode == 200) {
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
  }) async {
    try {
      final endpoint = ApiEndpoints.userById(userId);

      final data = {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'birthdate': birthDate,
        'residence': residence,
        // 'direction': directionId,
        // 'activity': activityId,
        'collectiveName': collectiveName,
        'collectiveCity': collectiveCity,
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

  Future<Festival> getFestivalById(String id) =>
      _fetchOneWithArray(ApiEndpoints.festivalById(id), Festival.fromJson);

  Future<List<Laboratory>> getLaboratories() =>
      _fetchCollection(ApiEndpoints.laboratories, Laboratory.fromJson);

  Future<Laboratory> getLaboratoryById(String id) =>
      _fetchOneWithArray(ApiEndpoints.laboratoryById(id), Laboratory.fromJson);

  Future<News> getNewsById(String id) =>
      _fetchOneWithArray(ApiEndpoints.newsById(id), News.fromJson);

  Future<List<News>> getNews() =>
      _fetchCollection(ApiEndpoints.news, News.fromJson);

  Future<List<UpcomingEvent>> fetchUpcomingEvents() =>
      _fetchCollection(ApiEndpoints.upcomingEvents, UpcomingEvent.fromJson);

  Future<void> addFavourite(
      {required int userId, required int festivalId}) async {
    try {
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

  String getImageUrl(String? relativeUrl) {
    if (relativeUrl == null || relativeUrl.isEmpty) {
      return '';
    }
    return '${_dio.options.baseUrl}$relativeUrl';
  }
}
