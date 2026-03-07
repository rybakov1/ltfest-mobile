import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:huawei_push/huawei_push.dart' as hms;
import 'package:google_api_availability/google_api_availability.dart';

import '../data/repositories/misc_repository.dart';

part 'push_service.g.dart';

@riverpod
PushNotificationService pushNotificationService(Ref ref) {
  final miscRepo = ref.watch(miscRepositoryProvider);
  return PushNotificationService(miscRepo: miscRepo);
}

class PushNotificationService {
  final MiscRepository _miscRepo;

  PushNotificationService({required MiscRepository miscRepo})
      : _miscRepo = miscRepo;

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

    if (Platform.isIOS) {
      // На iOS FCM-токен зависит от APNs-токена.
      // Ждём до 10 секунд пока APNs-токен станет доступен.
      String? apnsToken;
      for (var i = 0; i < 10; i++) {
        apnsToken = await messaging.getAPNSToken();
        if (apnsToken != null) break;
        await Future.delayed(const Duration(seconds: 1));
      }
      if (apnsToken == null) {
        debugPrint(
            '⚠️[PushNotificationService] APNs token not available after waiting.');
      }
    }

    final token = await messaging.getToken();
    if (token != null) {
      await _registerToken(
        userId: userId,
        token: token,
        provider: 'fcm',
        platform: platform,
      );
    } else {
      debugPrint(
          '⚠️[PushNotificationService] FCM token is null on $platform');
    }

    messaging.onTokenRefresh.listen((newToken) {
      _registerToken(
        userId: userId,
        token: newToken,
        provider: 'fcm',
        platform: platform,
      );
    });
  }

  Future<void> _initHuawei(int userId) async {
    hms.Push.getTokenStream.listen((String token) {
      _registerToken(
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

  Future<void> _registerToken({
    required int userId,
    required String token,
    required String provider,
    required String platform,
  }) async {
    try {
      await _miscRepo.registerPushToken(
        userId: userId,
        token: token,
        provider: provider,
        platform: platform,
      );
    } catch (e) {
      debugPrint('❌ [PushNotificationService] Error: $e');
    }
  }
}
