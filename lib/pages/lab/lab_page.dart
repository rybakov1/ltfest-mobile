import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/components/custom_chip.dart';
import 'package:ltfest/providers/laboratory_provider.dart';
import 'package:ltfest/constants.dart';

import '../../data/models/laboratory.dart';
import '../../providers/direction_provider.dart';

class LaboratoryPage extends ConsumerWidget {
  const LaboratoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDirection = ref.watch(selectedDirectionProvider);
    final laboratoriesAsync =
        ref.watch(laboratoriesProvider(selectedDirection));

    return Scaffold(
      backgroundColor: Palette.black,
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Лаборатории",
                      style: Styles.h3.copyWith(color: Palette.white),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Palette.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Поиск",
                        hintStyle: Styles.b2,
                        contentPadding: const EdgeInsets.only(
                            left: 16, top: 13, bottom: 13),
                      ),
                      onChanged: (value) {
                        // TODO: Реализовать поиск в будущем
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Palette.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomChip(
                              onDirectionSelected: (direction) {
                                ref
                                    .read(selectedDirectionProvider.notifier)
                                    .state = direction;
                              },
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                      laboratoriesAsync.when(
                        data: (laboratories) {
                          if (laboratories.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  'Лаборатории не найдены',
                                  style: TextStyle(color: Palette.black),
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            itemCount: laboratories.length,
                            itemBuilder: (context, index) {
                              final laboratory = laboratories[index];
                              return Column(
                                children: [
                                  _buildEventCard(
                                    laboratory: laboratory,
                                    category: selectedDirection ?? 'Театр',
                                    context: context,
                                  ),
                                  if (index < laboratories.length - 1)
                                    const SizedBox(height: 32),
                                  if (index == laboratories.length - 1)
                                    const SizedBox(height: 20),
                                ],
                              );
                            },
                          );
                        },
                        loading: () => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: Palette.primaryLime)),
                        ),
                        error: (error, stack) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  'Ошибка: $error',
                                  style: TextStyle(color: Palette.black),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => ref.refresh(
                                    laboratoriesProvider(selectedDirection)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Palette.primaryLime,
                                  foregroundColor: Palette.black,
                                ),
                                child: const Text('Попробовать снова'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 4)),
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
        context.push('/lab/${laboratory.id}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/teatr_placeholder.png',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomChipWithName(
                  selectedDirection: category,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            laboratory.title,
            style: Styles.h4,
          ),
          const SizedBox(height: 8),
          Text(
            laboratory.address ?? 'Не указано',
            style: Styles.b2.copyWith(color: Palette.gray),
          ),
        ],
      ),
    );
  }
}
