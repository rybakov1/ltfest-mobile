import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/components/share_button.dart';

class LtConciergePage extends StatelessWidget {
  const LtConciergePage({super.key});

  Future<void> _openTelegram() async {
    final uri = Uri.parse('https://t.me/ltfest');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

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
                  'assets/images/concierge.png',
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
                            Text('LT Консьерж', style: Styles.h2),
                            const SizedBox(height: 24),
                            Text(
                              "Персональный помощник LT для участия в программах, событийной логистики и поддержки.",
                              style: Styles.b1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        decoration: Decor.base,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 12),
                        width: double.infinity,
                        child: const _ThreeStepsBlock(),
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
                onPressed: _openTelegram,
                child: Text('Перейти в Telegram', style: Styles.button1),
              ),
            ),
          ),
        ],
      ),
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

class _ThreeStepsBlock extends StatelessWidget {
  const _ThreeStepsBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _StepTile(
          title: 'Шаг 1. Свяжитесь с LT Консьерж',
          subtitle: 'Напишите нам в Telegram — расскажем и подберём решение.',
        ),
        SizedBox(height: 8),
        _StepTile(
          title: 'Шаг 2. Согласуйте детали',
          subtitle: 'Маршруты, жильё, участие и доп. услуги — всё в одном месте.',
        ),
        SizedBox(height: 8),
        _StepTile(
          title: 'Шаг 3. Получите сопровождение',
          subtitle: 'Поддержка до и во время события, помощь в любых вопросах.',
        ),
      ],
    );
  }
}


