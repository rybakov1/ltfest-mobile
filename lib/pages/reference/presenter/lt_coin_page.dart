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
          title: 'Монета, которая помогает планировать будущее',
          text:
              "LTCoin — это удобная виртуальная единица, которая позволяет уверенно откладывать средства на образование и творческое развитие ваших детей.",
        ),
        _buildBenefitsBlock(),
        const SizedBox(height: 2),
        buildStepsBlock(
          stepsTitle: "3 простых шага — чтобы начать использовать LTCoin",
          steps: const [
            {
              'title': 'Шаг 1. Покупаете монеты',
              'subtitle':
                  'Приобретаете LTCoin по начальной цене — от 25 рублей за монету'
            },
            {
              'title': 'Шаг 2. Следите за ростом стоимости монеты',
              'subtitle':
                  'Базовая стоимость LTCoin может периодически корректироваться компанией с учётом результатов её деятельности. Рыночная стоимость определяется спросом и предложением среди пользователей платформы.'
            },
            {
              'title': 'Шаг 3. Используете монеты',
              'subtitle':
                  'Используйте LTCoin для оплаты программ и мероприятий, обменивайтесь монетами с другими участниками платформы или, при необходимости, передавайте их другим пользователям на условиях, согласованных между сторонами.\nТакже вы всегда можете вернуть монеты в компанию по стоимости приобретения.'
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
                'С LTCoin вы можете оплатить участие в программах или, при желании, обмениваться монетами с другими участниками, если их стоимость изменилась, на взаимовыгодных условиях.',
          ),
          const SizedBox(height: 24),
          item(
            image: 'assets/images/coin_bank.png',
            title: 'Это просто и надёжно',
            text:
                'Приобрести LTCoin просто — прямо через Telegram-бот, начиная всего от 25 рублей за монету.',
          ),
          const SizedBox(height: 24),
          item(
            image: 'assets/images/coin_perspective.png',
            title: 'Прозрачно и перспективно',
            text:
                '20% прибыли от мероприятий LT Fest, а также доходы от банковских вкладов направляются на поддержку платформы LTCoin и могут влиять на изменение её базовой стоимости.',
          ),
        ],
      ),
    );
  }

  Widget _buildIllustratedSections() {
    Widget section({required String title, required String imageAsset}) {
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
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: Styles.h3,
                textAlign: TextAlign.center,
              ),
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
          ),
        ),
      ],
    );
  }

  Widget _buildFaqSection() {
    final List<Map<String, String>> faqItems = [
      {
        'q': 'Для чего нужна эта монета?',
        'a':
            'LT Coin — внутренняя единица учёта, которая даёт вам гибкость: используйте её для участия в мероприятиях LT Fest, передавайте другим участникам на взаимовыгодных условиях или при необходимости возвращайте в компанию.\n\nБлагодаря прозрачной системе и понятным правилам вы сами решаете, когда и как использовать LTCoin.'
      },
      {
        'q': 'Это как криптовалюта? Нужно устанавливать что-то особенное?',
        'a':
            'Нет. LTCoin — не криптовалюта и не требует приложений или кошельков. Это внутренняя накопительная система компании, работает через бот в Telegram'
      },
      {
        'q': 'А если я передумаю? Смогу вернуть деньги?',
        'a':
            'Да. Вы можете вернуть монеты компании и получить обратно сумму, по которой они были приобретены, без штрафов и в любое время — при условии соблюдения условий оферты.'
      },
      {
        'q': 'Кто-то контролирует, куда идут деньги?',
        'a':
            'Да. Средства клиентов хранятся на отдельном застрахованном банковском счёте, а компания публикует финансовую отчётность на регулярной основе.'
      },
      {
        'q': 'А если компания закроется, что будет с моими деньгами?',
        'a':
            'Средства клиентов размещены на отдельном банковском счёте. В случае прекращения деятельности компании возврат осуществляется в рамках действующего законодательства РФ и условий публичной оферты.'
      },
      {
        'q': 'Сколько стоит одна монета?',
        'a':
            'Начальная цена — от 25 рублей. Это значит, вы можете начать даже с небольшой суммы.'
      },
      {
        'q': 'Как купить монеты? Это сложно?',
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
            'Можно ли использовать монеты для оплаты участия ребёнка в фестивалях и конкурсах?',
        'a':
            'Да. LT Coin можно использовать для оплаты любых детских мероприятий, конкурсов и фестивалей, которые организует «LT Fest».'
      },
      {
        'q': 'Нужно ли платить налоги при использовании монет?',
        'a': 'Если вы используете монеты для оплаты участия в программах, налоговые обязательства не возникают.\nОднако при передаче монет другим лицам с получением дохода, в соответствии с Налоговым кодексом РФ, физическое лицо обязано задекларировать полученную сумму и уплатить налог на доходы физических лиц (НДФЛ) по ставке 13%.'
      },
      {
        'q': 'Сколько всего монет LTCoin может быть выпущено?',
        'a': 'На начальном этапе предусмотрен лимит в 10 000 000 (десять миллионов) монет LTCoin.\nКомпания оставляет за собой право изменить объём выпуска, если это потребуется по экономическим причинам.\nВ случае изменения объёма эмиссии все пользователи будут уведомлены минимум за 14 календарных дней.\nЛюбое увеличение количества монет будет проводиться только с соблюдением интересов клиентов и принципов прозрачности.'
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
                // Добавляем разделитель после каждого элемента, кроме последнего
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
