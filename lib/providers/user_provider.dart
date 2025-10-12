import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/user.dart';
import '../data/services/api_service.dart';
import '../data/services/token_storage.dart';
import 'auth_state.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  late final ApiService _apiService = ref.read(apiServiceProvider);
  late final TokenStorage _tokenStorage = ref.read(tokenStorageProvider);

  @override
  FutureOr<AuthState> build() async {
    final accessToken = await _tokenStorage.getJwt();

    if (accessToken == null) {
      return const AuthState.unauthenticated();
    }

    try {
      final user = await _apiService.getMe();
      if (user.firstname == user.phone || user.firstname == "Unknown") {
        return AuthState.needsRegistration(user: user);
      } else {
        return AuthState.authenticated(user: user);
      }
    } catch (e) {
      await _tokenStorage.clearToken();
      return const AuthState.unauthenticated();
    }
  }

  Future<void> requestOtp(String phone) async {
    try {
      await _apiService.requestOtp(phone);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyOtpAndLogin(String phone, String otp) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        await _apiService.verifyOtp(phone, otp);
        final user = await _apiService.getMe();

        if (user.firstname == user.phone || user.firstname == "Unknown") {
          return AuthState.needsRegistration(user: user);
        } else {
          return AuthState.authenticated(user: user);
        }
      } catch (e) {
        print('Error verifying OTP or loading user: ${e.toString()}');
        await _tokenStorage.clearToken(); // Очистка токена при ошибке
        return const AuthState
            .unauthenticated(); // Возвращаем дефолтное состояние
      }
    });
  }

  Future<void> updateProfileInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String birthDate,
    required String residence,
    int? directionId,
    int? activityId,
    String? collectiveName,
    String? collectiveCity,
    String? masterName,
    String? educationPlace,
  }) async {
    final currentState = state.value;
    final userId = await _tokenStorage.getUserId();
    if (currentState is! NeedsRegistration && currentState is! Authenticated) {
      throw Exception(
          "Пользователь не аутентифицирован для завершения регистрации.");
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        final updatedUser = await _apiService.updateProfile(
          firstName: firstName,
          lastName: lastName,
          email: email,
          birthDate: birthDate,
          residence: residence,
          directionId: directionId,
          activityId: activityId,
          collectiveName: collectiveName,
          collectiveCity: collectiveCity,
          masterName: masterName,
          educationPlace: educationPlace,
          userId: userId!,
        );
        return AuthState.authenticated(user: updatedUser);
      } catch (e) {
        print('Error updating profile: $e');
        return currentState!;
      }
    });
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await _tokenStorage.clearToken();
      state = const AsyncData(AuthState.unauthenticated());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final userProvider = Provider<User?>(
  (ref) {
    final authState = ref.watch(authNotifierProvider);
    return authState.when(
      data: (state) {
        return state.map(
          authenticated: (authenticatedState) => authenticatedState.user,
          needsRegistration: (needsRegistrationState) =>
              needsRegistrationState.user,
          unauthenticated: (_) => null,
        );
      },
      loading: () => null,
      error: (_, __) => null,
    );
  },
);
