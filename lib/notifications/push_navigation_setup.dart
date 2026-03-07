import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_provider.dart';
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
  RemoteMessage? _pendingInitialMessage;

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
        _pendingInitialMessage = message;
      }
    });
  }

  void _tryNavigateFromInitialMessage() {
    if (_pendingInitialMessage == null) return;

    final authState = ref.read(authNotifierProvider);
    if (authState.isLoading || authState.isReloading) return;

    final msg = _pendingInitialMessage;
    _pendingInitialMessage = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pushNavigationHandler.handleMessageOpenedApp(msg!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    pushNavigationHandler.setRouter(router);

    ref.listen(authNotifierProvider, (_, next) {
      _tryNavigateFromInitialMessage();
    });
    _tryNavigateFromInitialMessage();

    return widget.child;
  }
}
