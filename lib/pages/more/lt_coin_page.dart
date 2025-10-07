import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/components/share_button.dart';

class LtCoinPage extends StatelessWidget {
  const LtCoinPage({super.key});

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
                  'assets/images/lt_coin.png',
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
                            Text('Монета, которая помогает планировать будущее',
                                style: Styles.h2),
                            const SizedBox(height: 24),
                            Text(
                              "LTCoin — это удобная виртуальная единица, которая позволяет уверенно откладывать средства на образование и творческое развитие ваших детей.",
                              style: Styles.b1,
                            ),
                            const SizedBox(height: 24),
                            const _BenefitsBlock(),
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
                      const SizedBox(height: 2),
                      Container(
                        decoration: Decor.base,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 12),
                        width: double.infinity,
                        child: const _IllustratedSections(),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        decoration: Decor.base,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 12),
                        width: double.infinity,
                        child: const _FaqSection(),
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

class _BenefitsBlock extends StatelessWidget {
  const _BenefitsBlock();

  @override
  Widget build(BuildContext context) {
    Widget item(
        {required String image, required String title, required String text}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(image, height: 120, fit: BoxFit.contain),
          ),
          const SizedBox(height: 12),
          Text(title, style: Styles.h3, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(text, style: Styles.b2, textAlign: TextAlign.center),
        ],
      );
    }

    return Container(
      decoration: Decor.base,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          item(
            image: 'assets/images/lt_coin.png',
            title: 'Позаботьтесь о будущем детей уже сейчас',
            text:
                'С LTCoin вы можете оплатить участие в программах или, при желании, обмениваться монетами с другими участниками, если их стоимость изменилась, на взаимовыгодных условиях.',
          ),
          const SizedBox(height: 24),
          item(
            image: 'assets/images/lt_pay.png',
            title: 'Это просто и надёжно',
            text:
                'Приобрести LTCoin просто — прямо через Telegram-бот, начиная всего от 25 рублей за монету.',
          ),
          const SizedBox(height: 24),
          item(
            image: 'assets/images/lt_priority.png',
            title: 'Прозрачно и перспективно',
            text:
                '20% прибыли от мероприятий LT Fest, а также доходы от банковских вкладов направляются на поддержку платформы LTCoin и могут влиять на изменение её базовой стоимости.',
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
    return Container(
      decoration: Decor.base,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('3 простых шага — чтобы начать использовать LTCoin',
              style: Styles.h3),
          const SizedBox(height: 16),
          const _StepTile(
            title: 'Шаг 1. Покупаете монеты',
            subtitle:
                'Приобретаете LTCoin по начальной цене — от 25 рублей за монету',
          ),
          const SizedBox(height: 8),
          const _StepTile(
            title: 'Шаг 2. Следите за ростом стоимости монеты',
            subtitle:
                'Базовая стоимость LTCoin может периодически корректироваться компанией с учётом результатов её деятельности. Рыночная стоимость определяется спросом и предложением среди пользователей платформы.',
          ),
          const SizedBox(height: 8),
          const _StepTile(
            title: 'Шаг 3. Используете монеты',
            subtitle:
                'Используйте LTCoin для оплаты программ и мероприятий, обменивайтесь монетами с другими участниками платформы или, при необходимости, передавайте их другим пользователям на условиях, согласованных между сторонами. \nТакже вы всегда можете вернуть монеты в компанию по стоимости приобретения.',
          ),
        ],
      ),
    );
  }
}

class _IllustratedSections extends StatelessWidget {
  const _IllustratedSections();

  @override
  Widget build(BuildContext context) {
    Widget section({required String title, required String imageAsset}) {
      return Stack(
        children: [
          Container(
            decoration: Decor.base,
            clipBehavior: Clip.antiAlias,
            child: Image.asset(imageAsset,
                fit: BoxFit.cover, height: 336, width: double.infinity),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(title, style: Styles.h3),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Всё прозрачно и под контролем', style: Styles.h2),
        const SizedBox(height: 24),
        section(
          title: 'Ваши деньги полностью защищены',
          imageAsset: 'assets/images/lt_coin_defend.png',
        ),
        const SizedBox(height: 8),
        section(
          title: 'Мы гарантируем прозрачность всех операций и отчётов',
          imageAsset: 'assets/images/lt_coin_clear.png',
        ),
        const SizedBox(height: 8),
        section(
          title: 'Вы можете вернуть свои средства\nв любой момент',
          imageAsset: 'assets/images/lt_coin_back.png',
        ),
      ],
    );
  }
}

class _FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: Decor.base,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Palette.stroke),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          collapsedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(widget.question, style: Styles.h4),
          trailing: Icon(
            _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Palette.black,
          ),
          onExpansionChanged: (v) => setState(() => _expanded = v),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.answer, style: Styles.b2),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqSection extends StatelessWidget {
  final List<Map<String, String>> items = const [
    {
      'q': 'Для чего нужна эта монета?',
      'a': 'Виртуальная единица внутри экосистемы LT для бонусов и преимуществ.'
    },
    {
      'q': 'Это как криптовалюта? Нужно устанавливать что-то особенное?',
      'a': 'Участвуйте в фестивалях, акциях и активности в приложении.'
    },
    {
      'q': 'А если я передумаю? Смогу вернуть деньги?',
      'a': 'Скидки, мерч, привилегии и специальные предложения.'
    },
    {
      'q': 'А если компания закроется, что будет с моими деньгами?',
      'a': 'Скидки, мерч, привилегии и специальные предложения.'
    },
    {
      'q': 'Сколько стоит одна монета?',
      'a': 'Скидки, мерч, привилегии и специальные предложения.'
    },
    {
      'q': 'Как купить монеты? Это сложно?',
      'a': 'Скидки, мерч, привилегии и специальные предложения.'
    },
    {
      'q': 'А кто мне поможет, если что-то пойдёт не так?',
      'a': 'Скидки, мерч, привилегии и специальные предложения.'
    },
    {
      'q':
          'Можно ли использовать монеты для оплаты участия ребёнка в фестивалях и конкурсах?',
      'a': 'Скидки, мерч, привилегии и специальные предложения.'
    },
    {
      'q': 'Нужно ли платить налоги при использовании монет?',
      'a': 'Скидки, мерч, привилегии и специальные предложения.'
    },
    {
      'q': 'Сколько всего монет LTCoin может быть выпущено?',
      'a': 'Скидки, мерч, привилегии и специальные предложения.'
    },
  ];

  const _FaqSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Часто задаваемые вопросы', style: Styles.h3),
        const SizedBox(height: 24),
        ...items.map((e) => _FaqItem(question: e['q']!, answer: e['a']!)),
      ],
    );
  }
}
