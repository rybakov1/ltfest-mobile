// lib/pages/lt_concierge_page.dart
import 'package:flutter/material.dart';
import 'package:ltfest/constants.dart';
import 'ReferencePage.dart';

class LtConciergePage extends StatelessWidget {
  const LtConciergePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReferencePage(
      title: 'LT Консьерж',
      imageAsset: 'assets/images/concierge_full.png',
      shareLink: 'https://ltfest.ru',
      ctaLabel: 'Перейти в Telegram',
      telegramLink: 'https://t.me/ltfest',
      contentBlocks: [
        buildTextBlock(
            title: "Творите, а остальное — \nмы возьмём на себя",
            text:
                "LT Консьерж — это умный чат-бот, созданный специально для людей, занятых в креативной сфере. Он помогает решать любые творческие и организационные задачи — быстро, персонализированно и без лишней суеты."),
        const SizedBox(height: 2),
        buildStepsBlock(
          stepsTitle: "Как это работает",
          steps: const [
            {
              'title': 'Шаг 1. Напишите в чат-бот',
              'subtitle': 'Сформулируйте задачу и добавьте нужные детали'
            },
            {
              'title': 'Шаг 2. Получите ответ',
              'subtitle':
                  'Получите точный, готовый ответ от LT Консьерж — сценарий, список, подборку или решение.'
            },
            {
              'title': 'Шаг 3. Наслаждайтесь готовым результатом!',
              'subtitle':
                  'С LT Консьерж вы всегда свободны от рутины и полностью погружены в творчество!'
            },
          ],
        ),
        const SizedBox(height: 2),
        buildStepsBlock(
          stepsTitle: "Условия и подписка",
          steps: const [
            {
              'title': 'Первый запрос - Бесплатно',
              'subtitle': 'Попробуйте и убедитесь в эффективности.'
            },
            {
              'title': 'Оплата со второго запроса',
              'subtitle':
                  'Со второго запроса активируется подписка на 1 месяц — вы получаете неограниченный доступ к помощи LT Консьерж.\nОплата производится прямо в чат-боте через удобные платёжные системы после второго запроса.'
            }
          ],
        ),
        const SizedBox(height: 2),
        _buildFaqSection(),
      ],
    );
  }
}

Widget _buildFaqSection() {
  final List<Map<String, String>> faqItems = [
    {'q': 'Кто отвечает на вопросы: машина или человек?', 'a': 'Нет ответа.'},
    {'q': 'Что именно может LT Консьерж?', 'a': 'Нет ответа.'},
    {'q': 'Сколько стоят услуги LT Консьержа?', 'a': 'Нет ответа.'},
    {
      'q':
          'Может ли Консьерж помочь организовать поездку коллектива на фестиваль?',
      'a': 'Нет ответа.'
    },
    {
      'q':
          'Может ли Консьерж помочь с созданием портфолио творческого коллектива?',
      'a': 'Нет ответа.'
    },
    {
      'q': 'Можно ли обратиться к вам за идеями для выступлений на конкурсах?',
      'a': 'Нет ответа.'
    },
    {
      'q':
          'Может ли Консьерж помочь найти спонсоров и партнёров для творческого проекта?',
      'a': 'Нет ответа.'
    },
    {
      'q': 'Возможно ли получить помощь с подбором костюмов и декораций?',
      'a': 'Нет ответа.'
    },
    {
      'q':
          'Могу ли я получить консультацию по повышению уровня своего коллектива?',
      'a': 'Нет ответа.'
    },
    {
      'q':
          'Могут ли участники задавать вопросы индивидуально, а не от лица коллектива?',
      'a': 'Нет ответа.'
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
