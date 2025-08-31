// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:ltfest/components/custom_chip.dart';
// import 'package:ltfest/providers/laboratory_provider.dart';
// import 'package:ltfest/constants.dart';
//
// import '../../data/models/laboratory.dart';
// import '../../providers/direction_provider.dart';
//
// class LaboratoryPage extends ConsumerWidget {
//   const LaboratoryPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedDirection = ref.watch(selectedDirectionProvider);
//     final laboratoriesAsync =
//         ref.watch(laboratoriesProvider(selectedDirection));
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
//                       "Лаборатории",
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
//                             left: 16, top: 13, bottom: 13),
//                       ),
//                       onChanged: (value) {
//                         // TODO: Реализовать поиск в будущем
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SliverFillRemaining(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
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
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12.0, vertical: 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomChip(
//                               onDirectionSelected: (direction) {
//                                 ref
//                                     .read(selectedDirectionProvider.notifier)
//                                     .state = direction;
//                               },
//                             ),
//                             // const SizedBox(height: 12),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: laboratoriesAsync.when(
//                           data: (laboratories) {
//                             if (laboratories.isEmpty) {
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
//                                   const EdgeInsets.symmetric(horizontal: 12.0),
//                               itemCount: laboratories.length,
//                               itemBuilder: (context, index) {
//                                 final laboratory = laboratories[index];
//                                 return Column(
//                                   children: [
//                                     _buildEventCard(
//                                       laboratory: laboratory,
//                                       category: selectedDirection ?? 'Театр',
//                                       context: context,
//                                     ),
//                                     if (index < laboratories.length - 1)
//                                       const SizedBox(height: 32),
//                                     if (index == laboratories.length - 1)
//                                       const SizedBox(height: 20),
//                                   ],
//                                 );
//                               },
//                             );
//                           },
//                           loading: () => Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Center(
//                                 child: CircularProgressIndicator(
//                                     color: Palette.primaryLime)),
//                           ),
//                           error: (error, stack) => Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               children: [
//                                 Center(
//                                   child: Text(
//                                     'Ошибка: $error',
//                                     style: TextStyle(color: Palette.black),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 ElevatedButton(
//                                   onPressed: () => ref.refresh(
//                                       laboratoriesProvider(selectedDirection)),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Palette.primaryLime,
//                                     foregroundColor: Palette.black,
//                                   ),
//                                   child: const Text('Попробовать снова'),
//                                 ),
//                               ],
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
//     required Laboratory laboratory,
//     required String category,
//     required BuildContext context,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         context.push('/lab/${laboratory.id}');
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   'http://37.46.132.144:1337${laboratory.image?.formats?.medium?.url ?? laboratory.image?.url ?? ''}',//'assets/images/teatr_placeholder.png',
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
//             laboratory.title,
//             style: Styles.h4,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             laboratory.address ?? 'Не указано',
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
import 'package:ltfest/data/models/favorite.dart';
import 'package:ltfest/providers/favorites_provider.dart';
import 'package:ltfest/providers/laboratory_provider.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/laboratory.dart';
import 'package:ltfest/providers/direction_provider.dart';

class LaboratoryPage extends ConsumerStatefulWidget {
  const LaboratoryPage({super.key});

  @override
  ConsumerState<LaboratoryPage> createState() => _LaboratoryPageState();
}

class _LaboratoryPageState extends ConsumerState<LaboratoryPage> {
  // 2. Создаем контроллер для TextField
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    // 3. Инициализируем контроллер с текущим значением из провайдера
    final initialQuery =
        ref.read(laboratoriesProvider).valueOrNull?.searchQuery ?? '';
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
    final laboratoriesAsync = ref.watch(laboratoriesProvider);
    final laboratoryState =
        laboratoriesAsync.valueOrNull ?? LaboratoriesState();
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
                  children: [
                    Text("Лаборатории",
                        style: Styles.h3.copyWith(color: Palette.white)),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _searchController,
                      style: Styles.b2,
                      onChanged: (query) {
                        ref
                            .read(laboratoriesProvider.notifier)
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
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
                          ref.read(selectedDirectionProvider.notifier).state =
                              direction;
                        },
                      ),
                    ),
                    Expanded(
                      child: AsyncItemsListView(
                        asyncValue: laboratoriesAsync,
                        items: laboratoryState.filteredLaboratories,
                        onRefresh: () =>
                            ref.refresh(laboratoriesProvider.future),
                        itemBuilder: (context, index) {
                          final laboratory =
                              laboratoryState.filteredLaboratories[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: _buildEventCard(
                              laboratory: laboratory,
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
                child: Image.network(
                  'http://37.46.132.144:1337${laboratory.image?.formats?.medium?.url ?? laboratory.image?.url ?? ''}',
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
                      selectedDirection: laboratory.direction.title,
                    ),
                    FavoriteButton(
                        id: laboratory.id, eventType: EventType.laboratory)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(laboratory.title, style: Styles.h4),
          const SizedBox(height: 8),
          Text(laboratory.address ?? 'Не указано',
              style: Styles.b2.copyWith(color: Palette.gray)),
          Text(
            "${DateFormat("dd.MM.yyyy", "ru").format(laboratory.firstDayDate!)} - ${DateFormat("dd.MM.yyyy", "ru").format(laboratory.lastDayDate!)}",
            style: Styles.b2.copyWith(color: Palette.gray),
          ),
        ],
      ),
    );
  }
}
