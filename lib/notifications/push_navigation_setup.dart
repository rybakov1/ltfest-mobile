import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../router/router.dart';
import 'push_navigation.dart';

/// Инициализирует обработку нажатий на push и передаёт router в handler.
class PushNavigationSetup extends ConsumerStatefulWidget {
  final Widget child;

  const PushNavigationSetup({super.key, required this.child});

  @override
  ConsumerState<PushNavigationSetup> createState() => _PushNavigationSetupState();
}

class _PushNavigationSetupState extends ConsumerState<PushNavigationSetup> {
  bool _listenersSet = false;

  @override
  void initState() {
    super.initState();
    _setupListeners();
  }

  void _setupListeners() {
    if (_listenersSet) return;
    _listenersSet = true;

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      pushNavigationHandler.handleMessageOpenedApp(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        // Отложить навигацию до готовности роутера (следующий кадр)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          pushNavigationHandler.handleMessageOpenedApp(message);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    pushNavigationHandler.setRouter(router);
    return widget.child;
  }
}
