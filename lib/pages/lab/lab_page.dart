import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/components/async_items_list_view.dart';
import 'package:ltfest/components/custom_chip.dart';
import 'package:ltfest/components/favorite_button.dart';
import 'package:ltfest/providers/favorites_provider.dart';
import 'package:ltfest/providers/laboratory_provider.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/laboratory.dart';
import 'package:ltfest/providers/direction_provider.dart';
import 'package:ltfest/router/app_routes.dart';

class LaboratoryPage extends ConsumerStatefulWidget {
  const LaboratoryPage({super.key});

  @override
  ConsumerState<LaboratoryPage> createState() => _LaboratoryPageState();
}

class _LaboratoryPageState extends ConsumerState<LaboratoryPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    final initialQuery =
        ref.read(laboratoriesProvider).valueOrNull?.searchQuery ?? '';
    _searchController = TextEditingController(text: initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final laboratoriesAsync = ref.watch(laboratoriesProvider);
    final laboratoryState =
        laboratoriesAsync.valueOrNull ?? LaboratoriesState();
    final selectedDirection = ref.watch(selectedDirectionProvider);

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 24, bottom: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Лаборатории",
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      style: Styles.b2,
                      controller: _searchController,
                      onChanged: (query) {
                        ref
                            .read(laboratoriesProvider.notifier)
                            .setSearchQuery(query);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Palette.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Palette.stroke, width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Palette.stroke, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Palette.primaryLime, width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Palette.error, width: 1)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Palette.error, width: 1)),
                        hintText: "Поиск",
                        hintStyle: Styles.b2,
                        contentPadding: const EdgeInsets.only(
                            left: 16, top: 13, bottom: 13),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 6),
                      child: CustomChip(
                        onDirectionSelected: (direction) {
                          ref.read(selectedDirectionProvider.notifier).state =
                              direction;
                        },
                      ),
                    ),
                    Expanded(
                      child: AsyncItemsListView(
                        asyncValue: laboratoriesAsync,
                        items: laboratoryState.filteredLaboratories,
                        onRefresh: () =>
                            ref.refresh(laboratoriesProvider.future),
                        itemBuilder: (context, index) {
                          final laboratory =
                              laboratoryState.filteredLaboratories[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: _buildEventCard(
                              laboratory: laboratory,
                              category: selectedDirection ?? 'Театр',
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
    required Laboratory laboratory,
    required String category,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        context.push('${AppRoutes.laboratories}/${laboratory.id}');
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomChipWithName(
                      selectedDirection: laboratory.direction.title,
                    ),
                    FavoriteButton(
                        id: laboratory.id, eventType: EventType.laboratory)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(laboratory.title, style: Styles.h4),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(laboratory.address ?? 'Не указано',
                  style: Styles.b2.copyWith(color: Palette.gray)),
              Text(
                "${DateFormat("dd", "ru").format(laboratory.firstDayDate!)} - ${DateFormat("dd", "ru").format(laboratory.lastDayDate!)} ${DateFormat("MMMM yyyy", "ru").format(laboratory.firstDayDate!)}",
                style: Styles.b2.copyWith(color: Palette.gray),
              ),
            ],
          )
        ],
      ),
    );
  }
}
