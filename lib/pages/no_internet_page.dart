import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 16.0, left: 16, top: 40, bottom: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo_black.png", width: 200),
              const Spacer(),
              Image.asset("assets/images/no_connection.png", width: 192),
              const SizedBox(height: 20),
              Text(
                'Соединение прервано',
                style: Styles.b2,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              LTButtons.outlinedButton(
                onPressed: () => context.go(AppRoutes.home),
                child: Text(
                  "Обновить страницу",
                  style: Styles.button1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
