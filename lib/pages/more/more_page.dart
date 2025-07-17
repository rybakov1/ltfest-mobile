import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/router/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../providers/auth_state.dart';
import '../../providers/user_provider.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  void _showExitPopup(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16).copyWith(bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: Palette.stroke,
                    borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: 24),
              Text('Выход из аккаунта', style: Styles.h4),
              const SizedBox(height: 16),
              Text('Вы уверены, что хотите выйти из аккаунта?',
                  style: Styles.b2, textAlign: TextAlign.center),
              const SizedBox(height: 32),
              Row(
                children: [
                  // 2. Заменили GestureDetector на OutlinedButton
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Palette.stroke),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text("Отмена", style: Styles.button1),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 3. Заменили GestureDetector на ElevatedButton
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Сначала закрываем окно
                        ref.read(authNotifierProvider.notifier).logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.error,
                        foregroundColor: Palette.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                      child: Text("Выйти", style: Styles.button1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Palette.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child:
                  Text("Еще", style: Styles.h3.copyWith(color: Palette.white)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: _ProfileCard(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  _ActionCard(
                    iconPath: 'assets/icons/tg.svg',
                    title: "Telegram",
                    onTap: () {
                      launchUrl(Uri.parse('https://t.me/ltfest'),
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                  const SizedBox(width: 2),
                  _ActionCard(
                    iconPath: 'assets/icons/favourite.svg',
                    title: "Избранное",
                    onTap: () {
                      // TODO: Добавить навигацию на страницу избранного
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  decoration: Decor.base,
                  child: Column(
                    children: [
                      _MenuTile(
                        iconPath: 'assets/icons/person.svg',
                        title: "Настройки аккаунта",
                        onTap: () {
                          context.push(AppRoutes.accountSettings);
                        },
                      ),
                      _MenuTile(
                        iconPath: 'assets/icons/settings.svg',
                        title: "Настройки приложения",
                        onTap: () {
                          context.push(AppRoutes.appSettings);
                        },
                      ),
                      _MenuTile(
                        iconPath: 'assets/icons/info.svg',
                        title: "О приложении",
                        onTap: () {
                          context.push(AppRoutes.about);
                        },
                      ),
                      const Spacer(),
                      // Кнопка выхода
                      TextButton(
                        onPressed: () => _showExitPopup(context, ref),
                        child: Text(
                          "Выйти из аккаунта",
                          style: Styles.button1.copyWith(color: Palette.error),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends ConsumerWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return authState.maybeWhen(
      data: (data) {
        if (data is Authenticated) {
          final user = data.user;
          final displayName = user.lastname.trim();
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            decoration: Decor.base.copyWith(color: Palette.primaryLime),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName, style: Styles.h3),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("LT priority", style: Styles.b2),
                    Text(
                        user.ltpriority != "Base1"
                            ? "${user.ltpriority}"
                            : "Подробнее",
                        style: user.ltpriority != "Base1"
                            ? const TextStyle(
                                fontFamily: "Unbounded",
                                fontSize: 24,
                                fontWeight: FontWeight.w600)
                            : Styles.button1),
                  ],
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
      orElse: () => Container(
        height: 135,
        alignment: Alignment.center,
        decoration: Decor.base.copyWith(color: Palette.primaryLime),
        child: CircularProgressIndicator(color: Palette.black),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const _ActionCard(
      {required this.iconPath, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          decoration: Decor.base,
          child: Column(
            children: [
              SvgPicture.asset(iconPath, height: 32, width: 32),
              const SizedBox(height: 8),
              Text(title, style: Styles.h4),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const _MenuTile(
      {required this.iconPath, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            SvgPicture.asset(iconPath,
                width: 20,
                colorFilter: ColorFilter.mode(Palette.black, BlendMode.srcIn)),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: Styles.b2)),
            SvgPicture.asset('assets/icons/arrow_right.svg'),
          ],
        ),
      ),
    );
  }
}
