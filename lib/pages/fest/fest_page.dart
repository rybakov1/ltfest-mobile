import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/components/custom_chip.dart';
import 'package:ltfest/constants.dart';

import '../../data/models/festival.dart';
import '../../data/services/api_service.dart';
import '../../providers/direction_provider.dart';

final festivalsProvider =
    AsyncNotifierProvider<FestivalsNotifier, List<Festival>>(
        FestivalsNotifier.new);

class FestivalsNotifier extends AsyncNotifier<List<Festival>> {
  @override
  Future<List<Festival>> build() async {
    final apiService = ref.read(apiServiceProvider);
    final direction = ref.watch(selectedDirectionProvider);
    return await apiService.getFestivals(); //direction: direction
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final apiService = ref.read(apiServiceProvider);
      final direction = ref.read(selectedDirectionProvider);
      return await apiService.getFestivals(); //direction: direction
    });
  }
}

class FestivalPage extends ConsumerWidget {
  const FestivalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final festivalsAsync = ref.watch(festivalsProvider);
    final selectedDirection = ref.watch(selectedDirectionProvider);

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
                      "Афиша",
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
                          left: 16,
                          top: 13,
                          bottom: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // main container
            SliverFillRemaining(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
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
                        padding: const EdgeInsets.only(right: 12, left: 12, top: 20, bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomChip(
                              onDirectionSelected: (direction) {
                                ref
                                    .read(selectedDirectionProvider.notifier)
                                    .state = direction;
                                ref.read(festivalsProvider.notifier).refresh();
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: festivalsAsync.when(
                          data: (festivals) {
                            if (festivals.isEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      "assets/icons/states/nothing.png",
                                      width: 192,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "По вашему запросу ничего не найдено",
                                    style: Styles.b3.copyWith(color: Palette.gray),
                                  ),
                                ],
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                              itemCount: festivals.length,
                              itemBuilder: (context, index) {
                                final festival = festivals[index];
                                return Column(
                                  children: [
                                    // const SizedBox(height: 12),
                                    _buildEventCard(
                                        festival: festival,
                                        category: selectedDirection ?? 'Театр',
                                        context: context),
                                    const SizedBox(height: 20)
                                  ],
                                );
                              },
                            );
                          },
                          loading: () => const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          error: (error, stack) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Ошибка: $error',
                                    style: TextStyle(color: Palette.black),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () => ref
                                        .read(festivalsProvider.notifier)
                                        .refresh(),
                                    child: const Text('Попробовать снова'),
                                  ),
                                ],
                              ),
                            ),
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
    required BuildContext context,
    required Festival festival,
    required String category,
  }) {
    return GestureDetector(
      onTap: () {
        context.push('/fest/${festival.id}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'http://37.46.132.144:1337${festival.image?.formats?.medium?.url ?? festival.image?.url ?? ''}',//'assets/images/teatr_placeholder.png',
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
            festival.title,
            style: Styles.h4,
          ),
          const SizedBox(height: 8),
          Text(
            festival.address ?? 'Не указано',
            style: Styles.b2.copyWith(color: Palette.gray),
          ),
          // TODO: Text(
          //   festival.date,
          //   style: Styles.b2.copyWith(color: Palette.gray),
          // ),
        ],
      ),
    );
  }
}
