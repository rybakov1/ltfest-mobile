// lib/pages/lt_winner_page.dart
import 'package:flutter/material.dart';
import 'ReferencePage.dart';

class LtWinnerPage extends StatelessWidget {
  const LtWinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReferencePage(
      title: 'LT Winner',
      imageAsset: 'assets/images/lt_winner_full.png',
      shareLink: 'https://t.me/LT_winner',
      ctaLabel: 'Перейти в Telegram',
      telegramLink: 'https://t.me/LT_winner',
      contentBlocks: [
        buildTextBlock(
            title: 'Добро пожаловать в LT СЧАСТЛИВЧИК!',
            text:
                'Это место, где выигрывают реальные и очень ценные призы: путешествия в Китай, Дубай и другие потрясающие места, билеты на лучшие фестивали, концерты, денежные призы и стильные подарки от Всероссийского фестивального движения LT FEST!'),
        const SizedBox(height: 2),
        buildStepsBlock(
          stepsTitle: "Как принять участие",
          steps: const [
            {
              'title': 'Шаг 1. Подпишитесь на канал',
              'subtitle':
                  'Чтобы перейти в Telegram-канал нажмите на кнопку “Перейти в Telegram”'
            },
            {
              'title': 'Шаг 2. Ознакомьтесь с условиями конкурса',
              'subtitle':
                  'Все конкурсы отличаются друг от друга, поэтому рекомендуем изучить условия.'
            },
            {
              'title': 'Шаг 3. Перейдите в Telegram бот',
              'subtitle':
                  'Перейдите по ссылке на наш специальный чат-бот для регистрации и оплаты участия'
            },
            {
              'title':
                  'Шаг 4. Оплатите участие и прикрепите чек об оплате в чат-боте',
              'subtitle':
                  'После проверки чека чат-бот автоматически присвоит вам уникальный номер для участия в розыгрыше.'
            },
          ],
        ),
      ],
    );
  }
}
