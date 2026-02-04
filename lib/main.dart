import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/notifications/push/push_notifications.dart';
import 'package:ltfest/notifications/push/push_token_sync_provider.dart';
import 'package:ltfest/router/router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// 11.10 build
Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
 SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  // await PushNotifications.init();

  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://143ecd79de653a2d4c96a9a5ffc84ace@o4510202029801472.ingest.de.sentry.io/4510202031112272';
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(SentryWidget(child: const ProviderScope(child: MyApp()))),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(pushTokenSyncProvider);
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
