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
      shareLink: 'https://ltfest.ru/helper',
      ctaLabel: 'Перейти в Telegram',
      telegramLink: 'https://t.me/LTfest_bot',
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
        Container(
          decoration: Decor.base,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12)
              .copyWith(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Что умеет LT Консьерж", style: Styles.h3),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/images/concierge_first.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Напишем сценарии, тексты, письма",
                            style: Styles.h4,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/images/concierge_2.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Найдём конкурсы и мастер-классы",
                            style: Styles.h4,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/images/concierge_3.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Подберём музыку, реквизит, визуальные решения",
                        style: Styles.h4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/images/concierge_4.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Придумаем идеи для проекта",
                            style: Styles.h4,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/images/concierge_5.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Поможем с организацией мероприятий",
                            style: Styles.h4,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/images/concierge_6.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "И многое другое — в зависимости от вашей задачи",
                        style: Styles.h4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
    {
      'q': 'Кто отвечает на вопросы: машина или человек?',
      'a':
          'LT Консьерж — это команда профессиональных менеджеров, которые работают совместно с искусственным интеллектом. Но с вами всегда общается не машина, а живой человек.'
    },
    {
      'q': 'Что именно может LT Консьерж?',
      'a':
          'LT Консьерж способен решить любые вопросы творческих людей. Например:\n\t● Написать сценарий.\n\t● Предложить концепцию спектакля.\n\t● Помочь с подбором реквизита.\n\t● Создать программу обучения.\n\t● Предоставить новые упражнения по актёрскому мастерству.\n\t● Дать идеи хореографам для постановки танцев.\n\t● Подобрать материал для спектакля на конкретное количество участников.\n\t● Мы — ваша творческая поддержка и правая рука в любом проекте.'
    },
    {
      'q': 'Сколько стоят услуги LT Консьержа?',
      'a':
          'Первый запрос абсолютно бесплатный. Далее чат-бот предложит оформить подписку стоимостью 590 руб. в месяц.'
    },
    {
      'q':
          'Может ли Консьерж помочь организовать поездку коллектива на фестиваль?',
      'a':
          'Да! Мы поможем выбрать подходящий фестиваль, свяжемся с организаторами, купим авиабилеты или ЖД-билеты, забронируем гостиницы и организуем экскурсионную программу.'
    },
    {
      'q':
          'Может ли Консьерж помочь с созданием портфолио творческого коллектива?',
      'a':
          'Безусловно! Мы подберём лучшие материалы, разработаем визуальное оформление и поможем с текстами для презентаций и заявок.'
    },
    {
      'q': 'Можно ли обратиться к вам за идеями для выступлений на конкурсах?',
      'a':
          'Конечно! Консьерж регулярно подбирает свежие, оригинальные идеи, подходящие именно для вашего коллектива и формата мероприятия.'
    },
    {
      'q':
          'Может ли Консьерж помочь найти спонсоров и партнёров для творческого проекта?',
      'a':
          'Да, мы поможем с поиском потенциальных спонсоров, оформим коммерческое предложение и организуем переговоры.'
    },
    {
      'q': 'Возможно ли получить помощь с подбором костюмов и декораций?',
      'a':
          'Да, мы поможем найти подходящие варианты, свяжемся с ателье или мастерскими, предоставим варианты по бюджету и срокам.'
    },
    {
      'q':
          'Могу ли я получить консультацию по повышению уровня своего коллектива?',
      'a':
          'Конечно! Консьерж предложит вам конкретные шаги по развитию вашего творческого коллектива, включая методики, мастер-классы и тренинги.'
    },
    {
      'q':
          'Могут ли участники задавать вопросы индивидуально, а не от лица коллектива?',
      'a':
          'Да, Консьерж доступен каждому участнику индивидуально, помогая решить личные творческие задачи и профессиональные вопросы.'
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
