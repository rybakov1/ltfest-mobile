import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/router/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../providers/user_provider.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(user!.lastname.toString(), style: Styles.h3),
                      Text(user.activity!.title.toString(), style: Styles.b2),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            if (user.activity!.title == "Руководитель коллектива")
              Padding(
                padding: const EdgeInsets.all(4),
                child: ProfileCard(status: user.ltpriority),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  _ActionCard(
                    iconPath: 'assets/icons/social/tg.svg',
                    title: "LT Blog",
                    onTap: () {
                      launchUrl(Uri.parse('https://t.me/ltfest'),
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                  const SizedBox(width: 4),
                  _ActionCard(
                    iconPath: 'assets/icons/social/wa.svg',
                    title: "Связаться с нами",
                    onTap: () {
                      launchUrl(Uri.parse('https://t.me/ltfest'),
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: Decor.base,
                child: _MenuTile(
                  iconPath: 'assets/icons/news.svg',
                  title: "Новости LT Fest",
                  onTap: () {
                    context.push(AppRoutes.news);
                  },
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: Decor.base,
                child: _MenuTile(
                  iconPath: 'assets/icons/favourite.svg',
                  title: "Избранное",
                  onTap: () => context.push(AppRoutes.favorites),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: Decor.base,
                child: Column(
                  children: [
                    _MenuTile(
                      iconPath: 'assets/icons/shop.svg',
                      title: "LT Shop",
                      onTap: () {
                        context.push(AppRoutes.shop);
                      },
                    ),
                    _MenuTileCart(
                      iconPath: 'assets/icons/cart.svg',
                      title: "Корзина",
                      onTap: () {
                        context.push(AppRoutes.cart);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: Decor.base,
                child: Column(
                  children: [
                    _MenuTile(
                      iconPath: 'assets/icons/person.svg',
                      title: "Настройки аккаунта",
                      onTap: () {
                        context.push(AppRoutes.user);
                      },
                    ),
                    // TODO: Notification
                    // _MenuTile(
                    //   iconPath: 'assets/icons/settings.svg',
                    //   title: "Настройки приложения",
                    //   onTap: () {
                    //     context.push(AppRoutes.settings);
                    //   },
                    // ),
                    _MenuTile(
                      iconPath: 'assets/icons/info.svg',
                      title: "О приложении",
                      onTap: () {
                        context.push(AppRoutes.about);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum PriorityLevel { base, silver, gold, platinum }

class ProfileCard extends ConsumerWidget {
  final String? status;

  const ProfileCard({super.key, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (status) {
      "Silver" || "Gold" || "Platinum" =>
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 77,
              decoration: BoxDecoration(
                color: Palette.black.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Image.asset("assets/images/${status!}.png", width: double.infinity, fit: BoxFit.fitWidth,),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Text("LT Priority",
                              style: Styles.h4.copyWith(color: Palette.white)),
                          const Spacer(),
                          Text(status!, style: Styles.h6.copyWith(color: Palette.white))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      'Base' || null || _ =>
          InkWell(
            onTap: () => context.push(AppRoutes.ltPriority),
            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              decoration: BoxDecoration(
                color: Palette.primaryLime,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text("LT Priority",
                      style: Styles.h4.copyWith(color: Palette.white)),
                  const Spacer(),
                  Text("Подключить",
                      style: Styles.button1.copyWith(color: Palette.white)),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/icons/arrow_right.svg',
                      colorFilter:
                      ColorFilter.mode(Palette.white, BlendMode.srcIn)),
                ],
              ),
            ),
          ),
    };
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
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: Decor.base,
          child: Column(
            children: [
              SvgPicture.asset(iconPath, height: 32, width: 32),
              const SizedBox(height: 8),
              Text(title, style: Styles.b2),
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
            Expanded(child: Text(title, style: Styles.b1)),
            SvgPicture.asset('assets/icons/arrow_right.svg'),
          ],
        ),
      ),
    );
  }
}

class _MenuTileCart extends ConsumerWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const _MenuTileCart(
      {required this.iconPath, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(cartTotalItemsProvider);

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
            Expanded(child: Text(title, style: Styles.b1)),
            if (count > 0)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Palette.primaryLime,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  count.toString(),
                  style: Styles.h5.copyWith(color: Palette.white),
                ),
              ),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/icons/arrow_right.svg'),
          ],
        ),
      ),
    );
  }
}
