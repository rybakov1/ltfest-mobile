import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/components/favorite_button.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/components/share_button.dart';
import 'package:ltfest/data/models/person.dart';
import 'package:ltfest/pages/shop/presenter/shop_widget.dart';
import 'package:ltfest/providers/favorites_provider.dart';
import 'package:ltfest/providers/festival_provider.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/providers/festival_tariff_provider.dart';
import 'package:ltfest/providers/user_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/festival.dart';
import '../../data/models/festival_order_args_model.dart';
import '../../router/app_routes.dart';

class FestivalDetailPage extends ConsumerStatefulWidget {
  final String id;
  final String category;

  const FestivalDetailPage(
      {super.key, required this.id, required this.category});

  @override
  ConsumerState<FestivalDetailPage> createState() => _FestivalDetailPageState();
}

class _FestivalDetailPageState extends ConsumerState<FestivalDetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showHeader = false;

  int _selectedTabIndex = 0;

  void _onTabTapped(int index) => setState(() => _selectedTabIndex = index);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 320 && !_showHeader) {
        setState(() => _showHeader = true);
      } else if (_scrollController.offset <= 320 && _showHeader) {
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
                        await launchUrl(Uri.parse(festival.pdfurl!));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: widget.category == "Театр"
                              ? Palette.primaryLime
                              : Palette.primaryPink,
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

  Widget _buildPageLoading(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Palette.shimmerBase,
      highlightColor: Palette.shimmerHighlight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                height: 124,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final festivalAsync = ref.watch(festivalByIdProvider(widget.id));
    const tabs = ["Основное", "Тарифы"];

    return Scaffold(
      backgroundColor: Palette.background,
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
                        child: CachedNetworkImage(
                          imageUrl:
                              'http://37.46.132.144:1337${festival.image?.formats?.medium?.url ?? festival.image?.url ?? ''}',
                          height: 340,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Palette.shimmerBase,
                            highlightColor: Palette.shimmerHighlight,
                            child: Container(
                              height: 340,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                          fadeOutDuration: const Duration(milliseconds: 100),
                        ),
                      ),
                      SafeArea(
                        child: Column(
                          children: [
                            LTAppBar(
                              suffixIconColor:
                                  Palette.white.withValues(alpha: 0.5),
                              postfixWidget: Row(
                                children: [
                                  ShareButton(
                                    link: festival.websiteurl ??
                                        "https://ltfest.ru",
                                    color: Palette.white.withValues(alpha: 0.5),
                                  ),
                                  const SizedBox(width: 8),
                                  FavoriteButton(
                                    id: festival.id,
                                    size: 40,
                                    type: EventType.festival,
                                    color: Palette.white.withValues(alpha: 0.5),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                    254 - MediaQuery.of(context).padding.top),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                children: [
                                  festivalMainInfo(festival),
                                  const SizedBox(height: 2),
                                  Container(
                                    width: double.infinity,
                                    decoration: Decor.base,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _CustomSegmentedControl(
                                            tabs: tabs,
                                            selectedIndex: _selectedTabIndex,
                                            onTap: _onTabTapped,
                                          ),
                                          const SizedBox(height: 24),
                                          _buildContentForTab(
                                            _selectedTabIndex,
                                            festival,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            loading: () => _buildPageLoading(context),
            error: (error, stack) => _buildPageLoading(context),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: festivalAsync.when(
              data: (festival) => AnimatedOpacity(
                opacity: _showHeader ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Palette.background,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LTAppBar(
                        postfixWidget: Row(
                          children: [
                            ShareButton(
                              link: festival.websiteurl ?? "https://ltfest.ru",
                              color: Palette.primaryLime,
                            ),
                            const SizedBox(width: 8),
                            FavoriteButton(
                              id: festival.id,
                              size: 40,
                              type: EventType.festival,
                              color: Palette.primaryLime,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          festival.title,
                          style: Styles.h3.copyWith(color: Palette.black),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          festival.title2 ?? "",
                          style: Styles.b2.copyWith(color: Palette.gray),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (error, stack) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentForTab(int index, festivals) {
    switch (index) {
      case 0:
        return festivalMoreInfo(festivals);
      case 1:
        return festivalTariffInfo(festivals);
      default:
        return const SizedBox.shrink(key: ValueKey('empty'));
    }
  }

  Widget festivalMainInfo(festival) {
    return Container(
      width: double.infinity,
      decoration: Decor.base,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              festival.title,
              style: Styles.h3,
            ),
            const SizedBox(height: 8),
            if (festival.title2 != null)
              Text(
                festival.title2,
                style: Styles.b2.copyWith(color: Palette.gray),
              ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _showPriceInfo(context, festival),
              child: Text(
                "от ${Utils.formatMoney(festival.price)}/чел",
                style: Styles.h4.copyWith(color: Palette.gray),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                SvgPicture.asset('assets/icons/map_point.svg'),
                const SizedBox(width: 12),
                Text(
                  festival.address ?? 'Не указано',
                  style: Styles.b2,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                SvgPicture.asset('assets/icons/calendar.svg'),
                const SizedBox(width: 12),
                Text(
                  "${DateFormat("dd.MM.yyyy", "ru").format(festival.dateStart!)} - ${DateFormat("dd.MM.yyyy", "ru").format(festival.dateEnd!)}",
                  style: Styles.b2.copyWith(color: Palette.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget festivalMoreInfo(festival) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Описание",
          style: Styles.h4,
        ),
        const SizedBox(height: 16),
        Text(
          festival.description ?? 'Описание отсутствует',
          style: Styles.b2,
        ),
        const SizedBox(height: 16),
        LTButtons.outlinedButton(
          onPressed: () async {
            await launchUrl(Uri.parse(festival.pdfurl!));
          },
          child: Text(
            "Подробнее в положении",
            style: Styles.button1,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Жюри",
          style: Styles.h3,
        ),
        const SizedBox(height: 16),
        if (festival.persons!.isEmpty)
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/jury_placeholder.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Text(
                    "Состав жюри еще утверждается",
                    style: Styles.h3.copyWith(color: Palette.gray),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Совсем скоро здесь появится информация о членах жюри",
                    textAlign: TextAlign.center,
                    style: Styles.b2.copyWith(color: Palette.gray),
                  ),
                ],
              ),
            ],
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...festival.persons!
                    .expand(
                      (person) => [
                        SizedBox(
                          width: 170,
                          child: InkWell(
                            onTap: () => _showJuryInfo(context, person),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'http://37.46.132.144:1337${person.image?.formats?.medium?.url ?? person.image?.url ?? ''}',
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Palette.shimmerBase,
                                        highlightColor:
                                            Palette.shimmerHighlight,
                                        child: Container(
                                          height: 150,
                                          width: double.infinity,
                                          color: Colors.white,
                                        ),
                                      ),
                                      fadeOutDuration:
                                          const Duration(milliseconds: 100),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${person.firstname} ${person.lastname}',
                                        style: Styles.h4,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Подробнее',
                                        style: Styles.b3
                                            .copyWith(color: Palette.secondary),
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
          ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("LT Shop", style: Styles.h3),
            GestureDetector(
              onTap: () => context.push(AppRoutes.shop),
              child: Text(
                "Все",
                style: Styles.b2.copyWith(color: Palette.secondary),
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        const ShopWidget(),
      ],
    );
  }

  Widget festivalTariffInfo(Festival festival) {
    final user = ref.watch(userProvider);
    // 1. Вызываем новый provider с ID текущего фестиваля
    final tariffsAsync = ref.watch(tariffsForFestivalProvider(festival.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Важно", style: Styles.h3),
        const SizedBox(height: 16),
        Text(
          "Перед оплатой фестиваля необходимо чтобы руководитель заполнил заявку на участие...",
          style: Styles.b1,
        ),
        if (user!.activity!.title == "Руководитель коллектива") ...[
          const SizedBox(height: 16),
          LTButtons.elevatedButton(
            onPressed: () async {
              final Uri uri = Uri.parse(
                festival.entryurl!,
              );
              await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              );
            },
            child: Text("Заполнить заявку", style: Styles.button1),
            backgroundColor: widget.category == "Театр"
                ? Palette.primaryLime
                : Palette.primaryPink,
          ),
        ],
        const SizedBox(height: 24),
        Text("Тарифы", style: Styles.h3),
        const SizedBox(height: 16),
        tariffsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) =>
              Center(child: Text('Не удалось загрузить тарифы: $err')),
          data: (tariffs) {
            if (tariffs.isEmpty) {
              return const Center(
                  child: Text('Для этого фестиваля пока нет тарифов.'));
            }

            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tariffs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final tariff = tariffs[index];

                return LTTariff(
                  title: tariff.title,
                  price: tariff.price.toInt(),
                  description: tariff.description,
                  priceDescription: tariff.price_description,
                  factPrice: tariff.fact_price?.toInt(),
                  category: widget.category,
                  bonuses:
                      tariff.feature.map((feature) => feature.title).toList(),
                  onBuyPressed: () {
                    context.push(
                      AppRoutes.festivalOrder,
                      extra: FestivalOrderArgs(
                        festival: festival,
                        tariff: tariff,
                      ),
                    );
                  },
                  onSecondaryBuyPressed: () async {
                    final Uri uri = Uri.parse("https://t.me/LTPay_Later_bot");
                    await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class LTTariff extends StatefulWidget {
  final String title;
  final int? factPrice;
  final String? priceDescription;
  final int price;
  final String? description;
  final String category;
  final VoidCallback onBuyPressed;
  final VoidCallback onSecondaryBuyPressed;
  final List<String> bonuses;

  final List<Widget> children;
  final bool initiallyExpanded;
  final Duration animationDuration;
  final Curve animationCurve;

  const LTTariff({
    super.key,
    required this.title,
    required this.price,
    this.factPrice,
    this.description,
    required this.category,
    required this.onBuyPressed,
    required this.onSecondaryBuyPressed,
    this.children = const [],
    this.bonuses = const [],
    this.initiallyExpanded = false,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.priceDescription,
  });

  @override
  State<LTTariff> createState() => _LTTariffState();
}

class _LTTariffState extends State<LTTariff>
    with SingleTickerProviderStateMixin {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Palette.background, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: Styles.h4),
                  const SizedBox(height: 12),
                  Text("${Utils.formatMoney(widget.price)}/чел",
                      style: Styles.h2),
                  if (widget.description != null) ...[
                    const SizedBox(height: 8),
                    Text(widget.description!, style: Styles.b2),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text("Подробнее",
                          style: Styles.b3.copyWith(
                              color: Palette.secondary, fontSize: 14)),
                      AnimatedRotation(
                        turns: _expanded ? 0.5 : 0.0,
                        duration: widget.animationDuration,
                        child: Icon(
                          Icons.expand_more,
                          color: Palette.secondary,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.bonuses.isNotEmpty)
                  for (int i = 0; i < widget.bonuses.length; i++) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle,
                            color: widget.category == "Театр"
                                ? Palette.primaryLime
                                : Palette.primaryPink),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(widget.bonuses[i], style: Styles.b2),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                const SizedBox(height: 24),
                Text(widget.priceDescription ?? "Предоплата 50%",
                    style: Styles.b2.copyWith(color: Palette.gray)),
                const SizedBox(height: 8),
                Text(
                    "${Utils.formatMoney(widget.factPrice ?? (widget.price / 2).toInt())}/чел",
                    style: Styles.h2),
                const SizedBox(height: 16),
                LTButtons.elevatedButton(
                    onPressed: widget.onBuyPressed,
                    child: Text("Купить", style: Styles.button1),
                    backgroundColor: widget.category == "Театр"
                        ? Palette.primaryLime
                        : Palette.primaryPink),
                const SizedBox(height: 8),
                LTButtons.elevatedButton(
                    onPressed: widget.onSecondaryBuyPressed,
                    child: Text("LT Pay: рассрочка от 3 мес.",
                        style: Styles.button1.copyWith(color: Palette.black)),
                    backgroundColor: Palette.secondaryGray)
              ],
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: widget.animationDuration,
            sizeCurve: widget.animationCurve,
          ),
        ],
      ),
    );
  }
}

class _CustomSegmentedControl extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _CustomSegmentedControl({
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Palette.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final title = entry.value;
          final isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected ? Palette.primaryLime : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    title,
                    style: isSelected
                        ? Styles.h5.copyWith(color: Palette.white)
                        : Styles.b2.copyWith(color: Palette.gray),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
