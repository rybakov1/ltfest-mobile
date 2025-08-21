import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/pages/more/about_app_page.dart';
import 'package:ltfest/pages/more/account_settings_page.dart';
import 'package:ltfest/pages/more/app_settings_page.dart';
import 'package:ltfest/router/app_routes.dart';
import 'package:ltfest/pages/auth/login_page.dart';
import 'package:ltfest/pages/auth/registration_page.dart';
import 'package:ltfest/pages/news_page.dart';
import 'package:ltfest/pages/fest/fest_details_page.dart';
import 'package:ltfest/pages/fest/fest_page.dart';
import 'package:ltfest/pages/home/home_page.dart';
import 'package:ltfest/pages/lab/lab_details_page.dart';
import 'package:ltfest/pages/lab/lab_page.dart';
import 'package:ltfest/pages/main_screen.dart';
import 'package:ltfest/pages/more/more_page.dart';
import 'package:ltfest/pages/home/more_items_page.dart';
import '../pages/auth/input_code_page.dart';
import '../pages/more/favorites_page.dart';
import '../providers/auth_state.dart';
import '../providers/user_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = ValueNotifier<int>(0);
  ref.listen(authNotifierProvider, (_, __) => listenable.value++);

  return GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: listenable,
    redirect: (BuildContext context, GoRouterState state) {
      final authState = ref.read(authNotifierProvider);
      final currentLocation = state.uri.path;

      if (authState.isLoading || authState.isReloading) {
        return null;
      }

      final data = authState.value;
      switch (data) {
        case Authenticated():
          final isGoingToAuthRoute = currentLocation == AppRoutes.login ||
              currentLocation == AppRoutes.inputCode ||
              currentLocation == AppRoutes.registration;
          if (isGoingToAuthRoute) {
            return AppRoutes.home;
          }
          return null;
        case NeedsRegistration():
          if (currentLocation != AppRoutes.registration) {
            return AppRoutes.registration;
          }
          return null;
        case Unauthenticated():
          final isGoingToAuthFlow = currentLocation == AppRoutes.login ||
              currentLocation == AppRoutes.inputCode;
          if (!isGoingToAuthFlow) {
            return AppRoutes.login;
          }
          return null;
        case null:
          return AppRoutes.login;
      }
      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Страница не найдена: ${state.uri}')),
    ),
    routes: [
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AuthorizationPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.registration,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: RegistrationPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.inputCode,
        pageBuilder: (context, state) {
          final phone = state.extra as String?;
          return NoTransitionPage(
            child: InputCodePage(phoneNumber: phone ?? ''),
          );
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainScreen(currentPath: state.matchedLocation, child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.fest,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FestivalPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.lab,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LaboratoryPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.blog,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: NewsPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.more,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MorePage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.accountSettings,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AccountSettingsPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.favorites,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: FavoritesPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.appSettings,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AppSettingsPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.about,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AboutAppPage(),
        ),
      ),
      GoRoute(
        path: '${AppRoutes.festDetailsBase}/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoTransitionPage(
            child: FestivalDetailPage(id: id),
          );
        },
      ),
      GoRoute(
        path: '${AppRoutes.labDetailsBase}/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoTransitionPage(
            child: LaboratoryDetailPage(id: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.allItems,
        name: AppRoutes.allItemsName,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return NoTransitionPage(
            child: AllItemsPage(
              title: extra['title'] as String,
              itemsAsync: extra['itemsAsync'],
            ),
          );
        },
      ),
    ],
  );
});
