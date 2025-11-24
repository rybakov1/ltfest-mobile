import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/providers/direction_provider.dart';

class CustomChip extends ConsumerWidget {
  final ValueChanged<String?> onDirectionSelected;

  const CustomChip({
    super.key,
    required this.onDirectionSelected,
  });

  void _showDirectionPicker(BuildContext context, WidgetRef ref) {
    final initialSelected = ref.read(selectedDirectionProvider);
    String? tempSelected = initialSelected;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext modalContext) {
        return Consumer(builder: (context, ref, child) {
          final directionsAsync = ref.watch(directionsProvider);

          return StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Направление',
                      textAlign: TextAlign.center,
                      style: Styles.h4,
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: directionsAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, s) => const Center(
                            child: Text("Не удалось загрузить направления")),
                        data: (directions) {
                          final allItems = [
                            ...directions.map((direction) => {
                                  'title': direction.title,
                                  'value': direction.title
                                }),
                            {
                              'title': 'Все направления',
                              'value': null as String?
                            },
                          ];
                          if (allItems.isEmpty) {
                            return const Center(
                                child: Text("Нет данных для выбора"));
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: allItems.length,
                            itemBuilder: (context, index) {
                              final item = allItems[index];
                              final itemTitle = item['title'] as String;
                              final itemValue = item['value'];
                              return Column(
                                children: [
                                  _buildRadioListTile<String?>(
                                    title: itemTitle,
                                    value: itemValue,
                                    groupValue: tempSelected,
                                    onChanged: (newValue) {
                                      setModalState(() {
                                        tempSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    // Footer
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: LTButtons.outlinedButton(
                              onPressed: () {
                                Navigator.pop(modalContext);
                                ref
                                    .read(selectedDirectionProvider.notifier)
                                    .state = null;
                                onDirectionSelected(null);
                              },
                              child: Text('Сбросить', style: Styles.button1),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: LTButtons.elevatedButton(
                              onPressed: () {
                                ref
                                    .read(selectedDirectionProvider.notifier)
                                    .state = tempSelected;
                                onDirectionSelected(tempSelected);
                                Navigator.pop(modalContext);
                              },
                              child: Text('Применить', style: Styles.button1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
      },
    );
  }

  Widget _buildRadioListTile<T>({
    required String title,
    required T value,
    required T? groupValue,
    required ValueChanged<T?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            visualDensity: VisualDensity.compact,
            activeColor: Palette.secondary,
            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return Palette.secondary;
              }
              return Palette.stroke;
            }),
          ),
          const SizedBox(width: 0.0),
          Expanded(
            child: Text(title, style: Styles.b2),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedDirection = ref.watch(selectedDirectionProvider);

        final String displayText = selectedDirection ?? 'Все направления';
        final Color displayColor = selectedDirection == 'Танцы'
            ? Palette.primaryPink
            : (selectedDirection == null
                ? Palette.secondary
                : Palette.primaryLime);

        return GestureDetector(
          onTap: () => _showDirectionPicker(context, ref),
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: displayColor,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  displayText,
                  style: Styles.b2.copyWith(color: Palette.white),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/drop_down_arrow.svg',
                  colorFilter: ColorFilter.mode(Palette.white, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomChipWithName extends StatelessWidget {
  final String selectedDirection;

  const CustomChipWithName({super.key, required this.selectedDirection});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selectedDirection == 'Танцы'
            ? Palette.primaryPink
            : Palette.primaryLime,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            selectedDirection,
            style: Styles.b3.copyWith(
              color: Palette.white,
            ),
          ),
        ],
      ),
    );
  }
}
