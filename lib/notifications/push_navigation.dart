import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../router/app_routes.dart';

/// Обрабатывает навигацию при нажатии на push-уведомление.
/// Использует data payload: type, id, orderId, status и т.д.
class PushNavigationHandler {
  GoRouter? _router;
  RemoteMessage? _pendingMessage;

  void setRouter(GoRouter router) {
    _router = router;
    if (_pendingMessage != null) {
      _navigateFromMessage(_pendingMessage!);
      _pendingMessage = null;
    }
  }

  void handleMessageOpenedApp(RemoteMessage message) {
    if (_router != null) {
      _navigateFromMessage(message);
    } else {
      _pendingMessage = message;
    }
  }

  void _navigateFromMessage(RemoteMessage message) {
    final data = message.data;
    if (data.isEmpty) return;

    final router = _router!;
    String? path;

    // Поддержка deeplink через поле path (например "news/1", "shop/123")
    final pathFromData = data['path'] as String?;
    if (pathFromData != null && pathFromData.isNotEmpty) {
      path = pathFromData.startsWith('/') ? pathFromData : '/$pathFromData';
    }

    // Fallback: старый формат type + id
    if (path == null) {
      final type = data['type'] as String?;
      final id = data['id'] as String?;
      final orderId = data['orderId'] as String?;

      switch (type) {
        case 'news':
          if (id != null) path = '${AppRoutes.news}/$id';
          break;
        case 'product':
          if (id != null) path = '${AppRoutes.shop}/$id';
          break;
        case 'order':
          if (orderId != null) {
            path = '/success/$orderId';
          } else {
            path = AppRoutes.cart;
          }
          break;
        case 'festival':
          if (id != null) path = '${AppRoutes.festival}/$id';
          break;
        case 'laboratory':
          if (id != null) path = '${AppRoutes.laboratories}/$id';
          break;
        default:
          debugPrint('[PushNavigation] Unknown type: $type');
      }
    }

    if (path != null) {
      router.go(path);
    }
  }
}

final pushNavigationHandler = PushNavigationHandler();
