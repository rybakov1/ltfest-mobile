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
        ref.read(laboratoriesNotifierProvider).valueOrNull?.searchQuery ?? '';
    _searchController = TextEditingController(text: initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showCityBottomSheet(
      LaboratoriesState state, String? selectedDirection) {
    final uniqueCities = state.getUniqueCitiesForDirection(selectedDirection);
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
                                .read(laboratoriesNotifierProvider.notifier)
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
                              .read(laboratoriesNotifierProvider.notifier)
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

  void _showLearningTypeBottomSheet(
      LaboratoriesState state, String? selectedDirection) {
    final uniqueTypes =
        state.getUniqueLearningTypesForDirection(selectedDirection);
    List<String> selected = List<String>.from(state.selectedLearningTypes);

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
              Center(
                child: Container(
                  width: 41,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Palette.stroke,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Тип обучения',
                textAlign: TextAlign.center,
                style: Styles.h4,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: uniqueTypes.isEmpty
                    ? const Center(child: Text("Нет типов для выбора"))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: uniqueTypes.length,
                        itemBuilder: (context, index) {
                          final type = uniqueTypes[index];
                          final isSelected = selected.contains(type);
                          return Column(
                            children: [
                              _buildCheckboxListTile(
                                title: type,
                                value: isSelected,
                                onChanged: (value) {
                                  setModalState(() {
                                    if (value == true) {
                                      selected.add(type);
                                    } else {
                                      selected.remove(type);
                                    }
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
              ),
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
                                .read(laboratoriesNotifierProvider.notifier)
                                .setSelectedLearningTypes([]);
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
                              .read(laboratoriesNotifierProvider.notifier)
                              .setSelectedLearningTypes(selected);
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
    final laboratoriesAsync = ref.watch(laboratoriesNotifierProvider);
    final laboratoryState =
        laboratoriesAsync.valueOrNull ?? LaboratoriesState();
    final selectedDirection = ref.watch(selectedDirectionProvider);
    final filteredLaboratories =
        laboratoryState.getFilteredLaboratories(selectedDirection);

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
                            .read(laboratoriesNotifierProvider.notifier)
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
                      child: Row(
                        children: [
                          CustomChip(
                            onDirectionSelected: (direction) {
                              ref
                                  .read(selectedDirectionProvider.notifier)
                                  .state = direction;
                            },
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _showLearningTypeBottomSheet(
                                laboratoryState, selectedDirection),
                            child: Container(
                              height: 32,
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                color: laboratoryState
                                        .selectedLearningTypes.isEmpty
                                    ? Palette.white
                                    : Palette.primaryLime,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Palette.stroke,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Тип обучения",
                                    style: Styles.b2.copyWith(
                                      color: laboratoryState
                                              .selectedLearningTypes.isEmpty
                                          ? Palette.gray
                                          : Palette.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(
                                    laboratoryState
                                            .selectedLearningTypes.isEmpty
                                        ? Icons.keyboard_arrow_down_outlined
                                        : Icons.close,
                                    color: laboratoryState
                                            .selectedLearningTypes.isEmpty
                                        ? const Color(0xFF1C274C)
                                        : Palette.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _showCityBottomSheet(
                                laboratoryState, selectedDirection),
                            child: Container(
                              height: 32,
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                color: laboratoryState.selectedCities.isEmpty
                                    ? Palette.white
                                    : Palette.primaryLime,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Palette.stroke,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Город",
                                    style: Styles.b2.copyWith(
                                      color:
                                          laboratoryState.selectedCities.isEmpty
                                              ? Palette.gray
                                              : Palette.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Icon(
                                    laboratoryState.selectedCities.isEmpty
                                        ? Icons.keyboard_arrow_down_outlined
                                        : Icons.close,
                                    color:
                                        laboratoryState.selectedCities.isEmpty
                                            ? const Color(0xFF1C274C)
                                            : Palette.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AsyncItemsListView(
                        asyncValue: laboratoriesAsync,
                        items: filteredLaboratories,
                        onRefresh: () =>
                            ref.refresh(laboratoriesNotifierProvider.future),
                        itemBuilder: (context, index) {
                          final laboratory = filteredLaboratories[index];
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
                "${DateFormat("dd.MM.yyyy", "ru").format(laboratory.firstDayDate!)} - ${DateFormat("dd.MM.yyyy", "ru").format(laboratory.lastDayDate!)}",
                style: Styles.b2.copyWith(color: Palette.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
