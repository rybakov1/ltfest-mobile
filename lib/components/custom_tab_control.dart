import 'package:flutter/material.dart';
import '../constants.dart';

class CustomSegmentedControl extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomSegmentedControl({
    super.key,
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
        borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
