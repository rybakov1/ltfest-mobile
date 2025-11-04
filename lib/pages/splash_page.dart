import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/constants.dart';
import '../providers/user_provider.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: Palette.primaryLime,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/splash_background.png',
              height: double.infinity,
              fit: BoxFit.fitHeight,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/logo_white.png',
                  height: 60,
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'Всероссийское фестивальное\nдвижение',
                    style: Styles.h3.copyWith(color: Palette.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Загружаем фестивали и конкурсы',
                  style: Styles.b2.copyWith(color: Palette.white),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
