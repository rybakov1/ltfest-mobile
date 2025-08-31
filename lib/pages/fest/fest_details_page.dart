import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/components/favorite_button.dart';
import 'package:ltfest/components/share_button.dart';
import 'package:ltfest/data/models/person.dart';
import 'package:ltfest/providers/favorites_provider.dart';
import 'package:ltfest/providers/festival_provider.dart';
import 'package:ltfest/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class FestivalDetailPage extends ConsumerStatefulWidget {
  final String id;

  const FestivalDetailPage({super.key, required this.id});

  @override
  ConsumerState<FestivalDetailPage> createState() => _FestivalDetailPageState();
}

class _FestivalDetailPageState extends ConsumerState<FestivalDetailPage> {
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

  void _showPriceInfo(BuildContext context, festival) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
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
              const SizedBox(height: 32),
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
                          border: Border.all(
                            color: Palette.stroke,
                          ),
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
                          festival.pdfurl!,
                        );
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Palette.primaryLime,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "Положение",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        );
      },
    );
  }

  void _showJuryInfo(BuildContext context, Person person) {
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
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
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
                child: Text('Состав жюри', style: Styles.h4),
              ),
              const SizedBox(height: 32),
              Text("${person.firstname} ${person.lastname}", style: Styles.h3),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'http://37.46.132.144:1337${person.image?.formats?.medium?.url ?? person.image?.url ?? ''}',
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(person.description ?? 'Описание отсутствует'),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Palette.stroke,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Закрыть",
                      style: Styles.button1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final festivalAsync = ref.watch(festivalByIdProvider(widget.id));

    return Scaffold(
      backgroundColor: Palette.black,
      body: Stack(
        children: [
          festivalAsync.when(
            data: (festival) => SingleChildScrollView(
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
                          'http://37.46.132.144:1337${festival.image?.formats?.medium?.url ?? festival.image?.url ?? ''}',
                          height: 390,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: Container(
                                        width: 43,
                                        height: 43,
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 0.5),
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
                                        link: festival.websiteurl ??
                                            "https://ltfest.ru"),
                                    const SizedBox(width: 8),
                                    FavoriteButtonDetails(
                                        id: festival.id,
                                        eventType: EventType.festival),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 290),
                              Container(
                                width: double.infinity,
                                decoration: Decor.base,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        festival.title,
                                        style: Styles.h3,
                                      ),
                                      const SizedBox(height: 12),
                                      GestureDetector(
                                        onTap: () =>
                                            _showPriceInfo(context, festival),
                                        child: Row(
                                          children: [
                                            Text(
                                              "от ${festival.price} ₽/чел",
                                              style: Styles.h4.copyWith(
                                                  color: Palette.gray),
                                            ),
                                            const SizedBox(width: 8),
                                            SvgPicture.asset(
                                                'assets/icons/info.svg'),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/calendar.svg'),
                                          const SizedBox(width: 12),
                                          Text(
                                            "${DateFormat("dd.MM.yyyy", "ru").format(festival.dateStart!)} - ${DateFormat("dd.MM.yyyy", "ru").format(festival.dateEnd!)} ",
                                            style: Styles.b2
                                                .copyWith(color: Palette.gray),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/map_point.svg'),
                                          const SizedBox(width: 12),
                                          Text(
                                            festival.address ?? 'Не указано',
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Описание",
                                        style: Styles.h4,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        festival.description ??
                                            'Описание отсутствует',
                                        style: Styles.b2,
                                      ),
                                      const SizedBox(height: 16),
                                      InkWell(
                                        onTap: () async {
                                          final Uri uri = Uri.parse(
                                            festival.pdfurl!,
                                          );
                                          await launchUrl(
                                            uri,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        },
                                        child: Container(
                                          height: 43,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Palette.stroke,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text("Подробнее в положении",
                                                style: Styles.button1.copyWith(
                                                    color: Palette.black)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        "Жюри",
                                        style: Styles.h4,
                                      ),
                                      const SizedBox(height: 16),
                                      if (festival.persons!.isEmpty)
                                        Text(
                                          "Информация о жюри отсутствует",
                                          style: TextStyle(color: Palette.gray),
                                        )
                                      else
                                        Row(
                                          children: [
                                            ...festival.persons!
                                                .expand(
                                                  (person) => [
                                                    SizedBox(
                                                      width: person.lastname
                                                              .toLowerCase()
                                                              .startsWith(
                                                                  "утверждается")
                                                          ? 170 * 2
                                                          : 170,
                                                      child: InkWell(
                                                        onTap: () =>
                                                            _showJuryInfo(
                                                                context,
                                                                person),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                child: person
                                                                            .image !=
                                                                        null
                                                                    ? Image
                                                                        .network(
                                                                        'http://37.46.132.144:1337${person.image?.formats?.medium?.url ?? person.image?.url ?? ''}',
                                                                        height:
                                                                            150,
                                                                        width: double
                                                                            .infinity,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        errorBuilder: (context,
                                                                                error,
                                                                                stackTrace) =>
                                                                            Image.asset(
                                                                          'assets/images/jury_placeholder.png',
                                                                          height:
                                                                              150,
                                                                          width:
                                                                              double.infinity,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        'assets/images/jury_placeholder.png',
                                                                        height:
                                                                            150,
                                                                        width: double
                                                                            .infinity,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 12),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${person.firstname}\n${person.lastname}',
                                                                    style:
                                                                        Styles
                                                                            .h4,
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          4),
                                                                  Text(
                                                                    'Подробнее',
                                                                    style: Styles
                                                                        .b3
                                                                        .copyWith(
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
                                                    const SizedBox(width: 12),
                                                  ],
                                                )
                                                .toList()
                                              ..removeLast(),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 48 + MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
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
                left: 16,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: LTButtons.elevatedButton(
                  onPressed: () async {
                    final Uri uri = Uri.parse(festivalAsync.value!.entryurl!);
                    await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Text(
                    "Заявка на участие",
                    style: Styles.button1.copyWith(color: Palette.white),
                  ),
                ),
              ),
            ),
          ),
          festivalAsync.when(
            data: (festival) => AnimatedOpacity(
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
                            link: festival.websiteurl ?? "https://ltfest.ru"),
                        const SizedBox(width: 8),
                        FavoriteButtonDetails(
                          id: festival.id,
                          eventType: EventType.festival,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      festival.title,
                      style: Styles.h3.copyWith(color: Palette.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _showPriceInfo(context, festival),
                      child: Row(
                        children: [
                          Text(
                            "от ${festival.price} ₽/чел",
                            style: Styles.h4.copyWith(color: Palette.white),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset('assets/icons/info.svg',
                              color: Palette.stroke),
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
}
