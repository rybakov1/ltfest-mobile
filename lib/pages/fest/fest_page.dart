import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/components/async_items_list_view.dart';
import 'package:ltfest/components/custom_chip.dart';
import 'package:ltfest/components/favorite_button.dart';
import 'package:ltfest/components/story_widget.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/providers/festival_provider.dart';
import 'package:ltfest/router/app_routes.dart';

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
  late final Animation<double> _storiesAnimation;

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
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // CurvedAnimation делает движение более естественным (нелинейным)
    _storiesAnimation = CurvedAnimation(
      parent: _storiesAnimationController,
      curve: Curves.easeInOut,
    );

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

  void _scrollListener() {
    final progress = (_scrollController.offset / 100.0).clamp(0.0, 1.0);
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
            duration: const Duration(milliseconds: 150),
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
            SliverToBoxAdapter(child: LTAppBar(title: title)),
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
                    FadeTransition(
                      opacity: _storiesAnimation,
                      child: SizeTransition(
                        axisAlignment: -1.0,
                        sizeFactor: _storiesAnimation,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: StoryWidget(category: widget.category),
                        ),
                      ),
                    ),
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
                                color: festivalState.selectedCities.isEmpty ? Palette.stroke : Palette.primaryLime,
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
                              hintStyle: Styles.b2.copyWith(color: Palette.gray),
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
                      child: AsyncItemsListView(
                        scrollController: _scrollController,
                        asyncValue: festivalsAsync,
                        items: festivalState.filteredFestivals,
                        onRefresh: () => ref.refresh(
                            festivalsNotifierProvider(widget.category).future),
                        itemBuilder: (context, index) {
                          final festival =
                              festivalState.filteredFestivals[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index <
                                      festivalState.filteredFestivals.length - 1
                                  ? 32.0
                                  : 8,
                            ),
                            child: _buildEventCard(
                              festival: festival,
                              context: context,
                            ),
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
                child: Image.network(
                  'http://37.46.132.144:1337${festival.image?.formats?.medium?.url ?? festival.image?.url ?? ''}',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomChipWithName(
                      selectedDirection: festival.direction.title,
                    ),
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
