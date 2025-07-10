import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/providers/laboratory_provider.dart';
import 'package:ltfest/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/laboratory.dart';
import '../../data/models/teacher.dart';

final tabIndexProvider = StateProvider<int>((ref) => 0);
final learningTypeIndexProvider = StateProvider<int>((ref) => 0);

class LaboratoryDetailPage extends ConsumerWidget {
  final String id;

  const LaboratoryDetailPage({
    super.key,
    required this.id,
  });

  void _showPriceInfo(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 24 + bottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 41,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Palette.stroke,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text('Информация о тарифах', style: Styles.h4),
              ),
              const SizedBox(height: 32),
              Text(
                'Стоимость зависит от выбранного тарифа. Чтобы ознакомиться с тарифами, просмотрите положение мероприятия.',
                style: Styles.b2,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Palette.stroke),
                        ),
                        child: const Center(
                          child: Text(
                            "Закрыть",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final Uri uri = Uri.parse(
                          'https://ltfest.artpro.art/webapp/public/application/af419d70-ec8d-42fb-a4b1-65482dcd3236',
                        );
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Palette.primaryLime,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Положение",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Palette.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTeacherInfo(BuildContext context, Teacher teacher) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 24 + bottomPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 41,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Palette.stroke,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text('Состав преподавателей', style: Styles.h4),
              ),
              const SizedBox(height: 32),
              Text(
                "${teacher.firstname} ${teacher.lastname}",
                style: Styles.h3,
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: teacher.image != null && teacher.image!.isNotEmpty
                    ? Image.network(
                        teacher.image!,
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/jury_placeholder.png',
                          height: 240,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/images/jury_placeholder.png',
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 16),
              Text(
                teacher.description ?? 'Описание отсутствует',
                style: Styles.b2,
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Palette.black),
                  ),
                  child: const Center(
                    child: Text(
                      "Закрыть",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final laboratoryAsync = ref.watch(laboratoryByIdProvider(id));

    return Scaffold(
      backgroundColor: Palette.black,
      body: Stack(
        children: [
          laboratoryAsync.when(
            data: (laboratory) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          child: laboratory.image!.isNotEmpty
                              ? Image.network(laboratory.image!,
                                  height: 393,
                                  width: double.infinity,
                                  fit: BoxFit.cover)
                              : Image.asset(
                                  'assets/images/teatr_placeholder.png',
                                  height: 393,
                                  width: double.infinity,
                                  fit: BoxFit.cover),
                        ),
                        SafeArea(child: content(context, ref, laboratory)),
                      ],
                    ),
                     SizedBox(height: 48 + MediaQuery.of(context).padding.bottom),
                  ],
                ),
              );
            },
            loading: () => const SingleChildScrollView(),
            error: (error, stack) => Container(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Palette.white,
              ),
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom, top: 24, right: 16, left: 16),
              child: GestureDetector(
                onTap: () async {
                  final Uri uri = Uri.parse(
                    'https://ltfest.artpro.art/webapp/public/application/af419d70-ec8d-42fb-a4b1-65482dcd3236',
                  );
                  await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Container(
                    width: double.infinity,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Palette.primaryLime,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Заявка на обучение",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Palette.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget content(BuildContext context, WidgetRef ref, Laboratory laboratory) {
    final learningTypeIndex = ref.watch(learningTypeIndexProvider);
    final tabIndex = ref.watch(tabIndexProvider);

    if (!(laboratory.learningTypes?.isNotEmpty ?? false) ||
        learningTypeIndex >= (laboratory.learningTypes?.length ?? 0)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(learningTypeIndexProvider.notifier).state = 0;
      });
    }

    String formatMoney(int amount) {
      final formatter = NumberFormat.currency(
        locale: 'ru_RU',
        symbol: '₽',
        decimalDigits: 0,
      );
      return formatter.format(amount).replaceAll(',', ' ');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    width: 43,
                    height: 43,
                    color: const Color.fromRGBO(142, 142, 142, 1),
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Palette.white,
                          size: 18,
                        ),
                        onPressed: () =>
                            GoRouter.of(context).pop() //context.go('/lab'),
                        ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 300),
          Container(
            width: double.infinity,
            decoration: Decor.base,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    laboratory.title,
                    style: Styles.h3,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        laboratory.learningTypes?.isNotEmpty ?? false
                            ? "от ${(laboratory.learningTypes!.length > 2 ? laboratory.learningTypes![2].price : laboratory.learningTypes!.last.price)} ₽/чел"
                            : "Цена недоступна",
                        style: Styles.h4.copyWith(color: Palette.gray),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _showPriceInfo(context),
                        child: SvgPicture.asset('assets/icons/info.svg'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: Decor.base,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              ref.read(tabIndexProvider.notifier).state = 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: tabIndex == 0 ? Palette.primaryLime : null,
                            ),
                            child: Center(
                              child: Text(
                                "Основное",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: tabIndex == 0
                                      ? Palette.black
                                      : Palette.gray,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              ref.read(tabIndexProvider.notifier).state = 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: tabIndex == 1 ? Palette.primaryLime : null,
                            ),
                            child: Center(
                              child: Text(
                                "Программа",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: tabIndex == 1
                                      ? Palette.black
                                      : Palette.gray,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  if (tabIndex == 0) ...[
                    Text(
                      "Описание",
                      style: Styles.h4,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      laboratory.description ?? 'Описание отсутствует',
                      style: Styles.b2,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Преподаватели",
                      style: Styles.h4,
                    ),
                    const SizedBox(height: 16),
                    laboratory.teachers?.isNotEmpty ?? false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: laboratory.teachers!
                                .asMap()
                                .entries
                                .expand(
                                  (entry) => [
                                    Flexible(
                                      child: InkWell(
                                        onTap: () => _showTeacherInfo(
                                            context, entry.value),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: entry.value.image !=
                                                            null &&
                                                        entry.value.image!
                                                            .isNotEmpty
                                                    ? Image.network(
                                                        entry.value.image!,
                                                        height: 150,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Image.asset(
                                                          'assets/images/jury_placeholder.png',
                                                          height: 150,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        'assets/images/jury_placeholder.png',
                                                        height: 150,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                              const SizedBox(height: 12),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${entry.value.firstname}\n${entry.value.lastname}',
                                                    style: Styles.h4,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Подробнее',
                                                    style: Styles.b3.copyWith(
                                                        color:
                                                            Palette.secondary),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (entry.key <
                                        laboratory.teachers!.length - 1)
                                      const SizedBox(width: 12),
                                  ],
                                )
                                .toList(),
                          )
                        : Text(
                            "Информация о преподавателях отсутствует",
                            style: Styles.b2.copyWith(color: Palette.gray),
                          ),
                  ] else ...[
                    const SizedBox(height: 24),
                    laboratory.days?.isNotEmpty ?? false
                        ? Column(
                            children: laboratory.days!.asMap().entries.map(
                              (entry) {
                                final dayIndex = entry.key;
                                final day = entry.value;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Palette.stroke),
                                    ),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                      ),
                                      child: ExpansionTile(
                                        title: Text(
                                          "День ${dayIndex + 1}",
                                          style: Styles.h4,
                                        ),
                                        subtitle: Text(
                                          DateFormat('dd MMMM yyyy', 'ru').format(day.date!),
                                          style: Styles.b2
                                              .copyWith(color: Palette.gray),
                                        ),
                                        children: day.events
                                                ?.asMap()
                                                .entries
                                                .map(
                                              (eventEntry) {
                                                final eventIndex =
                                                    eventEntry.key;
                                                final event = eventEntry.value;
                                                return ListTile(
                                                  title: Row(
                                                    children: [
                                                      Text(
                                                        "${eventIndex + 1}. ${event.title}",
                                                        style: Styles.b2,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        '${event.eventTime?.split(':')[0]}:${event.eventTime?.split(':')[1]}',
                                                        style: Styles.b3
                                                            .copyWith(
                                                                color: Palette
                                                                    .gray),
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        event.description ??
                                                            'Описание отсутствует',
                                                        style: Styles.b2,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ).toList() ??
                                            [],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          )
                        : Text(
                            "Информация о программе отсутствует",
                            style: Styles.b2.copyWith(color: Palette.gray),
                          ),
                  ],
                ],
              ),
            ),
          ),
          Container(
            decoration: Decor.base,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  laboratory.learningTypes?.isNotEmpty ?? false
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              laboratory.learningTypes!.length,
                              (i) => Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: GestureDetector(
                                  onTap: () => ref
                                      .read(learningTypeIndexProvider.notifier)
                                      .state = i,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: learningTypeIndex == i
                                            ? Palette.secondary
                                            : Palette.stroke,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          laboratory.learningTypes![i].type,
                                          style: Styles.b3
                                              .copyWith(color: Palette.gray),
                                        ),
                                        Text(
                                          formatMoney(laboratory
                                              .learningTypes![i].price),
                                          style: Styles.b3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Text(
                          "Типы обучения недоступны",
                          style: Styles.b2.copyWith(color: Palette.gray),
                        ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/calendar.svg', width: 16),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Даты", style: Styles.h5),
                            Text(
                              laboratory.learningTypes?.isNotEmpty ?? false
                                  ? laboratory.learningTypes![learningTypeIndex]
                                          .dateInfo ??
                                      'Даты неизвестны'
                                  : 'Даты недоступны',
                              style: Styles.b2,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/map_point.svg', width: 16),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Место", style: Styles.h5),
                            Text(
                              laboratory.learningTypes?.isNotEmpty ?? false
                                  ? laboratory.learningTypes![learningTypeIndex]
                                          .location ??
                                      'Место неизвестно'
                                  : 'Место недоступно',
                              style: Styles.b2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/calendar.svg', width: 16),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Время прохождения", style: Styles.h5),
                            Text(
                              laboratory.learningTypes?.isNotEmpty ?? false
                                  ? laboratory.learningTypes![learningTypeIndex]
                                          .duration ??
                                      'Длительность неизвестна'
                                  : 'Длительность недоступна',
                              style: Styles.b2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/calendar.svg', width: 16),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Сертификат", style: Styles.h5),
                            Text(
                              laboratory.learningTypes?.isNotEmpty ?? false
                                  ? laboratory.learningTypes![learningTypeIndex]
                                          .certificate ??
                                      'Сертификат неизвестен'
                                  : 'Сертификат недоступен',
                              style: Styles.b2,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
