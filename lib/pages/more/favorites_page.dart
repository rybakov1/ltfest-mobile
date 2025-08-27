import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/data/models/laboratory.dart';
import 'package:ltfest/providers/favorites_provider.dart';

import '../../components/async_items_list_view.dart';
import '../../components/custom_chip.dart';
import '../../data/models/favorite.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    final favState = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: Palette.black,
      body: favState.when(
        data: (favorites) {
          // Разделяем на фестивали и лаборатории
          final favoriteFestivals = favorites
              .where((f) => f.type == 'festival')
              .toList();
          final favoriteLabs = favorites
              .where((f) => f.type == 'laboratory')
              .toList();

          return CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 24 + MediaQuery.of(context).padding.top,
                      bottom: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Избранное",
                          style: Styles.h3.copyWith(color: Palette.white),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 43,
                          width: 43,
                          decoration:
                          Decor.base.copyWith(color: Palette.primaryLime),
                          child: IconButton(
                            onPressed: () => context.pop(),
                            icon: Icon(Icons.arrow_back, color: Palette.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: Decor.base,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 16, left: 12, right: 12),
                        child: _CustomSegmentedControl(
                          selectedIndex: _selectedIndex,
                          onTap: _onTabTapped,
                        ),
                      ),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _selectedIndex == 0
                              ? _buildFavoritesList(favoriteFestivals)
                              : _buildFavoritesList(favoriteLabs),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Text("Ошибка загрузки избранного: $e",
              style: Styles.b2.copyWith(color: Palette.white)),
        ),
      ),
    );
  }

  Widget _buildFavoritesList(List<Favorite> items) {
    if (items.isEmpty) return _emptyState();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final fav = items[index];
          return Padding(
            padding: EdgeInsets.only(bottom: index < items.length - 1 ? 32.0 : 0),
            child: _buildFavoriteCard(fav),
          );
        },
      ),
    );
  }

  Widget _buildFavoriteCard(Favorite fav) {
    // final dateText = fav.dateEnd != null
    //     ? "${DateFormat("dd.MM.yyyy", "ru").format(fav.dateStart! as DateTime)} - ${DateFormat("dd.MM.yyyy", "ru").format(fav.dateEnd! as DateTime)}"
    //     : '';

    final dateText = "${fav.dateStart} - ${fav.dateEnd}";
    return GestureDetector(
      onTap: () {
        if (fav.type == 'festival') {
          context.push('/fest/${fav.id}');
        } else {
          context.push('/lab/${fav.id}');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'http://37.46.132.144:1337${fav.image ?? ''}',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (fav.direction != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomChipWithName(
                    selectedDirection: fav.direction!.title,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(fav.title, style: Styles.h4),
          const SizedBox(height: 8),
          Text(fav.address ?? 'Не указано',
              style: Styles.b2.copyWith(color: Palette.gray)),
          if (dateText.isNotEmpty)
            Text(dateText, style: Styles.b2.copyWith(color: Palette.gray)),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icons/states/nothing.png", width: 192),
          const SizedBox(height: 12),
          Text("Здесь пока ничего нет", style: Styles.b3),
        ],
      ),
    );
  }
}


/// Кастомный переключатель (как у тебя в примере)
class _CustomSegmentedControl extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _CustomSegmentedControl({
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Palette.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildTabItem("Афиша", 0),
          const SizedBox(width: 8),
          _buildTabItem("Лаборатории", 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Palette.primaryLime : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: isSelected
                ? Styles.button2.copyWith(color: Palette.white)
                : Styles.button2.copyWith(color: Palette.gray),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:ltfest/constants.dart';
// import 'package:ltfest/data/models/favorite.dart';
// import 'package:ltfest/providers/favorites_provider.dart';
//
// import '../../components/custom_chip.dart';
// import '../../components/favorite_button.dart';
//
// class FavoritesPage extends ConsumerStatefulWidget {
//   const FavoritesPage({super.key});
//
//   @override
//   ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
// }
//
// class _FavoritesPageState extends ConsumerState<FavoritesPage> {
//   int _selectedIndex = 0;
//
//   void _onTabTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final favoritesState = ref.watch(favoritesProvider);
//
//     return Scaffold(
//       backgroundColor: Palette.black,
//       body: CustomScrollView(
//         physics: NeverScrollableScrollPhysics(),
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: 16,
//                 right: 16,
//                 top: 24 + MediaQuery.of(context).padding.top,
//                 bottom: 16,
//               ),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Избранное",
//                       style: Styles.h3.copyWith(color: Palette.white),
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                       height: 43,
//                       width: 43,
//                       decoration: Decor.base.copyWith(color: Palette.primaryLime),
//                       child: IconButton(
//                         onPressed: () => context.pop(),
//                         icon: Icon(Icons.arrow_back, color: Palette.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverFillRemaining(
//             child: Container(
//               margin: EdgeInsets.all(4),
//               decoration: Decor.base,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: 20.0, bottom: 16, left: 12, right: 12),
//                     child: _CustomSegmentedControl(
//                       selectedIndex: _selectedIndex,
//                       onTap: _onTabTapped,
//                     ),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.topCenter,
//                       child: AnimatedSwitcher(
//                         duration: Duration(milliseconds: 300),
//                         child: favoritesState.when(
//                           data: (favorites) => _selectedIndex == 0
//                               ? _buildFestivalsList(favorites
//                               .where((f) => f.type == 'Festival')
//                               .toList())
//                               : _buildLabsList(favorites
//                               .where((f) => f.type == 'Laboratory')
//                               .toList()),
//                           loading: () => Center(
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Palette.white,
//                             ),
//                           ),
//                           error: (error, _) => Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset("assets/icons/states/error.png",
//                                     width: 192),
//                                 SizedBox(height: 12),
//                                 Text("Ошибка загрузки: $error",
//                                     style: Styles.b3.copyWith(color: Palette.white)),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFestivalsList(List<Favorite> festivals) {
//     if (festivals.isEmpty) {
//       return _emptyState();
//     }
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8.0),
//       child: ListView.builder(
//         itemCount: festivals.length,
//         itemBuilder: (context, index) {
//           final festival = festivals[index];
//           return Padding(
//             padding: EdgeInsets.only(
//               bottom: index < festivals.length - 1 ? 32.0 : 0,
//             ),
//             child: _buildEventCard(
//               favorite: festival,
//               context: context,
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildEventCard({
//     required BuildContext context,
//     required Favorite favorite,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         context.push('/fest/${favorite.id}');
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   'http://37.46.132.144:1337${favorite.image ?? ''}',
//                   height: 150,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: CustomChipWithName(
//                   selectedDirection: favorite.direction?.title ?? 'Не указано',
//                 ),
//               ),
//               // Positioned(
//               //   top: 8,
//               //   right: 8,
//               //   child: FavoriteButton(
//               //     item: Favorite(
//               //       id: favorite.id,
//               //       title: favorite.title,
//               //       dateStart: favorite.dateStart,
//               //       dateEnd: favorite.dateEnd,
//               //       image: favorite.image,
//               //       address: favorite.address,
//               //       direction: favorite.direction, type: 'festival',
//               //     ), id: null, e, eventType: null,   )Type: null,
//               //   ),
//               // ),
//             ],
//           ),
//           SizedBox(height: 8),
//           Text(favorite.title, style: Styles.h4.copyWith(color: Palette.white)),
//           SizedBox(height: 8),
//           Text(favorite.address ?? 'Не указано',
//               style: Styles.b2.copyWith(color: Palette.gray)),
//           Text(
//             "${DateFormat("dd.MM.yyyy", "ru").format(DateTime.parse(favorite.dateStart))} - ${DateFormat("dd.MM.yyyy", "ru").format(DateTime.parse(favorite.dateEnd))}",
//             style: Styles.b2.copyWith(color: Palette.gray),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLabsList(List<Favorite> labs) {
//     if (labs.isEmpty) {
//       return _emptyState();
//     }
//
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: ListView.builder(
//         itemCount: labs.length,
//         itemBuilder: (context, index) {
//           final laboratory = labs[index];
//           return Padding(
//             padding: EdgeInsets.only(
//               bottom: index < labs.length - 1 ? 32.0 : 40,
//             ),
//             child: _buildLabEventCard(
//               favorite: laboratory,
//               context: context,
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildLabEventCard({
//     required Favorite favorite,
//     required BuildContext context,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         context.push('/lab/${favorite.id}');
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   'http://37.46.132.144:1337${favorite.image ?? ''}',
//                   height: 150,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: CustomChipWithName(
//                   selectedDirection: favorite.direction?.title ?? 'Не указано',
//                 ),
//               ),
//               // Positioned(
//               //   top: 8,
//               //   right: 8,
//               //   child: FavoriteButton(
//               //     item: Favorite(
//               //       id: favorite.id,
//               //       title: favorite.title,
//               //       dateStart: favorite.dateStart,
//               //       dateEnd: favorite.dateEnd,
//               //       image: favorite.image,
//               //       address: favorite.address,
//               //       direction: favorite.direction, type: 'laboratory',
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//           SizedBox(height: 8),
//           Text(favorite.title, style: Styles.h4.copyWith(color: Palette.white)),
//           SizedBox(height: 8),
//           Text(favorite.address ?? 'Не указано',
//               style: Styles.b2.copyWith(color: Palette.gray)),
//           Text(
//             "${DateFormat("dd.MM.yyyy", "ru").format(DateTime.parse(favorite.dateStart))} - ${DateFormat("dd.MM.yyyy", "ru").format(DateTime.parse(favorite.dateEnd))}",
//             style: Styles.b2.copyWith(color: Palette.gray),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _emptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset("assets/icons/states/nothing.png", width: 192),
//           SizedBox(height: 12),
//           Text("Здесь пока ничего нет",
//               style: Styles.b3.copyWith(color: Palette.white)),
//         ],
//       ),
//     );
//   }
// }
//
// class _CustomSegmentedControl extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onTap;
//
//   const _CustomSegmentedControl({
//     required this.selectedIndex,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 40,
//       decoration: BoxDecoration(
//         color: Palette.background,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           _buildTabItem("Афиша", 0),
//           SizedBox(width: 8),
//           _buildTabItem("Лаборатории", 1),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTabItem(String title, int index) {
//     final bool isSelected = selectedIndex == index;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => onTap(index),
//         child: AnimatedContainer(
//           duration: Duration(milliseconds: 200),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: isSelected ? Palette.primaryLime : Colors.transparent,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             title,
//             style: isSelected
//                 ? Styles.button2.copyWith(color: Palette.white)
//                 : Styles.button2.copyWith(color: Palette.gray),
//           ),
//         ),
//       ),
//     );
//   }
// }