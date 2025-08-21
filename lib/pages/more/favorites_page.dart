import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/models/laboratory.dart';
import 'package:ltfest/providers/favorites_provider.dart';

import '../../components/async_items_list_view.dart';
import '../../components/custom_chip.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteFestivals = ref.watch(favoritesFestivalsProvider).whenData(
          (festivals) {
        final favoriteKeys = ref.watch(favoriteProvider);
        return festivals
            .where((f) => favoriteKeys.contains('festival-${f.id}'))
            .toList();
      },
    );

    final favoriteLabs = ref.watch(favoritesLabsProvider).whenData(
          (labs) {
        final favoriteKeys = ref.watch(favoriteProvider);
        return labs
            .where((l) => favoriteKeys.contains('laboratory-${l.id}'))
            .toList();
      },
    );

    return Scaffold(
      backgroundColor: Palette.black,
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 24 + MediaQuery.of(context).padding.top,
                  bottom: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Избранное",
                      style: Styles.h3.copyWith(color: Palette.white),
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
              margin: const EdgeInsets.all(4),
              decoration: Decor.base,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 16, left: 12, right: 12),
                    child: _CustomSegmentedControl(
                      selectedIndex: _selectedIndex,
                      onTap: _onTabTapped,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _selectedIndex == 0
                            ? _buildFestivalsList(favoriteFestivals)
                            : _buildLabsList(favoriteLabs),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFestivalsList(AsyncValue<List<Festival>> asyncFestivals) {
    return AsyncItemsListView(
      asyncValue: asyncFestivals,
      items: asyncFestivals.value!,
      onRefresh: () => ref.refresh(favoritesFestivalsProvider),
      itemBuilder: (context, index) {
        final festival = asyncFestivals.value![index];
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < asyncFestivals.value!.length - 1 ? 32.0 : 40,
          ),
          child: _buildEventCard(
            festival: festival,
            context: context,
          ),
        );
      },
    );
  }

  Widget _buildEventCard({
    required BuildContext context,
    required Festival festival,
  }) {
    return GestureDetector(
      onTap: () {
        context.push('/fest/${festival.id}');
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
                child: CustomChipWithName(
                  selectedDirection: festival.direction.title,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(festival.title, style: Styles.h4),
          const SizedBox(height: 8),
          Text(festival.address ?? 'Не указано',
              style: Styles.b2.copyWith(color: Palette.gray)),
          Text(
            "${DateFormat("dd.MM.yyyy", "ru").format(festival.dateStart!)} - ${DateFormat("dd.MM.yyyy", "ru").format(festival.dateEnd!)}",
            style: Styles.b2.copyWith(color: Palette.gray),
          ),
        ],
      ),
    );
  }

  Widget _buildLabsList(AsyncValue<List<Laboratory>> asyncLabs) {
    return AsyncItemsListView(
      asyncValue: asyncLabs,
      items: asyncLabs.value!,
      onRefresh: () => ref.refresh(favoritesLabsProvider),
      itemBuilder: (context, index) {
        final lab = asyncLabs.value![index];
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < asyncLabs.value!.length - 1 ? 32.0 : 40,
          ),
          child: _buildLabEventCard(
            laboratory: lab,
            context: context,
          ),
        );
      },
    );
  }

  Widget _buildLabEventCard({
    required Laboratory laboratory,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        context.push('/lab/${laboratory.id}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'http://37.46.132.144:1337${laboratory.image?.formats?.medium?.url ?? laboratory.image?.url ?? ''}',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomChipWithName(
                  selectedDirection: laboratory.direction.title,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(laboratory.title, style: Styles.h4),
          const SizedBox(height: 8),
          Text(laboratory.address ?? 'Не указано',
              style: Styles.b2.copyWith(color: Palette.gray)),
          // Text(
          //   "${DateFormat("dd.MM.yyyy", "ru").format(laboratory.firstDayDate!)} - ${DateFormat("dd.MM.yyyy", "ru").format(laboratory.lastDayDate!)}",
          //   style: Styles.b2.copyWith(color: Palette.gray),
          // ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/states/nothing.png"),
          const SizedBox(height: 12),
          Text("Здесь пока ничего нет", style: Styles.b3),
        ],
      ),
    );
  }
}

/// Кастомный переключатель (как у тебя в примере)
class _CustomSegmentedControl extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _CustomSegmentedControl({
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Palette.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildTabItem("Афиша", 0),
          const SizedBox(width: 8),
          _buildTabItem("Лаборатории", 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Palette.primaryLime : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: isSelected
                ? Styles.button2.copyWith(color: Palette.white)
                : Styles.button2.copyWith(color: Palette.gray),
          ),
        ),
      ),
    );
  }
}
