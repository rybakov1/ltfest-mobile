// lib/pages/lt_coin_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';

import '../../../router/app_routes.dart';
import 'ReferencePage.dart';

class LtPriorityPage extends StatelessWidget {
  const LtPriorityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReferencePage(
      title: 'LT Priority',
      imageAsset: 'assets/images/lt_priority_full.png',
      shareLink: 'https://ltfest.ru',
      contentBlocks: [
        Container(
          decoration: Decor.base,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              buildTextBlock(
                title: 'Программа лояльности для руководителей',
                text:
                    "Хотите сэкономить на участии во всех проектах от LT Fest и получить особые привилегии во время фестивалей? Теперь это возможно благодаря нашим трем видам карт лояльности – LT Silver, LT Gold и LT Platinum!",
              ),
              _buildBenefitsBlock(),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Container(
          decoration: Decor.base,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Как это работает", style: Styles.h3),
              const SizedBox(height: 24),
              const LTPriorityTariff(
                title: "LT Silver",
                price: 35000,
                description: "Скидка 5%",
                bonuses: [
                  "+10 минут дополнительной репетиции на сцене во время театрального фестиваля.\n+1 минута на каждый номер во время хореографического конкурса."
                ],
              ),
              const SizedBox(height: 8),
              const LTPriorityTariff(
                title: "LT Gold",
                price: 45000,
                description: "Скидка 10%",
                bonuses: [
                  "+15 минут дополнительной репетиции на сцене во время театрального фестиваля.\n2 минуты на каждый номер во время хореографического конкурса.",
                  "Возврат 15% от стоимости трансфера (автобус от ж/д вокзала или аэропорта до отеля и обратно).",
                  "Возврат 15% от стоимости ж/д билетов и 10% от стоимости авиабилетов для руководителя коллектива в город проведения фестиваля и обратно."
                ],
              ),
              const SizedBox(height: 8),
              const LTPriorityTariff(
                title: "LT Platinum",
                price: 59900,
                description: "Скидка 15%",
                bonuses: [
                  "+20 минут дополнительной репетиции на сцене во время тетарального фестиваля.\n+3 минуты на каждый номер во время хореографического конкурса.",
                  "Возврат 25% от стоимости трансфера (автобус от ж/д вокзала или аэропорта до отеля и обратно).",
                  "Возврат 25% от стоимости ж/д билетов и 10% от стоимости авиабилетов для руководителя коллектива в город проведения фестиваля и обратно.",
                  "Приоритет в выборе даты и времени показа спектакля/танцевального номера (до официального опубликования программы фестиваля)."
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 2),
        _buildFaqSection(),
      ],
    );
  }

  Widget _buildBenefitsBlock() {
    Widget item({
      required String image,
      required String title,
      required String text,
    }) {
      return Container(
        height: 200,
        decoration: Decor.base,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: Styles.h3,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    text,
                    style: Styles.b2,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Container(
      decoration: Decor.base,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          item(
            image: 'assets/images/card_star.png',
            title: 'Действуют на все проекты LT Fest',
            text: 'кроме зарубежных фестивалей',
          ),
          const SizedBox(height: 8),
          item(
            image: 'assets/images/card_star2.png',
            title: 'Позволяют экономить на стоимости участия',
            text: 'Получайте кэшбэк после оплаты фестиваля',
          ),
          const SizedBox(height: 8),
          item(
            image: 'assets/images/card_star3.png',
            title: 'Дополнительные бонусы на фестивалях',
            text: 'Держателям карт дарим приятные подарки',
          ),
        ],
      ),
    );
  }

  Widget _buildFaqSection() {
    final List<Map<String, String>> faqItems = [
      {
        'q': 'Сколько дейсвует карта лояльности?',
        'a':
            'Карта лояльности дейсвует год с момента покупки. Карта начинает работать сразу после оплаты (физическая карта доставляется «СДЭК» в течение 30 дней).'
      },
      {
        'q': 'Как продлить карту?',
        'a':
            'Для продления действия карты необходимо оплатить следующий год. При продлении можно сохранить текущий уровень карты, а также повысить или понизить его (стоимость будет рассчитана в соответствии с выбранным уровнем). '
      },
      {
        'q': 'Можно ли объединить скидку по карте с другими акциями?',
        'a':
            'Скидка по карте распространяется только на официальную стоимость участия и не суммируется с уже действующими акциями или промо.'
      },
      {
        'q':
            'Возвращают ли стоимость карты, если коллектив не смог участвовать в фестивале?',
        'a':
            'Стоимость карты не возвращается, если коллектив не смог приехать на фестиваль, так как карта является платным годовым продуктом. Если в течение года мероприятие было пропущено, скидка не преобразуется в денежную компенсацию.'
      },
    ];

    return Container(
      decoration: Decor.base,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Часто задаваемые вопросы', style: Styles.h3),
          const SizedBox(height: 24),
          for (var item in faqItems)
            FaqItem(
              question: item['q']!,
              answer: item['a']!,
            ),
        ],
      ),
    );
  }
}

class LTPriorityTariff extends StatefulWidget {
  final String title;
  final int price;
  final String description;
  final List<String> bonuses;

  final List<Widget> children;
  final bool initiallyExpanded;
  final Duration animationDuration;
  final Curve animationCurve;

  const LTPriorityTariff({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    this.children = const [],
    this.bonuses = const [],
    this.initiallyExpanded = false,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<LTPriorityTariff> createState() => _LTPriorityTariffState();
}

class _LTPriorityTariffState extends State<LTPriorityTariff>
    with SingleTickerProviderStateMixin {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Palette.background, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: Styles.h3),
                  const SizedBox(height: 12),
                  Text(Utils.formatMoney(widget.price), style: Styles.h2),
                  const SizedBox(height: 8),
                  Text(widget.description, style: Styles.b2),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text("Подробнее",
                          style: Styles.b3.copyWith(color: Palette.secondary)),
                      AnimatedRotation(
                        turns: _expanded ? 0.5 : 0.0,
                        duration: widget.animationDuration,
                        child: Icon(
                          Icons.expand_more,
                          color: Palette.secondary,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.bonuses.isNotEmpty)
                  for (int i = 0; i < widget.bonuses.length; i++) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle, color: Palette.primaryLime),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(widget.bonuses[i], style: Styles.b2))
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                const SizedBox(height: 8),
                LTButtons.elevatedButton(
                  onPressed: () =>
                      context.push("${AppRoutes.order}/ltpriority"),
                  child: Text("Купить", style: Styles.button1),
                  backgroundColor: Palette.primaryLime,
                ),
              ],
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: widget.animationDuration,
            sizeCurve: widget.animationCurve,
          ),
        ],
      ),
    );
  }
}
