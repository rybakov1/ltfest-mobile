import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:huawei_push/huawei_push.dart' as hms;
import 'package:google_api_availability/google_api_availability.dart';

import '../data/services/api_endpoints.dart';
import '../data/services/api_exception.dart';
import '../data/services/dio_provider.dart';

part 'push_service.g.dart';

@riverpod
PushNotificationService pushNotificationService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return PushNotificationService(dio: dio);
}

class PushNotificationService {
  final Dio _dio;

  PushNotificationService({required Dio dio}) : _dio = dio;

  Future<void> init(int userId) async {
    try {
      if (Platform.isIOS) {
        await _initFirebase(userId, 'ios');
      } else if (Platform.isAndroid) {
        final gmsResult = await GoogleApiAvailability.instance
            .checkGooglePlayServicesAvailability();
        final hasGms = gmsResult == GooglePlayServicesAvailability.success;

        if (hasGms) {
          await _initFirebase(userId, 'android');
        } else {
          await _initHuawei(userId);
        }
      }
    } catch (e) {
      debugPrint('⚠️[PushNotificationService] Initialization error: $e');
    }
  }

  Future<void> _initFirebase(int userId, String platform) async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint(
          '⚠️[PushNotificationService] Notifications permission denied on $platform');
      return;
    }

    final token = await messaging.getToken();
    if (token != null) {
      await _registerTokenOnServer(
        userId: userId,
        token: token,
        provider: 'fcm',
        platform: platform,
      );
    }

    messaging.onTokenRefresh.listen((newToken) {
      _registerTokenOnServer(
        userId: userId,
        token: newToken,
        provider: 'fcm',
        platform: platform,
      );
    });
  }

  Future<void> _initHuawei(int userId) async {
    hms.Push.getTokenStream.listen((String token) {
      _registerTokenOnServer(
        userId: userId,
        token: token,
        provider: 'hms',
        platform: 'android',
      );
    }, onError: (error) {
      debugPrint('❌ [PushNotificationService] HMS Token Error: $error');
    });

    hms.Push.getToken("");
  }

  Future<void> _registerTokenOnServer({
    required int userId,
    required String token,
    required String provider,
    required String platform,
  }) async {
    try {
      final data = {
        'data': {
          'users_permissions_user': userId,
          'token': token,
          'provider': provider,
          'platform': platform,
        }
      };

      if (kDebugMode) {
        debugPrint('📡 [POST] ${ApiEndpoints.pushTokens}');
        debugPrint('Token data: provider=$provider, platform=$platform');
      }

      final response = await _dio.post(ApiEndpoints.pushTokens, data: data);

      // Бэкенд сейчас отвечает 405 (Method Not Allowed) на этот эндпоинт.
      // Чтобы не сыпать ошибками в логи и не ломать поток авторизации,
      // воспринимаем 405 как «фича пока не включена на сервере».
      if (response.statusCode == 405) {
        debugPrint(
            '⚠️ [PushNotificationService] /push-tokens недоступен (405). Токен не сохранён на сервере.');
        return;
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(message: 'Не удалось зарегистрировать push token');
      }
    } catch (e) {
      if (e is DioException) {
        debugPrint(
            '❌ [PushNotificationService] API Error: ${e.response?.data}');
      } else {
        debugPrint('❌ [PushNotificationService] Error: $e');
      }
    }
  }
}
