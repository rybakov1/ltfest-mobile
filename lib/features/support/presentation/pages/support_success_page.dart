import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';

class SupportSuccessPage extends StatelessWidget {
  const SupportSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
          child: Column(
            children: [
              const SizedBox(height: 115),
              Image.asset(
                'assets/images/payment_success.png',
                width: 101,
                height: 101,
              ),
              const SizedBox(height: 16),
              Text(
                'Ваше обращение отправлено',
                style: Styles.h3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Мы все изучим и обязательно свяжемся\nс вами.',
                style: Styles.b1.copyWith(color: Palette.gray),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              LTButtons.outlinedButton(
                onPressed: () => context.go(AppRoutes.home),
                child: Text('На главную', style: Styles.button1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
