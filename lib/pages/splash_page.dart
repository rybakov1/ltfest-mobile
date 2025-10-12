import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_state.dart';
import '../providers/user_provider.dart';
import '../router/app_routes.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<AuthState>>(authNotifierProvider, (previous, next) {
      final authState = next.value;
      if (authState != null && !next.isLoading && !next.isReloading) {
        if (authState is Authenticated) {
          context.go(AppRoutes.home);
        } else if (authState is NeedsRegistration) {
          context.go(AppRoutes.registration);
        } else if (authState is Unauthenticated) {
          context.go(AppRoutes.login); // Явный уход с splash
        }
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
