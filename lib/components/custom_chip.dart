import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/providers/direction_provider.dart';

class CustomChip extends ConsumerWidget {
  // ИЗМЕНЕНИЕ: Тип коллбэка теперь может быть null
  final ValueChanged<String?> onDirectionSelected;

  const CustomChip({
    super.key,
    required this.onDirectionSelected,
  });

  void _showDirectionPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Consumer(builder: (context, ref, child) {
          // selectedDirection теперь может быть null
          final selectedDirection = ref.watch(selectedDirectionProvider);
          final directionsAsync = ref.watch(directionsProvider);

          return Container(
            padding: EdgeInsets.only(
                bottom: 24 + MediaQuery.of(context).viewPadding.bottom),
            constraints: const BoxConstraints(minHeight: 200),
            // Чтобы не было ошибки рендера при загрузке
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                  child: Text('Направление', style: Styles.h4),
                ),
                const SizedBox(height: 32),

                // --- ИЗМЕНЕНИЯ ЗДЕСЬ ---
                directionsAsync.when(
                  data: (directions) => Column(
                    children: [
                      ...directions.map((direction) {
                        return RadioListTile<String?>(
                          title: Text(direction.title, style: Styles.b2),
                          value: direction.title,
                          dense: true,
                          groupValue: selectedDirection,
                          onChanged: (value) {
                            if (value != null) {
                              ref
                                  .read(selectedDirectionProvider.notifier)
                                  .state = value;
                              onDirectionSelected(value);
                              //Navigator.pop(context);
                            }
                          },
                          activeColor: Palette.secondary,
                        );
                      }),
                      RadioListTile<String?>(
                        title: Text('Все направления', style: Styles.b2),
                        value: null,
                        // Значение для "Все" - это null
                        dense: true,
                        groupValue: selectedDirection,
                        onChanged: (value) {
                          ref.read(selectedDirectionProvider.notifier).state =
                              null;
                          onDirectionSelected(null);
                        },
                        activeColor: Palette.secondary,
                      ),
                    ],
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, s) => const Center(
                      child: Text("Не удалось загрузить направления")),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () {
                              ref
                                  .read(selectedDirectionProvider.notifier)
                                  .state = null;
                              onDirectionSelected(null);
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Palette.stroke),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text("Отмена",
                                style: Styles.button1
                                    .copyWith(color: Palette.error)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: LTButtons.elevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Сохранить',
                              style: Styles.button1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedDirection = ref.watch(selectedDirectionProvider);

        final String displayText = selectedDirection ?? 'Все';
        final Color displayColor = selectedDirection == 'Танцы'
            ? Palette.primaryPink
            : (selectedDirection == null ? Palette.secondary : Palette.primaryLime);

        return GestureDetector(
          onTap: () => _showDirectionPicker(context, ref),
          child: Container(
            decoration: BoxDecoration(
              color: displayColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
        borderRadius: BorderRadius.circular(8),
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
