// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:ltfest/components/custom_chip.dart';
// import 'package:ltfest/constants.dart';
//
// import '../../data/models/festival.dart';
// import '../../data/services/api_service.dart';
// import '../../providers/direction_provider.dart';
// import '../../providers/festival_provider.dart';
//
// class FestivalPage extends ConsumerWidget {
//   const FestivalPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final festivalsAsync = ref.watch(festivalsProvider);
//     final selectedDirection = ref.watch(selectedDirectionProvider);
//
//     return Scaffold(
//       backgroundColor: Palette.black,
//       body: SafeArea(
//         child: CustomScrollView(
//           physics: const NeverScrollableScrollPhysics(),
//           slivers: [
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 24, horizontal: 16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Афиша",
//                       style: Styles.h3.copyWith(color: Palette.white),
//                     ),
//                     const SizedBox(height: 30),
//                     TextField(
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Palette.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide.none,
//                         ),
//                         hintText: "Поиск",
//                         hintStyle: Styles.b2,
//                         contentPadding: const EdgeInsets.only(
//                           left: 16,
//                           top: 13,
//                           bottom: 13,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // main container
//             SliverFillRemaining(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Palette.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.1),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 12, left: 12, top: 20, bottom: 6),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomChip(
//                               onDirectionSelected: (direction) {
//                                 ref
//                                     .read(selectedDirectionProvider.notifier)
//                                     .state = direction;
//                                 ref.read(festivalsProvider.notifier).refresh();
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: festivalsAsync.when(
//                           data: (festivals) {
//                             if (festivals.isEmpty) {
//                               return Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Center(
//                                     child: Image.asset(
//                                       "assets/icons/states/nothing.png",
//                                       width: 192,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 20),
//                                   Text(
//                                     "По вашему запросу ничего не найдено",
//                                     style: Styles.b3.copyWith(color: Palette.gray),
//                                   ),
//                                 ],
//                               );
//                             }
//                             return ListView.builder(
//                               shrinkWrap: true,
//                               physics: const ClampingScrollPhysics(),
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
//                               itemCount: festivals.length,
//                               itemBuilder: (context, index) {
//                                 final festival = festivals[index];
//                                 return Column(
//                                   children: [
//                                     // const SizedBox(height: 12),
//                                     _buildEventCard(
//                                         festival: festival,
//                                         category: selectedDirection ?? 'Театр',
//                                         context: context),
//                                     const SizedBox(height: 20)
//                                   ],
//                                 );
//                               },
//                             );
//                           },
//                           loading: () => const Padding(
//                             padding: EdgeInsets.all(16.0),
//                             child: Center(child: CircularProgressIndicator()),
//                           ),
//                           error: (error, stack) => Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Center(
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     'Ошибка: $error',
//                                     style: TextStyle(color: Palette.black),
//                                   ),
//                                   const SizedBox(height: 16),
//                                   ElevatedButton(
//                                     onPressed: () => ref
//                                         .read(festivalsProvider.notifier)
//                                         .refresh(),
//                                     child: const Text('Попробовать снова'),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SliverToBoxAdapter(child: SizedBox(height: 4)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEventCard({
//     required BuildContext context,
//     required Festival festival,
//     required String category,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         context.push('/fest/${festival.id}');
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   'http://37.46.132.144:1337${festival.image?.formats?.medium?.url ?? festival.image?.url ?? ''}',//'assets/images/teatr_placeholder.png',
//                   height: 150,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CustomChipWithName(
//                   selectedDirection: category,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             festival.title,
//             style: Styles.h4,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             festival.address ?? 'Не указано',
//             style: Styles.b2.copyWith(color: Palette.gray),
//           ),
//            Text(
//             "${DateFormat("dd.MM.yyyy", "ru").format(festival.dateStart!)} - ${DateFormat("dd.MM.yyyy", "ru").format(festival.dateEnd!)} ",
//             style: Styles.b2.copyWith(color: Palette.gray),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/components/async_items_list_view.dart';
import 'package:ltfest/components/custom_chip.dart';
import 'package:ltfest/components/favorite_button.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/favorite.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/models/upcoming_events.dart';
import 'package:ltfest/providers/direction_provider.dart';
import 'package:ltfest/providers/festival_provider.dart';

import '../../providers/favorites_provider.dart';

class FestivalPage extends ConsumerStatefulWidget {
  const FestivalPage({super.key});

  @override
  ConsumerState<FestivalPage> createState() => _FestivalPageState();
}

class _FestivalPageState extends ConsumerState<FestivalPage> {
  // 2. Создаем контроллер для TextField
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    // 3. Инициализируем контроллер с текущим значением из провайдера
    final initialQuery =
        ref.read(festivalsProvider).valueOrNull?.searchQuery ?? '';
    _searchController = TextEditingController(text: initialQuery);
  }

  @override
  void dispose() {
    // 4. Не забываем очищать контроллер
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // "Слушаем" состояние нашего "умного" провайдера
    final festivalsAsync = ref.watch(festivalsProvider);
    // Получаем текущее состояние (включая фильтры) или пустое состояние по умолчанию
    final festivalState = festivalsAsync.valueOrNull ?? FestivalsState();
    final selectedDirection = ref.watch(selectedDirectionProvider);
    ref.listen(festivalsProvider, (_, next) {
      final newQuery = next.valueOrNull?.searchQuery ?? '';
      if (newQuery != _searchController.text) {
        _searchController.text = newQuery;
      }
    });
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
                  children: [
                    Text("Афиша",
                        style: Styles.h3.copyWith(color: Palette.white)),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _searchController,
                      onChanged: (query) {
                        ref
                            .read(festivalsProvider.notifier)
                            .setSearchQuery(query);
                      },
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
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(12),
                  // ... тени
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 12, left: 12, top: 20, bottom: 6),
                      child: CustomChip(
                        onDirectionSelected: (direction) {
                          // Просто меняем направление, провайдер festivalsProvider отреагирует сам
                          ref.read(selectedDirectionProvider.notifier).state =
                              direction;
                        },
                      ),
                    ),
                    Expanded(
                      // Используем наш новый чистый виджет для отображения списка
                      child: AsyncItemsListView(
                        asyncValue: festivalsAsync,
                        items: festivalState.filteredFestivals,
                        // Передаем отфильтрованный список
                        onRefresh: () => ref.refresh(festivalsProvider.future),
                        itemBuilder: (context, index) {
                          final festival =
                              festivalState.filteredFestivals[index];
                          // Разметка карточки остается здесь, как вы и просили
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index <
                                      festivalState.filteredFestivals.length - 1
                                  ? 32.0
                                  : 8,
                            ),
                            child: _buildEventCard(
                              festival: festival,
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

  // Метод для отрисовки карточки, который остается внутри страницы
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
                  'http://37.46.132.144:1337${festival.image?.formats?.medium?.url ?? festival.image?.url ?? ''}',
                  height: 150,
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
                      selectedDirection: festival.direction.title,
                    ),
                    FavoriteButton(id: festival.id, eventType: EventType.festival),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(festival.title, style: Styles.h4),
          const SizedBox(height: 8),
          Text(festival.address ?? 'Не указано',
              style: Styles.b2.copyWith(color: Palette.gray)),
          Text(
            "${DateFormat("dd.MM.yyyy", "ru").format(festival.dateStart!)} - ${DateFormat("dd.MM.yyyy", "ru").format(festival.dateEnd!)}",
            style: Styles.b2.copyWith(color: Palette.gray),
          ),
        ],
      ),
    );
  }
}
