import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/components/async_items_list_view.dart';
import 'package:ltfest/components/favorite_button.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/services/api_endpoints.dart';
import 'package:ltfest/providers/festival_provider.dart';
import 'package:ltfest/router/app_routes.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/lt_appbar.dart';
import '../../providers/favorites_provider.dart';

class FestivalPage extends ConsumerStatefulWidget {
  final String category;

  const FestivalPage({
    super.key,
    required this.category,
  });

  @override
  ConsumerState<FestivalPage> createState() => _FestivalPageState();
}

class _FestivalPageState extends ConsumerState<FestivalPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  late final AnimationController _storiesAnimationController;
  // late final Animation<double> _storiesAnimation;

  Map<String, Color> categoryColors = {
    'Театр': Palette.primaryLime,
    'Танцы': Palette.primaryPink,
  };

  @override
  void initState() {
    super.initState();
    final initialQuery = ref
            .read(festivalsNotifierProvider(widget.category))
            .valueOrNull
            ?.searchQuery ??
        '';
    _searchController = TextEditingController(text: initialQuery);

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _storiesAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // _storiesAnimation = CurvedAnimation(
    //   parent: _storiesAnimationController,
    //   curve: Curves.easeOut,
    // );

    _storiesAnimationController.value = 1.0;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _storiesAnimationController.dispose();

    super.dispose();
  }

  /// Here scroll distance to show up a stories
  void _scrollListener() {
    const double storiesAnimationDistance = 150.0;
    final progress =
        (_scrollController.offset / storiesAnimationDistance).clamp(0.0, 1.0);
    _storiesAnimationController.value = 1.0 - progress;
  }

  void _showCityBottomSheet(FestivalsState state) {
    final uniqueCities = state.uniqueCities;
    List<String> selected = List<String>.from(state.selectedCities);

    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (modalContext) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            top: 16,
            bottom: 24 + MediaQuery.of(context).viewPadding.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 41,
                height: 4,
                decoration: BoxDecoration(
                  color: Palette.stroke,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Город',
                textAlign: TextAlign.center,
                style: Styles.h4,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: uniqueCities.isEmpty
                    ? const Center(child: Text("Нет городов для выбора"))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: uniqueCities.length,
                        itemBuilder: (context, index) {
                          final city = uniqueCities.elementAt(index);
                          final isSelected = selected.contains(city);
                          return Column(
                            children: [
                              _buildCheckboxListTile(
                                title: city,
                                value: isSelected,
                                onChanged: (value) {
                                  setModalState(() {
                                    if (value!) {
                                      selected.add(city);
                                    } else {
                                      selected.remove(city);
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 0),
                            ],
                          );
                        },
                      ),
              ),
              // Footer
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Container(
                        child: LTButtons.outlinedButton(
                          onPressed: () {
                            Navigator.pop(modalContext);
                            ref
                                .read(festivalsNotifierProvider(widget.category)
                                    .notifier)
                                .setSelectedCities([]);
                          },
                          child: Text('Сбросить', style: Styles.button1),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: LTButtons.elevatedButton(
                        onPressed: () {
                          Navigator.pop(modalContext);
                          ref
                              .read(festivalsNotifierProvider(widget.category)
                                  .notifier)
                              .setSelectedCities(selected);
                        },
                        child: Text('Применить', style: Styles.button1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxListTile({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Theme(
        data: Theme.of(context).copyWith(
          checkboxTheme: CheckboxThemeData(
              side: BorderSide(color: Palette.stroke, width: 1.5)),
        ),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: Palette.secondary,
              checkColor: Palette.white,
            ),
            const SizedBox(width: 0),
            Expanded(
              child: Text(title, style: Styles.b1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEventCard() {
    return Shimmer.fromColors(
      baseColor: Palette.shimmerBase,
      highlightColor: Palette.shimmerHighlight,
      child: Padding(
        // Отступ, как у оригинальной карточки
        padding: const EdgeInsets.only(bottom: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Плейсхолдер для картинки
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 8),
            // Плейсхолдер для заголовка
            Container(
              height: 24,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            // Плейсхолдер для адреса и даты
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 16,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  height: 16,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.category;

    final festivalsAsync =
        ref.watch(festivalsNotifierProvider(widget.category));
    final festivalState = festivalsAsync.valueOrNull ?? const FestivalsState();

    ref.listen(
      festivalsNotifierProvider(widget.category),
      (_, next) {
        final newState = next.valueOrNull;
        if (newState != null && newState.filteredFestivals.length <= 2) {
          _storiesAnimationController.animateTo(
            1.0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        }

        final newQuery = next.valueOrNull?.searchQuery ?? '';
        if (newQuery != _searchController.text) {
          _searchController.text = newQuery;
        }
      },
    );

    return Scaffold(
      backgroundColor: Palette.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: LTAppBar(title: "Фестивали")),
            SliverFillRemaining(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // FadeTransition(
                    //   opacity: _storiesAnimation,
                    //   child: SizeTransition(
                    //     axisAlignment: -1.0,
                    //     sizeFactor: _storiesAnimation,
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(bottom: 24.0),
                    //       child: StoryWidget(category: widget.category),
                    //     ),
                    //   ),
                    // ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _showCityBottomSheet(festivalState),
                          child: Container(
                            height: 43,
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              color: festivalState.selectedCities.isEmpty
                                  ? Palette.white
                                  : Palette.primaryLime,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: festivalState.selectedCities.isEmpty
                                    ? Palette.stroke
                                    : Palette.primaryLime,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Город",
                                  style: Styles.b2.copyWith(
                                    color: festivalState.selectedCities.isEmpty
                                        ? Palette.gray
                                        : Palette.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // TODO: ? This is maybe not right realisation
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: IconButton(
                                    padding: const EdgeInsets.all(4),
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      if (festivalState
                                          .selectedCities.isNotEmpty) {
                                        setState(() {
                                          festivalState.selectedCities.clear();
                                        });
                                      } else {
                                        _showCityBottomSheet(festivalState);
                                      }
                                    },
                                    icon: Icon(
                                      festivalState.selectedCities.isEmpty
                                          ? Icons.keyboard_arrow_down_outlined
                                          : Icons.close,
                                      color:
                                          festivalState.selectedCities.isEmpty
                                              ? const Color(0xFF1C274C)
                                              : Palette.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            style: Styles.b2,
                            controller: _searchController,
                            onChanged: (query) {
                              ref
                                  .read(
                                      festivalsNotifierProvider(widget.category)
                                          .notifier)
                                  .setSearchQuery(query);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Palette.white,
                              suffixIcon: SvgPicture.asset(
                                "assets/icons/search.svg",
                                fit: BoxFit.scaleDown,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Palette.stroke,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Palette.stroke,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Palette.primaryLime,
                                  width: 1,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Palette.error,
                                  width: 1,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Palette.error,
                                  width: 1,
                                ),
                              ),
                              hintText: "Поиск",
                              hintStyle:
                                  Styles.b2.copyWith(color: Palette.gray),
                              constraints: const BoxConstraints(maxHeight: 43),
                              contentPadding: const EdgeInsets.only(
                                left: 16,
                                top: 13,
                                bottom: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: festivalsAsync.when(
                        loading: () => ListView.builder(
                          itemCount: 5,
                          // Показываем 5 заглушек, чтобы заполнить экран
                          itemBuilder: (context, index) =>
                              _buildShimmerEventCard(),
                        ),
                        error: (error, stackTrace) => Center(
                          child: Text('Произошла ошибка: $error'),
                        ),
                        data: (state) {
                          return AsyncItemsListView(
                            scrollController: _scrollController,
                            asyncValue: festivalsAsync,
                            items: festivalState.filteredFestivals,
                            onRefresh: () => ref.refresh(
                                festivalsNotifierProvider(widget.category)
                                    .future),
                            itemBuilder: (context, index) {
                              final festival =
                                  festivalState.filteredFestivals[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: index <
                                          festivalState
                                                  .filteredFestivals.length -
                                              1
                                      ? 32.0
                                      : 8,
                                ),
                                child: _buildEventCard(
                                  festival: festival,
                                  context: context,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard({
    required BuildContext context,
    required Festival festival,
  }) {
    // Формируем URL заранее для чистоты кода
    final String imageUrl =
        '${ApiEndpoints.baseStrapiUrl}${festival.image?.formats?.medium?.url ?? festival.image?.url ?? ''}';

    return GestureDetector(
      onTap: () {
        context
            .push('${AppRoutes.festivals}/${widget.category}/${festival.id}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 180,
                  fadeInDuration: const Duration(milliseconds: 150),
                  fadeOutDuration: const Duration(milliseconds: 150),
                  fadeInCurve: Curves.easeIn,
                  fadeOutCurve: Curves.easeOut,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Palette.shimmerBase,
                    highlightColor: Palette.shimmerHighlight,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported,
                        color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FavoriteButton(
                      id: festival.id,
                      type: EventType.festival,
                      color: Palette.white.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(festival.title, style: Styles.h4),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(festival.address ?? 'Не указано',
                  style: Styles.b2.copyWith(color: Palette.gray)),
              if (festival.dateStart != null && festival.dateEnd != null)
                Text(
                  "${DateFormat("dd.MM.yyyy", "ru").format(festival.dateStart!)} - ${DateFormat("dd.MM.yyyy", "ru").format(festival.dateEnd!)}",
                  style: Styles.b2.copyWith(color: Palette.black),
                ),
            ],
          )
        ],
      ),
    );
  }
}
