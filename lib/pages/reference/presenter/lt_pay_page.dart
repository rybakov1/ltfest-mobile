// lib/pages/lt_pay_page.dart
import 'package:flutter/material.dart';
import 'ReferencePage.dart';

class LtPayPage extends StatelessWidget {
  const LtPayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReferencePage(
      title: 'LT Pay',
      imageAsset: 'assets/images/lt_pay_full.png',
      shareLink: 'https://t.me/LTPay_Later_bot',
      ctaLabel: 'Перейти в Telegram',
      telegramLink: 'https://t.me/LTPay_Later_bot',
      contentBlocks: [
        buildTextBlock(title: 'Добро пожаловать в LT Pay!', text: 'LT Pay — новый продукт от LT FEST, который позволяет оформить участие в наших проектах — фестивалях, конкурсах, лабораториях и других творческих программах — с оплатой в рассрочку напрямую, без банков, проверок и кредитов. \nВсё просто: выбери срок, подтверди заявку — и путь к событию открыт.\nПервый платёж — через месяц.\nЭто удобно, прозрачно и честно. Как и должно быть.'),
        const SizedBox(height: 2),
        buildStepsBlock(
          stepsTitle: "3 простых шага — чтобы использовать LTPay",
          steps: const [
            {
              'title': 'Шаг 1. Перейдите в Telegram бот',
              'subtitle': 'Перейдите по ссылке на наш специальный чат-бот для оформления рассрочки напрямую от организатора.'
            },
            {
              'title': 'Шаг 2. Ознакомьтесь с условиями',
              'subtitle': 'Перед использованием сервиса обязательно ознакомьтесь с договором оферты в нашем боте.'
            },
            {
              'title': 'Шаг 3. Начнайте использовать бот',
              'subtitle': 'Наш бот сможет оформить рассрочку, показать историю оформления, поможет с оплатой и многое другое.'
            },
          ],
        ),
      ],
    );
  }
}
