import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/constants.dart';

class AsyncItemsListView extends StatelessWidget {
  final AsyncValue asyncValue;
  final List<dynamic> items;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final VoidCallback onRefresh;
  final ScrollController? scrollController;

  const AsyncItemsListView({
    super.key,
    required this.asyncValue,
    required this.items,
    required this.itemBuilder,
    required this.onRefresh,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: asyncValue.when(
        data: (_) {
          if (items.isEmpty) {
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 128),
                  Center(
                      child: Image.asset(
                    "assets/icons/states/nothing.png",
                    width: 192,
                    fit: BoxFit.contain,
                  )),
                  const SizedBox(height: 20),
                  Text("По вашему запросу ничего не найдено",
                      style: Styles.b2.copyWith(color: Palette.gray)),
                ],
              ),
            );
          }
          // Успешная загрузка и есть данные для отображения
          return ListView.builder(
            //shrinkWrap: true,
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12),
            itemCount: items.length,
            itemBuilder: itemBuilder,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Произошла ошибка',
                    style: TextStyle(color: Palette.black)),
                const SizedBox(height: 16),

                // TODO: error handler
                ElevatedButton(
                  onPressed: onRefresh,
                  child: const Text('Попробовать снова'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
