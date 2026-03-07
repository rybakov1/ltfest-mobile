import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../models/user.dart';
import '../services/api_endpoints.dart';
import '../services/api_exception.dart';
import '../services/token_storage.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(apiClientProvider),
    ref.watch(tokenStorageProvider),
  );
});

class AuthRepository with ApiErrorHandler {
  final ApiClient _client;
  final TokenStorage _tokenStorage;

  AuthRepository(this._client, this._tokenStorage);

  Future<void> requestOtp(String phone) async {
    try {
      await _client.requestOtp({'phone': phone});
    } catch (e) {
      handleError(e);
    }
  }

  Future<User> verifyOtp(String phone, String code) async {
    try {
      final response = await _client.verifyOtp(
        {'phone': phone, 'code': code},
        {'populate': '*'},
      );

      final jwt = response['jwt'] as String?;
      final userData = response['user'] as Map<String, dynamic>?;
      if (jwt == null || userData == null) {
        throw ApiException(message: 'Invalid response: Missing jwt or user data');
      }

      await _tokenStorage.saveToken(jwt: jwt, serverBaseUrl: ApiEndpoints.baseStrapiUrl);
      return User.fromJson(userData);
    } catch (e) {
      handleError(e);
    }
  }

  Future<User> getMe() async {
    try {
      final response = await _client.getMe({
        'populate[0]': 'direction',
        'populate[1]': 'activity',
        'populate[2]': 'age_category',
      });
      return User.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      handleError(e);
    }
  }

  Future<User> updateProfile({
    required int userId,
    required String firstName,
    required String lastName,
    required String email,
    required String birthDate,
    required String residence,
    int? activityId,
    int? ageCategoryId,
    int? countParticipant,
    String? collectiveName,
    String? collectiveCity,
    String? educationPlace,
    String? masterName,
  }) async {
    try {
      final response = await _client.updateUser(userId, {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'birthdate': birthDate,
        'residence': residence,
        'activity': activityId,
        'collectiveName': collectiveName,
        'collectiveCity': collectiveCity,
        'educationPlace': educationPlace,
        'count_participant': countParticipant,
        'age_category': ageCategoryId,
        'masterName': masterName,
      });
      return User.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> createAccountDeletionRequest({
    required int userId,
    required String reason,
  }) async {
    try {
      await _client.createAccountDeletionRequest({
        'data': {
          'users_permissions_user': userId,
          'reason': reason,
          'request_status': 'pending',
        }
      });
    } catch (e) {
      handleError(e);
    }
  }
}
