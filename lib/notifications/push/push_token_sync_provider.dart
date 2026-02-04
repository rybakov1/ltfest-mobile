// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ltfest/data/services/api_service.dart';
// import 'package:ltfest/providers/auth_state.dart';
// import 'package:ltfest/providers/user_provider.dart';

// import 'push_notifications.dart';

// final _lastRegisteredPushTokenProvider = StateProvider<String?>((ref) => null);

// final pushTokenSyncProvider = Provider<void>((ref) {
//   final api = ref.watch(apiServiceProvider);
//   ref.watch(authNotifierProvider);

//   final sub = PushNotifications.tokens.listen((token) async {
//     final auth = ref.read(authNotifierProvider).valueOrNull;
//     if (auth is! Authenticated) return;

//     final last = ref.read(_lastRegisteredPushTokenProvider);
//     if (last == token.value) return;

//     try {
//       await api.registerPushToken(
//         userId: auth.user.id,
//         token: token.value,
//         provider: token.provider,
//         platform: Platform.operatingSystem,
//       );
//       ref.read(_lastRegisteredPushTokenProvider.notifier).state = token.value;
//     } catch (_) {}
//   });

//   ref.onDispose(() => sub.cancel());
// });
