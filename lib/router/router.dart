import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/data/models/laboratory_learning_type.dart';
import 'package:ltfest/data/models/laboratory_order_args_model.dart';
import 'package:ltfest/data/models/priority_tariff.dart';
import 'package:ltfest/pages/more/about_app_page.dart';
import 'package:ltfest/pages/more/account_settings_page.dart';
import 'package:ltfest/pages/more/app_settings_page.dart';
import 'package:ltfest/pages/news/news_details_page.dart';
import 'package:ltfest/pages/order/presenter/festival_order_page.dart';
import 'package:ltfest/pages/order/presenter/laboratory_order_page.dart';
import 'package:ltfest/pages/order/presenter/lt_priority_order_page.dart';
import 'package:ltfest/pages/order/presenter/product_order_page.dart';
import 'package:ltfest/pages/shop/presenter/shop_details_page.dart';
import 'package:ltfest/pages/shop/presenter/shop_page.dart';
import 'package:ltfest/router/app_routes.dart';
import 'package:ltfest/pages/auth/login_page.dart';
import 'package:ltfest/pages/auth/registration_page.dart';
import 'package:ltfest/pages/news/news_page.dart';
import 'package:ltfest/pages/fest/fest_details_page.dart';
import 'package:ltfest/pages/fest/fest_page.dart';
import 'package:ltfest/pages/home/home_page.dart';
import 'package:ltfest/pages/lab/lab_details_page.dart';
import 'package:ltfest/pages/lab/lab_page.dart';
import 'package:ltfest/pages/main_screen.dart';
import 'package:ltfest/pages/more/more_page.dart';
import 'package:ltfest/pages/home/more_items_page.dart';
import '../data/models/festival_order_args_model.dart';
import '../data/models/festival_tariff.dart';
import '../pages/auth/input_code_page.dart';
import '../pages/cart/cart_page.dart';
import '../pages/more/delete_account_page.dart';
import '../pages/more/favorites_page.dart';
import '../pages/no_internet_page.dart';
import '../pages/payment/payment_failure_screen.dart';
import '../pages/payment/payment_init_screen.dart';
import '../pages/payment/payment_provider.dart';
import '../pages/payment/payment_success_screen.dart';
import '../pages/reference/presenter/lt_coin_page.dart';
import '../pages/reference/presenter/lt_concierge_page.dart';
import '../pages/reference/presenter/lt_pay_page.dart';
import '../pages/reference/presenter/lt_priority_page.dart';
import '../pages/reference/presenter/lt_winner_page.dart';
import '../pages/splash_page.dart';
import '../providers/auth_state.dart';
import '../providers/connectivity_provider.dart';
import '../providers/user_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = ValueNotifier<int>(0);
  ref.listen(authNotifierProvider, (_, __) => listenable.value++);
  ref.listen(connectivityStatusProvider, (_, __) => listenable.value++);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: listenable,
    redirect: (BuildContext context, GoRouterState state) {
      final connectivity = ref.read(connectivityStatusProvider).value;
      final currentLocation = state.uri.path;

      const allowedRoutes = [
        AppRoutes.splash,
        AppRoutes.login,
        AppRoutes.registration,
        AppRoutes.verification,
        AppRoutes.noInternet,
      ];

      if (connectivity == ConnectivityStatus.isDisconnected && !allowedRoutes.contains(currentLocation)) {
        return AppRoutes.noInternet;
      }

      final authState = ref.read(authNotifierProvider);

      final isAuthRoute = currentLocation == AppRoutes.login ||
          currentLocation == AppRoutes.verification ||
          currentLocation == AppRoutes.registration;

      if (authState.isLoading || authState.isReloading) {
        if (!isAuthRoute && currentLocation != AppRoutes.splash) {
          return AppRoutes.splash;
        }
        return null;
      }

      if (authState.hasError && currentLocation != AppRoutes.login) {
        return AppRoutes.login;
      }

      if (authState.hasValue) {
        final data = authState.value;
        switch (data) {
          case Authenticated():
            final isGoingToAuthRoute = currentLocation == AppRoutes.login ||
                currentLocation == AppRoutes.verification ||
                currentLocation == AppRoutes.registration ||
                currentLocation == AppRoutes.splash;
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
                currentLocation == AppRoutes.verification ||
                currentLocation == AppRoutes.registration;
            if (!isGoingToAuthFlow) {
              return AppRoutes.login;
            }
            return null;
          case null:
            return AppRoutes.login;
        }
      }
      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Страница не найдена: ${state.uri}')),
    ),
    routes: [
      GoRoute(
        path: AppRoutes.noInternet,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: NoInternetPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SplashPage(),
        ),
      ),
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
        path: AppRoutes.verification,
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
            path: '${AppRoutes.festivals}/:category',
            pageBuilder: (context, state) {
              final categoryName =
                  state.pathParameters['category'] ?? 'Неизвестно';
              return NoTransitionPage(
                  child: FestivalPage(category: categoryName));
            },
          ),
          GoRoute(
            path: AppRoutes.laboratories,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LaboratoryPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.news,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: NewsPage(),
            ),
          ),
          GoRoute(
            path: '${AppRoutes.news}/:id',
            pageBuilder: (context, state) {
              final id = state.pathParameters['id']!;
              return NoTransitionPage(
                child: NewsDetailsPage(id: id),
              );
            },
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
        path: AppRoutes.user,
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
        path: AppRoutes.settings,
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
        path: AppRoutes.deleteAccount,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: DeleteAccountPage(),
        ),
      ),
      GoRoute(
        path: '${AppRoutes.festivals}/:category/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          final category = state.pathParameters['category']!;
          return NoTransitionPage(
            child: FestivalDetailPage(id: id, category: category),
          );
        },
      ),
      GoRoute(
        path: '${AppRoutes.laboratories}/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoTransitionPage(
            child: LaboratoryDetailPage(id: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.cart,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: CartPage());
        },
      ),
      GoRoute(
        path: AppRoutes.shop,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: ShopPage());
        },
      ),
      GoRoute(
        path: '${AppRoutes.shop}/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoTransitionPage(
            child: ShopDetailsPage(id: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.all,
        name: AppRoutes.allName,
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
      GoRoute(
        path: AppRoutes.ltCoin,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LtCoinPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.ltWinner,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LtWinnerPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.ltPay,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LtPayPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.ltConcierge,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LtConciergePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.ltPriority,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LtPriorityPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.ltTravel,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LtConciergePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.festivalOrder,
        pageBuilder: (context, state) {
          final args = state.extra as FestivalOrderArgs;
          return NoTransitionPage(
            child: FestivalOrderPage(args: args),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.laboratoryOrder,
        pageBuilder: (context, state) {
          final args = state.extra as LaboratoryOrderArgsModel;
          return NoTransitionPage(
            child: LaboratoryOrderPage(args: args),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.priorityOrder,
        pageBuilder: (context, state) {
          final tariff = state.extra as PriorityTariff;
          return NoTransitionPage(child: LtPriorityOrderPage(tariff: tariff));
        },
      ),
      GoRoute(
        path: '/order/products',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: ProductOrderPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.paymentInit,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return NoTransitionPage(
            child: PaymentInitScreen(
              paymentUrl: extra["paymentUrl"],
              orderId: extra["orderId"],
              paymentId: extra["paymentId"],
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.paymentSuccess, // Это '/success/:id'
        name: 'payment_success', // Полезно дать имя
        builder: (context, state) {
          final paymentId = state.pathParameters['id']!;
          debugPrint('DeepLink Success: $paymentId');
          return PaymentSuccessScreen(paymentId: paymentId);
        },
      ),
      GoRoute(
        path: AppRoutes.paymentFailure, // Это '/fail/:id'
        name: 'payment_failure',
        builder: (context, state) {
          final paymentId = state.pathParameters['id']!;
          debugPrint('DeepLink Failure: $paymentId');
          return PaymentFailureScreen(paymentId: paymentId);
        },
      ),
      // GoRoute(
      //   path: AppRoutes.paymentSuccess,
      //   redirect: (BuildContext context, GoRouterState state) {
      //     var paymentIdFromUrl = state.pathParameters['id'];
      //     if (paymentIdFromUrl == '{PaymentId}') {
      //       final ref = ProviderScope.containerOf(context, listen: false);
      //       final savedId = ref.read(paymentNotifierProvider).value?.paymentId;
      //
      //       if (savedId != null && savedId.isNotEmpty) {
      //         debugPrint(
      //             'GoRouter redirect: replacing {PaymentId} with $savedId');
      //         return '/success/$savedId';
      //       }
      //     }
      //     return null;
      //   },
      //   builder: (context, state) {
      //     final correctPaymentId = state.pathParameters['id']!;
      //     debugPrint(
      //         'GoRouter builder: creating PaymentSuccessScreen with id: $correctPaymentId');
      //     return PaymentSuccessScreen(paymentId: correctPaymentId);
      //   },
      // ),
      // GoRoute(
      //   path: AppRoutes.paymentFailure,
      //   redirect: (BuildContext context, GoRouterState state) {
      //     var paymentIdFromUrl = state.pathParameters['id'];
      //     if (paymentIdFromUrl == '{PaymentId}') {
      //       final ref = ProviderScope.containerOf(context, listen: false);
      //       final savedId = ref.read(paymentNotifierProvider).value?.paymentId;
      //
      //       if (savedId != null && savedId.isNotEmpty) {
      //         debugPrint(
      //             'GoRouter redirect: replacing {PaymentId} with $savedId');
      //         return '/fail/$savedId';
      //       }
      //     }
      //     return null;
      //   },
      //   builder: (context, state) {
      //     final correctPaymentId = state.pathParameters['id']!;
      //     debugPrint(
      //         'GoRouter builder: creating PaymentSuccessScreen with id: $correctPaymentId');
      //     return PaymentFailureScreen(paymentId: correctPaymentId);
      //   },
      // ),
    ],
  );
});
