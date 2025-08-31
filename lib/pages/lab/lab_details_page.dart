import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/components/favorite_button.dart';
import 'package:ltfest/data/models/favorite.dart';
import 'package:ltfest/providers/favorites_provider.dart';
import 'package:ltfest/providers/laboratory_provider.dart';
import 'package:ltfest/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/share_button.dart';
import '../../data/models/laboratory.dart';
import '../../data/models/person.dart';

final tabIndexProvider = StateProvider<int>((ref) => 0);
final learningTypeIndexProvider = StateProvider<int>((ref) => 0);

class LaboratoryDetailPage extends ConsumerStatefulWidget {
  final String id;

  const LaboratoryDetailPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<LaboratoryDetailPage> createState() =>
      _LaboratoryDetailPageState();
}

class _LaboratoryDetailPageState extends ConsumerState<LaboratoryDetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showHeader = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 120 && !_showHeader) {
        setState(() => _showHeader = true);
      } else if (_scrollController.offset <= 120 && _showHeader) {
        setState(() => _showHeader = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showPriceInfo(BuildContext context, laboratory) {
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
          padding:
              EdgeInsets.only(left: 16, right: 16, bottom: 24 + bottomPadding),
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
                        child: Center(
                          child: Text("Закрыть", style: Styles.button1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final Uri uri = Uri.parse(
                          laboratory.url!,
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
                          child: Text("Положение",
                              style: Styles.button1
                                  .copyWith(color: Palette.white)),
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

  void _showTeacherInfo(BuildContext context, Person person) {
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
          padding:
              EdgeInsets.only(left: 16, right: 16, bottom: 24 + bottomPadding),
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
                "${person.firstname} ${person.lastname}",
                style: Styles.h3,
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: person.image != null
                    ? Image.network(
                        'http://37.46.132.144:1337${person.image!.url}',
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
                person.description ?? 'Описание отсутствует',
                style: Styles.b2,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Palette.stroke),
                  ),
                  child: Center(
                    child: Text("Закрыть", style: Styles.button1),
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
  Widget build(BuildContext context) {
    final laboratoryAsync = ref.watch(laboratoryByIdProvider(widget.id));

    return Scaffold(
      backgroundColor: Palette.black,
      body: Stack(
        children: [
          laboratoryAsync.when(
            data: (laboratory) {
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            child: Image.network(
                                'http://37.46.132.144:1337${laboratory.image?.formats?.medium?.url ?? laboratory.image?.url ?? ''}',
                                height: 393,
                                width: double.infinity,
                                fit: BoxFit.cover)),
                        SafeArea(child: content(context, ref, laboratory)),
                      ],
                    ),
                    SizedBox(
                        height: 48 + MediaQuery.of(context).padding.bottom),
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
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                  top: 24,
                  right: 16,
                  left: 16),
              child: GestureDetector(
                onTap: () async {
                  final Uri uri = Uri.parse(
                    laboratoryAsync
                        .value!.websiteurl!, //TODO: not weburl its entryurl
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
                      child: Text("Заявка на обучение",
                          style: Styles.button1.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          laboratoryAsync.when(
            data: (laboratory) => AnimatedOpacity(
              opacity: _showHeader ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 16,
                    left: 16,
                    right: 16,
                    bottom: 20),
                height: 210,
                decoration: BoxDecoration(
                  color: Palette.black,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            width: 43,
                            height: 43,
                            color: const Color.fromRGBO(255, 255, 255, 0.5),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Palette.white,
                                size: 24,
                              ),
                              onPressed: () {
                                context.pop();
                              },
                            ),
                          ),
                        ),
                        const Spacer(),
                        ShareButton(
                            link: laboratory.websiteurl ?? "https://ltfest.ru"),
                        const SizedBox(width: 8),
                        FavoriteButtonDetails(
                          id: laboratory.id,
                          eventType: EventType.festival,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      laboratory.title,
                      style: Styles.h3.copyWith(color: Palette.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showPriceInfo(context, laboratory),
                      child: Row(
                        children: [
                          Text(
                            laboratory.learningTypes?.isNotEmpty ?? false
                                ? "от ${(laboratory.learningTypes!.length > 2 ? laboratory.learningTypes![2].price : laboratory.learningTypes!.last.price)} ₽/чел"
                                : "Цена недоступна",
                            style: Styles.h4.copyWith(color: Palette.white),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset('assets/icons/info.svg',
                              color: Palette.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10.0,
                      sigmaY: 10.0,
                    ),
                    child: Container(
                      width: 43,
                      height: 43,
                      color: const Color.fromRGBO(255, 255, 255, 0.5),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Palette.white,
                          size: 24,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                ShareButton(link: laboratory.websiteurl ?? "https://ltfest.ru"),
                const SizedBox(width: 8),
                FavoriteButtonDetails(
                    id: laboratory.id, eventType: EventType.laboratory),
              ],
            ),
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
                  GestureDetector(
                    onTap: () => _showPriceInfo(context, laboratory),
                    child: Row(
                      children: [
                        Text(
                          laboratory.learningTypes?.isNotEmpty ?? false
                              ? "от ${(laboratory.learningTypes!.length > 2 ? laboratory.learningTypes![2].price : laboratory.learningTypes!.last.price)} ₽/чел"
                              : "Цена недоступна",
                          style: Styles.h4.copyWith(color: Palette.gray),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset('assets/icons/info.svg'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/calendar.svg'),
                      const SizedBox(width: 12),
                      Text(
                        "${DateFormat("dd.MM.yyyy", "ru").format(laboratory.firstDayDate!)} - ${DateFormat("dd.MM.yyyy", "ru").format(laboratory.lastDayDate!)}",
                        style: Styles.b2.copyWith(color: Palette.gray),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/map_point.svg'),
                      const SizedBox(width: 12),
                      Text(
                        laboratory.address ?? 'Не указано',
                        style: Styles.b2,
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
                  Container(
                    decoration: BoxDecoration(
                        color: Palette.background,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                ref.read(tabIndexProvider.notifier).state = 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    tabIndex == 0 ? Palette.primaryLime : null,
                              ),
                              child: Center(
                                child: Text(
                                  "Основное",
                                  style: Styles.h5.copyWith(
                                    color: tabIndex == 0
                                        ? Palette.white
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
                                color:
                                    tabIndex == 1 ? Palette.primaryLime : null,
                              ),
                              child: Center(
                                child: Text(
                                  "Программа",
                                  style: Styles.h5.copyWith(
                                    color: tabIndex == 1
                                        ? Palette.white
                                        : Palette.gray,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    laboratory.persons?.isNotEmpty ?? false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: laboratory.persons!
                                .asMap()
                                .entries
                                .expand(
                                  (entry) => [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
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
                                                child: entry.value.image != null
                                                    ? Image.network(
                                                        'http://37.46.132.144:1337${entry.value.image?.formats?.medium?.url ?? entry.value.image?.url ?? ''}',
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
                                        laboratory.persons!.length - 1)
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
                                        iconColor: Palette.primaryLime,
                                        //const Color(0xFF1C274C)
                                        collapsedIconColor: Palette.gray,
                                        title: Text(
                                          "День ${dayIndex + 1}",
                                          style: Styles.h4,
                                        ),
                                        subtitle: Text(
                                          DateFormat('dd MMMM yyyy', 'ru')
                                              .format(day.date!),
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
                                                      Flexible(
                                                        child: Text(
                                                          "${eventIndex + 1}. ${event.title}",
                                                          style: Styles.h5,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      if (event.eventTime !=
                                                          null)
                                                        Text(
                                                          '${event.eventTime?.split(':')[0]}:${event.eventTime?.split(':')[1]}',
                                                          style: Styles.h5,
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
