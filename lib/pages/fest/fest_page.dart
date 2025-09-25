import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    // Запускаем анимацию в начальное состояние (полностью видимое)
    _storiesAnimationController.forward();
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
    if (_scrollController.offset > 50 &&
        _storiesAnimationController.isCompleted) {
      _storiesAnimationController
          .reverse();
    }
    else if (_scrollController.offset <= 50 &&
        _storiesAnimationController.isDismissed) {
      _storiesAnimationController
          .forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.category;

    final festivalsAsync =
        ref.watch(festivalsNotifierProvider(widget.category));
    final festivalState = festivalsAsync.valueOrNull ?? FestivalsState();

    ref.listen(festivalsNotifierProvider(widget.category), (_, next) {
      final newQuery = next.valueOrNull?.searchQuery ?? '';
      if (newQuery != _searchController.text) {
        _searchController.text = newQuery;
      }
    });
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: Styles.h4.copyWith(color: Palette.black),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 43,
                        width: 43,
                        decoration:
                            Decor.base.copyWith(color: Palette.primaryLime),
                        child: IconButton(
                          onPressed: () => context.pop(),
                          icon: Icon(Icons.arrow_back, color: Palette.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 24.0),
                          child: StoryWidget(),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        // SizedBox(
                        //   width: 100,
                        //   child: Padding(
                        //     padding : const EdgeInsets.only(
                        //         right: 12, left: 12, top: 20, bottom: 6),
                        //     child: CustomChip(
                        //       onDirectionSelected: (direction) {
                        //         ref.read(selectedDirectionProvider.notifier).state =
                        //             direction;
                        //       },
                        //     ),
                        //   ),
                        // ),
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
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Palette.stroke, width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Palette.stroke, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Palette.primaryLime, width: 1)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Palette.error, width: 1)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Palette.error, width: 1)),
                              hintText: "Поиск",
                              hintStyle: Styles.b2,
                              contentPadding: const EdgeInsets.only(
                                  left: 16, top: 13, bottom: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      // Используем наш новый чистый виджет для отображения списка
                      child: AsyncItemsListView(
                        scrollController: _scrollController,
                        asyncValue: festivalsAsync,
                        items: festivalState.filteredFestivals,
                        // Передаем отфильтрованный список
                        onRefresh: () => ref.refresh(
                            festivalsNotifierProvider(widget.category).future),
                        itemBuilder: (context, index) {
                          final festival =
                              festivalState.filteredFestivals[index];
                          // Разметка карточки остается здесь, как вы и просили
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
        context.push('${AppRoutes.festivals}/${widget.category}/${festival.id}');
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
                  height: 150,
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
                        id: festival.id, eventType: EventType.festival),
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
                "${DateFormat("dd", "ru").format(festival.dateStart!)} - ${DateFormat("dd", "ru").format(festival.dateEnd!)} ${DateFormat("MMMM yyyy", "ru").format(festival.dateStart!)}",
                style: Styles.b2.copyWith(color: Palette.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
