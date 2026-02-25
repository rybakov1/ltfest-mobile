import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/router/router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// 05.02 build

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Уведомление в фоне: ${message.notification?.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    debugPrint("⚠️ Ошибка инициализации Firebase: $e");
  }

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://143ecd79de653a2d4c96a9a5ffc84ace@o4510202029801472.ingest.de.sentry.io/4510202031112272';
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
      options.environment = kDebugMode ? 'development' : 'production';
    },
    appRunner: () =>
        runApp(SentryWidget(child: const ProviderScope(child: MyApp()))),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ru'),
      supportedLocales: const [
        Locale('ru'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'LT Fest',
      routerConfig: router,
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: child,
          ),
        );
      },
    );
  }
}
