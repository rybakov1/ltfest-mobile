import 'package:flutter/material.dart';
import 'package:ltfest/constants.dart';

class CustomSegmentedControl extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<String> tabs;

  const CustomSegmentedControl({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4), // Добавим отступы для красоты
      decoration: BoxDecoration(
        color: Palette.background, // Светло-серый фон
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          return _buildTabItem(context, tabs[index], index);
        }),
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, String title, int index) {
    final bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Palette.primaryLime : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: isSelected
                ? Styles.button2.copyWith(color: Palette.black) // Можно использовать белый, если так лучше
                : Styles.button2.copyWith(color: Palette.gray),
          ),
        ),
      ),
    );
  }
}