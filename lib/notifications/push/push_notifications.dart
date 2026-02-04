import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:huawei_push/huawei_push.dart' as hms;

class PushMessage {
  final String? title;
  final String? body;
  final Map<String, dynamic> data;

  const PushMessage({this.title, this.body, required this.data});
}

class PushToken {
  final String value;
  final String provider;

  const PushToken({required this.value, required this.provider});
}

class PushNotifications {
  static final _messagesController = StreamController<PushMessage>.broadcast();
  static final _tokenController = StreamController<PushToken>.broadcast();

  static Stream<PushMessage> get messages => _messagesController.stream;
  static Stream<PushToken> get tokens => _tokenController.stream;

  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    await _initLocalNotifications();
    await _initFcm();
    await _initHms();
  }

  static Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('launcher_icon');
    const iosSettings = DarwinInitializationSettings();

    const settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload == null || payload.isEmpty) return;
        _messagesController.add(PushMessage(title: null, body: null, data: {
          'payload': payload,
        }));
      },
    );

    if (Platform.isAndroid) {
      final android = _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await android?.requestNotificationsPermission();

      const channel = AndroidNotificationChannel(
        'default',
        'Default',
        description: 'Default notifications',
        importance: Importance.high,
      );
      await android?.createNotificationChannel(channel);
    }

    if (Platform.isIOS) {
      final ios = _localNotifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      await ios?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  static Future<void> _initFcm() async {
    if (!Platform.isAndroid && !Platform.isIOS) return;

    try {
      await Firebase.initializeApp();
    } catch (_) {
      return;
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(alert: true, badge: true, sound: true);

    final token = await messaging.getToken();
    if (token != null && token.isNotEmpty) {
      _tokenController.add(PushToken(provider: 'fcm', value: token));
    }

    messaging.onTokenRefresh.listen((t) {
      if (t.isNotEmpty) {
        _tokenController.add(PushToken(provider: 'fcm', value: t));
      }
    });

    FirebaseMessaging.onMessage.listen((message) async {
      final title = message.notification?.title;
      final body = message.notification?.body;
      final data = Map<String, dynamic>.from(message.data);

      _messagesController.add(PushMessage(title: title, body: body, data: data));

      if (title != null || body != null) {
        await _localNotifications.show(
          title.hashCode ^ body.hashCode,
          title,
          body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'default',
              'Default',
              channelDescription: 'Default notifications',
              importance: Importance.high,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          payload: data.isEmpty ? null : data.toString(),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final title = message.notification?.title;
      final body = message.notification?.body;
      final data = Map<String, dynamic>.from(message.data);
      _messagesController.add(PushMessage(title: title, body: body, data: data));
    });

    final initial = await messaging.getInitialMessage();
    if (initial != null) {
      final title = initial.notification?.title;
      final body = initial.notification?.body;
      final data = Map<String, dynamic>.from(initial.data);
      _messagesController.add(PushMessage(title: title, body: body, data: data));
    }
  }

  static Future<void> _initHms() async {
    if (!Platform.isAndroid) return;

    try {
      await hms.Push.setAutoInitEnabled(true);
    } catch (_) {
      return;
    }

    hms.Push.getTokenStream.listen(
      (token) {
        if (token.isNotEmpty) {
          _tokenController.add(PushToken(provider: 'hms', value: token));
        }
      },
      onError: (_) {},
    );

    hms.Push.onMessageReceivedStream.listen(
      (remoteMessage) {
        final data = <String, dynamic>{};
        final raw = remoteMessage.data;
        if (raw != null) {
          data['data'] = raw;
        }
        _messagesController.add(
          PushMessage(title: null, body: null, data: data),
        );
      },
      onError: (_) {},
    );

    hms.Push.onNotificationOpenedApp.listen((initialNotification) {
      if (initialNotification == null) return;
      _messagesController.add(
        PushMessage(title: null, body: null, data: {
          'notification': initialNotification,
        }),
      );
    });

    try {
      final initialNotification = await hms.Push.getInitialNotification();
      if (initialNotification != null) {
        _messagesController.add(
          PushMessage(title: null, body: null, data: {
            'notification': initialNotification,
          }),
        );
      }
    } catch (_) {}

    try {
      hms.Push.getToken('');
    } catch (_) {}
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
  } catch (_) {}
  if (kDebugMode) {
    debugPrint('[Push] background message: ${message.messageId ?? ''}');
  }
}
