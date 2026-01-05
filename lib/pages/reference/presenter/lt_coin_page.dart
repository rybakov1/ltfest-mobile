// lib/pages/lt_coin_page.dart
import 'package:flutter/material.dart';
import 'package:ltfest/constants.dart';

import 'ReferencePage.dart';

class LtCoinPage extends StatelessWidget {
  const LtCoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReferencePage(
      title: 'LT Coin',
      imageAsset: 'assets/images/lt_coin_full.png',
      shareLink: 'https://t.me/LTfest_coin_bot',
      ctaLabel: 'Перейти в Telegram',
      telegramLink: 'https://t.me/LTfest_coin_bot',
      contentBlocks: [
        buildTextBlock(
          title: 'Удобная единица учета для программ LT Fest',
          text:
              "LTCoin - внутренняя единица учёта, с которой удобно планировать и оплачивать участие в программах и мероприятиях LT Fest",
        ),
        _buildBenefitsBlock(),
        const SizedBox(height: 2),
        buildStepsBlock(
          stepsTitle: "3 простых шага — чтобы начать использовать LTCoin",
          steps: const [
            {
              'title': 'Шаг 1. Покупаете LTCoin',
              'subtitle':
                  'Приобретаете LTCoin по начальной цене — от 25 рублей за бонусную единицу'
            },
            {
              'title': 'Шаг 2. Проверяйте актуальную базовую стоимость',
              'subtitle':
                  'Базовая стоимость LTCoin может периодически корректироваться компанией. При обмене между участниками цена определяется договорённостью сторон.'
            },
            {
              'title': 'Шаг 3. Используйте LTCoin',
              'subtitle':
                  'Используйте LTCoin для оплаты программ и мероприятий, обменивайтесь LTCoin с другими участниками платформы на условиях, согласованных между сторонами.\nТакже вы всегда можете вернуть LTCoin в компанию по стоимости приобретения. LTCoin, полученные в подарок, не возвращаются.'
            },
          ],
        ),
        _buildIllustratedSections(),
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Styles.h3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: Styles.b2,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Container(
      decoration: Decor.base,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          item(
            image: 'assets/images/coin.png',
            title: 'Позаботьтесь о будущем детей уже сейчас',
            text:
                'С LTCoin вы можете оплачивать участие в программах и, при желании, обмениваться бонусными единицами с другими участниками на условиях, которые вы согласуете между собой.',
          ),
          const SizedBox(height: 24),
          item(
            image: 'assets/images/coin_bank.png',
            title: 'Это просто и надежно',
            text:
                'Приобрести LTCoin просто — прямо через Telegram-бот, начиная всего от 25 рублей за бонусную единицу.',
          ),
          const SizedBox(height: 24),
          item(
            image: 'assets/images/coin_perspective.png',
            title: 'Прозрачно и понятно',
            text:
                'Платформа LTCoin развивается за счёт ресурсов LT Fest. Базовая стоимость бонусной единицы может периодически корректироваться компанией. Все актуальные условия и правила доступны в приложении.',
          ),
        ],
      ),
    );
  }

  Widget _buildIllustratedSections() {
    Widget section(
        {required String title,
        required String imageAsset,
        String? additionals}) {
      return Stack(
        children: [
          Container(
            decoration: Decor.base,
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              height: 336,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 336,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    title,
                    style: Styles.h3,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    additionals ?? "",
                    style: Styles.b3,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 2), // чтобы не сливался с предыдущим блоком
        Container(
          decoration: Decor.base,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Всё прозрачно и под контролем', style: Styles.h2),
              const SizedBox(height: 24),
              section(
                  title: 'Ваши операции полностью защищены',
                  imageAsset: 'assets/images/lt_coin_defend.png',
                  additionals:
                      '*Все операции фиксируются, история действий доступна пользователю через Telegram-бот'),
              const SizedBox(height: 8),
              section(
                title: 'Мы гарантируем прозрачность всех операций и отчётов',
                imageAsset: 'assets/images/lt_coin_clear.png',
              ),
              const SizedBox(height: 8),
              section(
                title: 'Вы всегда можете вернуть LTCoin в компанию по стоимости приобретения',
                imageAsset: 'assets/images/lt_coin_back.png',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFaqSection() {
    final List<Map<String, String>> faqItems = [
      {
        'q': 'Для чего нужна эта бонусная единица (LTCoin)?',
        'a':
            'LTCoin — внутренняя бонусная единица учёта LT Fest, которая даёт гибкость в использовании.\nВы можете применять её для оплаты участия в мероприятиях и программах LT Fest, передавать другим участникам или при необходимости возвращать в компанию в соответствии с условиями договора оферты.\nВсе правила использования LTCoin прозрачны и заранее определены.'
      },
      {
        'q': 'Это как криптовалюта? Нужно устанавливать что-то особенное?',
        'a':
            'Нет. LTCoin не является криптовалютой и не требует установки кошельков или специальных приложений.\nВсе операции с LTCoin осуществляются через Telegram-бот LT Fest.'
      },
      {
        'q': 'А если я передумаю, смогу вернуть LTCoin?',
        'a':
            'Да. Вы можете вернуть LTCoin в компанию.\nВозврат осуществляется по цене, по которой соответствующие LTCoin были изначально приобретены у компании, при соблюдении условий договора оферты.\n\nЕсли LTCoin были получены от других пользователей (в том числе через покупку или обмен), возврат также возможен, но по цене их первоначальной покупки у компании, а не по цене сделки между пользователями.'
      },
      {
        'q':
            'Если я купил LTCoin у другого пользователя дороже, чем он покупал их у компании, по какой цене будет возврат?',
        'a':
            'При возврате LTCoin в компанию применяется цена первоначальной покупки у компании.\nЕсли вы приобрели LTCoin у другого пользователя по более высокой цене, разница между ценой сделки и ценой возврата является риском пользователя.'
      },
      {
        'q': 'Что такое подарочные LTCoin и можно ли их вернуть в компанию?',
        'a':
            'Подарочные LTCoin — это бонусные единицы, предоставленные пользователю без оплаты в рамках акций или специальных предложений.\nВы можете применять её для оплаты до 50% участия в мероприятиях и программах LT Fest и передавать другим участникам программы.'
      },
      {
        'q': 'А если компания закроется, что будет с моими деньгами?',
        'a':
            'В случае прекращения деятельности компании возврат средств осуществляется в рамках действующего законодательства РФ и условий публичной оферты.'
      },
      {
        'q': 'Сколько стоит одна бонусная единица LTCoin?',
        'a':
            'Начальная цена LTCoin — от 25 рублей.\nБазовая стоимость LTCoin может корректироваться компанией в соответствии с условиями договора оферты.'
      },
      {
        'q': 'Как купить LTCoin? Это сложно?',
        'a':
            'Очень просто. Регистрируйтесь в Telegram-боте и оплачиваете банковской картой — как в любом интернет-магазине.'
      },
      {
        'q': 'А кто мне поможет, если что-то пойдёт не так?',
        'a':
            'Если у вас возникли вопросы или что-то пошло не так, вы всегда можете обратиться в службу поддержки прямо через наш Telegram-бот. Мы оперативно поможем вам разобраться в ситуации и найти решение.'
      },
      {
        'q':
            'Можно ли использовать LTCoin для оплаты участия ребёнка в фестивалях и конкурсах?',
        'a':
            'Да. LT Coin можно использовать для оплаты любых детских мероприятий, конкурсов и фестивалей, которые организует «LT Fest».'
      },
      {
        'q': 'Нужно ли платить налоги при использовании LTCoin?',
        'a':
            'Если вы используете LTCoin для оплаты участия в программах и мероприятиях LT Fest, налоговые обязательства не возникают.\nПри передаче LTCoin другим лицам с получением дохода пользователь самостоятельно несёт ответственность за соблюдение налогового законодательства РФ.'
      },
      {
        'q': 'Сколько всего LTCoin может быть выпущено?',
        'a':
            'На старте платформа использует ограниченный объём LTCoin — до 10 000 000 бонусных единиц.\nКомпания может корректировать общий объём LTCoin, уведомляя пользователей заранее и действуя в рамках договора оферты.'
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
          Column(
            children: [
              for (int i = 0; i < faqItems.length; i++) ...[
                FaqItem(
                  question: faqItems[i]['q']!,
                  answer: faqItems[i]['a']!,
                ),
                if (i < faqItems.length - 1)
                  Divider(
                    color: Palette.stroke,
                    height: 1,
                    thickness: 1,
                  ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
