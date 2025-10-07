import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/components/share_button.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';

class LtWinnerPage extends StatelessWidget {
  const LtWinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/lt_winner.png',
                  height: 360,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                width: 43,
                                height: 43,
                                color: Palette.primaryLime,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Palette.white,
                                    size: 24,
                                  ),
                                  onPressed: () => context.pop(),
                                ),
                              ),
                            ),
                            const Spacer(),
                            ShareButton(
                              link: 'https://ltfest.ru',
                              color: Palette.primaryLime,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 270 - MediaQuery.of(context).padding.top),
                      Container(
                        decoration: Decor.base,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 12),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('LT Winner', style: Styles.h2),
                            const SizedBox(height: 24),
                            const _ThreeStepsBlock(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 82),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: LTButtons.elevatedButton(
                onPressed: () => context.push(AppRoutes.more),
                child: Text('Узнать подробности', style: Styles.button1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThreeStepsBlock extends StatelessWidget {
  const _ThreeStepsBlock();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepTile(
          title: 'Шаг 1. Зарегистрируйтесь',
          subtitle: 'Создайте аккаунт и заполните профиль участника.',
        ),
        SizedBox(height: 8),
        _StepTile(
          title: 'Шаг 2. Участвуйте',
          subtitle: 'Выбирайте мероприятия и принимайте участие.',
        ),
        SizedBox(height: 8),
        _StepTile(
          title: 'Шаг 3. Получайте награды',
          subtitle: 'Становитесь победителем и получайте бонусы.',
        ),
      ],
    );
  }
}

class _StepTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const _StepTile({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.background,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Styles.h4),
          const SizedBox(height: 8),
          Text(subtitle, style: Styles.b1),
        ],
      ),
    );
  }
}


