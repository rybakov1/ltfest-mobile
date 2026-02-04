import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/components/favorite_button.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/providers/favorites_provider.dart';

import '../../components/custom_chip.dart';
import '../../data/models/favorite.dart';
import '../../data/services/api_endpoints.dart';
import '../../router/app_routes.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  int _selectedTabIndex = 0;

  void _onTabTapped(int index) => setState(() => _selectedTabIndex = index);

  @override
  Widget build(BuildContext context) {
    final favState = ref.watch(favoritesProvider);
    const tabs = ["Афиша", "Лаборатории", "Магазин"];

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: LTAppBar(title: "Избранное")),
            SliverFillRemaining(
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: Decor.base,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 16,
                        left: 4,
                        right: 4,
                      ),
                      child: _CustomSegmentedControl(
                        tabs: tabs,
                        selectedIndex: _selectedTabIndex,
                        onTap: _onTabTapped,
                      ),
                    ),
                    Expanded(
                      child: favState.when(
                        data: (favorites) {
                          final favoriteFestivals = favorites
                              .where((f) => f.type == 'festival')
                              .toList();
                          final favoriteLabs = favorites
                              .where((f) => f.type == 'laboratory')
                              .toList();
                          final favoriteProducts = favorites
                              .where((f) => f.type == 'product')
                              .toList();

                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: _buildContentForTab(
                              _selectedTabIndex,
                              festivals: favoriteFestivals,
                              laboratories: favoriteLabs,
                              products: favoriteProducts,
                            ),
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, st) => Center(
                          child: Text("Ошибка загрузки избранного: $e",
                              style: Styles.b2.copyWith(color: Palette.white)),
                        ),
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

  Widget _buildContentForTab(
    int index, {
    required List<Favorite> festivals,
    required List<Favorite> laboratories,
    required List<Favorite> products,
  }) {
    switch (index) {
      case 0:
        return _buildFavoritesList(festivals, key: const ValueKey('festivals'));
      case 1:
        return _buildFavoritesList(laboratories, key: const ValueKey('labs'));
      case 2:
        return _buildFavoritesListProducts(products,
            key: const ValueKey('products'));
      default:
        return const SizedBox.shrink(key: ValueKey('empty'));
    }
  }

  Widget _buildFavoritesList(List<Favorite> items, {Key? key}) {
    if (items.isEmpty) return _emptyState(key: key);

    return ListView.builder(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: _FavoriteCard(item: items[index]),
        );
      },
    );
  }

  Widget _buildFavoritesListProducts(List<Favorite> items, {Key? key}) {
    if (items.isEmpty) return _emptyState(key: key);

    return GridView.builder(
      key: key,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
        mainAxisExtent: 295,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: _FavoriteCard(item: items[index]),
        );
      },
    );
  }

  Widget _emptyState({Key? key}) {
    return Center(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/states/nothing.png", width: 192),
          const SizedBox(height: 12),
          Text("Здесь пока ничего нет", style: Styles.b2.copyWith(color: Palette.gray)),
        ],
      ),
    );
  }
}

EventType _stringToEventType(String type) {
  switch (type) {
    case 'festival':
      return EventType.festival;
    case 'laboratory':
      return EventType.laboratory;
    case 'product':
      return EventType.product;
    default:
      throw Exception('Unknown event type: $type');
  }
}

class _FavoriteCard extends StatelessWidget {
  final Favorite item;

  const _FavoriteCard({required this.item});

  String _formatDateRange(String? start, String? end) {
    if (start == null || end == null) return '';
    try {
      final startDate = DateFormat('yyyy-MM-dd').parse(start);
      final endDate = DateFormat('yyyy-MM-dd').parse(end);
      final format = DateFormat('dd.MM.yyyy', 'ru');
      return '${format.format(startDate)} - ${format.format(endDate)}';
    } catch (e) {
      return '$start - $end';
    }
  }

  @override
  Widget build(BuildContext context) {
    void onTap() {
      switch (item.type) {
        case 'festival':
          context.push(
              '${AppRoutes.festivals}/${item.direction!.title}/${item.id}');
          break;
        case 'laboratory':
          context.push('${AppRoutes.laboratories}/${item.id}');
          break;
        case 'product':
          context.push('${AppRoutes.shop}/${item.id}');
          break;
      }
    }

    return switch (item.type) {
      'product' => _buildProductCard(item, onTap),
      _ => _buildEventCard(item, onTap),
    };
  }

  Widget _buildEventCard(Favorite fav, onTap) {
    final dateText = _formatDateRange(fav.date_start, fav.date_end);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  '${ApiEndpoints.baseStrapiUrl}${item.image ?? ''}',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (item.direction != null)
                      CustomChipWithName(
                        selectedDirection: item.direction!.title,
                      ),
                    const Spacer(),
                    FavoriteButton(
                        id: item.id,
                        type: _stringToEventType(item.type),
                        color: const Color(0x63656B33)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(fav.title, style: Styles.h4),
          const SizedBox(height: 8),
          Text(fav.address ?? 'Адрес не указан',
              style: Styles.b2.copyWith(color: Palette.gray)),
          if (dateText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(dateText,
                  style: Styles.b2.copyWith(color: Palette.gray)),
            ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Favorite fav, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  '${ApiEndpoints.baseStrapiUrl}${item.image ?? ''}',
                  width: double.infinity,
                  height: 196,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FavoriteButton(
                    id: item.id,
                    type: _stringToEventType(item.type),
                    color: const Color(0x63656B33),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            Utils.formatMoney(
              fav.price!.toInt(),
            ),
            style: Styles.h5,
          ),
          const SizedBox(height: 4),
          Text(
            fav.title,
            style: Styles.b2.copyWith(
              color: Palette.gray,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "арт. ${fav.article!}",
            overflow: TextOverflow.ellipsis,
            style: Styles.b3,
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
