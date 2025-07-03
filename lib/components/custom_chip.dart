import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ltfest/constants.dart';

import '../providers/direction_provider.dart'; // Для selectedDirectionProvider

class CustomChip extends StatelessWidget {
  final Function(String)? onDirectionSelected;

  const CustomChip({
    super.key,
    this.onDirectionSelected,
  });

  void _showDirectionPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Consumer(builder: (context, ref, child) {
          final selectedDirection =
              ref.watch(selectedDirectionProvider) ?? 'Театр';
          return Container(
            height: 333,
            padding: const EdgeInsets.only(bottom: 24),
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
                  child: Text('Направление', style: Styles.h4),
                ),
                const SizedBox(height: 32),
                RadioListTile<String>(
                  title: Text('Театр', style: Styles.b2),
                  value: 'Театр',
                  dense: true,
                  groupValue: selectedDirection,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(selectedDirectionProvider.notifier).state =
                          value;
                      onDirectionSelected?.call(value);
                      Navigator.pop(context);
                    }
                  },
                  activeColor: Palette.secondary,
                ),
                RadioListTile<String>(
                  title: Text('Танцы', style: Styles.b2),
                  value: 'Танцы',
                  groupValue: selectedDirection,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(selectedDirectionProvider.notifier).state =
                          value;
                      onDirectionSelected?.call(value);
                      Navigator.pop(context);
                    }
                  },
                  activeColor: Palette.secondary,
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedDirection =
            ref.watch(selectedDirectionProvider) ?? 'Театр';

        return GestureDetector(
          onTap: () => _showDirectionPicker(context, ref),
          child: Container(
            decoration: BoxDecoration(
              color: selectedDirection == 'Танцы'
                  ? Palette.primaryPink
                  : Palette.primaryLime,
              borderRadius: BorderRadius.circular(8),
            ),
            padding:
                const EdgeInsets.only(left: 10, top: 7, bottom: 9, right: 10),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  selectedDirection,
                  style: Styles.b2.copyWith(
                    color: selectedDirection == 'Танцы'
                        ? Palette.white
                        : Palette.black,
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/drop_down_arrow.svg',
                  colorFilter: selectedDirection == 'Танцы'
                      ? ColorFilter.mode(Palette.white, BlendMode.srcIn)
                      : ColorFilter.mode(Palette.black, BlendMode.srcIn),
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
        color:
            selectedDirection == 'Танцы' ? Palette.primaryPink : Palette.primaryLime,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 10, top: 7, bottom: 9, right: 10),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            selectedDirection,
            style: Styles.b2.copyWith(
              color:
                  selectedDirection == 'Танцы' ? Palette.white : Palette.black,
            ),
          ),
        ],
      ),
    );
  }
}
