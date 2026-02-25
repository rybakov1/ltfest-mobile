import 'dart:async';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../data/models/user.dart';
import '../data/services/api_service.dart';
import '../data/services/token_storage.dart';
import '../notifications/push_service.dart';
import 'auth_state.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  late final ApiService _apiService = ref.read(apiServiceProvider);
  late final TokenStorage _tokenStorage = ref.read(tokenStorageProvider);
  late final PushNotificationService _pushService = ref.read(pushNotificationServiceProvider);

  @override
  FutureOr<AuthState> build() async {
    final start = DateTime.now();
    ref.watch(authInvalidationProvider);
    final accessToken = await _tokenStorage.getJwt();
    AuthState state;

    if (accessToken == null) {
      state = const AuthState.unauthenticated();
      Sentry.configureScope((scope) => scope.setUser(null));
    } else {
      try {
        final user = await _apiService.getMe();
        _pushService.init(user.id);

        if (user.firstname == user.phone || user.firstname == "Unknown") {
          state = AuthState.needsRegistration(user: user);
        } else {
          state = AuthState.authenticated(user: user);
          Sentry.configureScope((scope) {
            scope.setUser(SentryUser(
              id: user.id.toString(),
              email: user.email,
              username: user.phone,
              data: {
                'name': user.firstname,
              },
            ));
          });
        }
      } catch (e) {
        if (e is DioException &&
            (e.response?.statusCode == 401 || e.response?.statusCode == 403)) {
          await _tokenStorage.clearToken();
          state = const AuthState.unauthenticated();
          Sentry.configureScope((scope) => scope.setUser(null));
        } else {
          state = const AuthState.unauthenticated();
          Sentry.configureScope((scope) => scope.setUser(null));
        }
      }
    }

    final elapsed = DateTime.now().difference(start);
    const minSplashTime = Duration(milliseconds: 1500);
    if (elapsed < minSplashTime) {
      await Future.delayed(minSplashTime - elapsed);
    }

    return state;
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
        _pushService.init(user.id);
        if (user.firstname == user.phone || user.firstname == "Unknown") {
          return AuthState.needsRegistration(user: user);
        } else {
          // Sentry User Context
          Sentry.configureScope((scope) {
            scope.setUser(SentryUser(
              id: user.id.toString(),
              email: user.email,
              username: user.phone,
              data: {
                'name': user.firstname,
              },
            ));
          });
          return AuthState.authenticated(user: user);
        }
      } catch (e) {
        Sentry.captureException(e, stackTrace: StackTrace.current);
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
    int? activityId,
    String? collectiveName,
    String? collectiveCity,
    String? masterName,
    String? educationPlace,
    int? countParticipant,
    int? ageCategoryId,
  }) async {
    final currentState = state.value;
    final userId = await _tokenStorage.getUserId();
    if (currentState is! NeedsRegistration && currentState is! Authenticated) {
      throw Exception(
          "Пользователь не аутентифицирован для завершения регистрации.");
    }

    state = await AsyncValue.guard(() async {
      try {
        final updatedUser = await _apiService.updateProfile(
          firstName: firstName,
          lastName: lastName,
          email: email,
          birthDate: birthDate,
          residence: residence,
          activityId: activityId,
          collectiveName: collectiveName,
          collectiveCity: collectiveCity,
          masterName: masterName,
          educationPlace: educationPlace,
          countParticipant: countParticipant,
          ageCategoryId: ageCategoryId,
          userId: userId!,
        );

        Sentry.configureScope((scope) {
          scope.setUser(SentryUser(
            id: updatedUser.id.toString(),
            email: updatedUser.email,
            username: updatedUser.phone,
            data: {
              'name': updatedUser.firstname,
            },
          ));
        });

        return AuthState.authenticated(user: updatedUser);
      } catch (e, stackTrace) {
        print('Error updating profile: $e');
        Sentry.captureException(e, stackTrace: stackTrace);
        return currentState!;
      }
    });
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await _tokenStorage.clearToken();
      state = const AsyncData(AuthState.unauthenticated());
      Sentry.configureScope((scope) => scope.setUser(null));
    } catch (e, st) {
      state = AsyncError(e, st);
      Sentry.captureException(e, stackTrace: st);
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
