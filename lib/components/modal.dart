import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';

Widget _buildShimmerList() {
  return Shimmer.fromColors(
    baseColor: Palette.shimmerBase,
    highlightColor: Palette.shimmerHighlight,
    child: ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 300.0,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 48.0,
                height: 48.0,
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 150.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void showModalPicker<T>({
  required BuildContext context,
  required String title,
  bool? isNoNeedSize,
  required FutureProvider<List<T>> provider,
  required String Function(T) itemBuilder,
  T? initialValue,
  required ValueChanged<T?> onConfirm,
}) {
  T? tempSelectedItem = initialValue;

  showModalBottomSheet(
    context: context,
    backgroundColor: Palette.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (modalContext) {
      return Consumer(builder: (context, ref, child) {
        return SizedBox(
          height: isNoNeedSize != null ? null : 500,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              final asyncValue = ref.watch(provider);

              final bool isItemSelected = tempSelectedItem != null;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 24 + MediaQuery.of(context).viewPadding.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 4, 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 40),
                          Expanded(
                            child: Text(title,
                                textAlign: TextAlign.center, style: Styles.h4),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Palette.stroke),
                            onPressed: () => Navigator.pop(modalContext),
                          ),
                        ],
                      ),
                    ),

                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16, left: 8),
                        child: asyncValue.when(
                          loading: () => _buildShimmerList(),
                          error: (err, st) =>
                              Center(child: Text('Ошибка: $err')),
                          data: (items) {
                            if (items.isEmpty) {
                              return const Center(
                                  child: Text("Нет данных для выбора"));
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return buildRadioListTile<T>(
                                  title: itemBuilder(item),
                                  value: item,
                                  groupValue: tempSelectedItem,
                                  onChanged: (newValue) {
                                    setModalState(() {
                                      tempSelectedItem = newValue;
                                    });
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    // --- Футер модального окна (кнопка) ---
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: LTButtons.elevatedButton(
                          onPressed: isItemSelected
                              ? () => onConfirm(tempSelectedItem)
                              : null,
                          child: Text(
                            'Выбрать',
                            style: Styles.button1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      });
    },
  );
}

Widget buildRadioListTile<T>({
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
