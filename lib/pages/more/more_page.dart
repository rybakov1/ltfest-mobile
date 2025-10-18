import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/router/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../providers/user_provider.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  //final PriorityLevel? _selectedPriority;

  // Future<void> _launchUrl(String urlString) async {
  //   final uri = Uri.parse(urlString);
  //   await launchUrl(uri, mode: LaunchMode.externalApplication);
  // }

  // void _showLTPriorityPopup(BuildContext context, WidgetRef ref) {
  //   showModalBottomSheet(
  //     useRootNavigator: true,
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Palette.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: const EdgeInsets.all(16)
  //             .copyWith(bottom: 16 + MediaQuery.of(context).padding.bottom),
  //         child: FractionallySizedBox(
  //           heightFactor: 0.8,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 width: 40,
  //                 height: 4,
  //                 decoration: BoxDecoration(
  //                     color: Palette.stroke,
  //                     borderRadius: BorderRadius.circular(2)),
  //               ),
  //               const SizedBox(height: 24),
  //               Text('LT Priority', style: Styles.h3),
  //               const SizedBox(height: 16),
  //               // Text('Вы уверены, что хотите выйти из аккаунта?',
  //               //     style: Styles.b2, textAlign: TextAlign.center),
  //               Expanded(
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     children: [
  //                       PriorityCard(
  //                         title: 'LT Silver',
  //                         discount: 'Скидка 5%',
  //                         price: '35 000 ₽/год',
  //                         features: const [
  //                           '+10 минут дополнительной репетиции на сцене во время театрального фестиваля.',
  //                           '+1 минута на каждый номер во время хореографического конкурса.',
  //                         ],
  //                         value: PriorityLevel.silver,
  //                         groupValue: null,
  //                         //_selectedPriority,
  //                         onChanged: (value) {
  //                           // setState(() {
  //                           //   _selectedPriority = value;
  //                           // });
  //                         },
  //                       ),
  //                       const SizedBox(height: 8),
  //                       PriorityCard(
  //                         title: 'LT Gold',
  //                         discount: 'Скидка 10%',
  //                         price: '45 000 ₽/год',
  //                         features: const [
  //                           '+15 минут дополнительной репетиции на сцене во время театрального фестиваля.',
  //                           '+2 минуты на каждый номер во время хореографического конкурса.',
  //                           'Возврат 15% от стоимости трансфера (автобус от ж/д вокзала или аэропорта до отеля и обратно).',
  //                           'Возврат 15% от стоимости ж/д билетов и 10% от стоимости авиабилетов для руководителя коллектива в город проведения фестиваля и обратно.',
  //                         ],
  //                         value: PriorityLevel.gold,
  //                         groupValue: null,
  //                         //_selectedPriority,
  //                         onChanged: (value) {
  //                           // setState(() {
  //                           //   _selectedPriority = value;
  //                           // });
  //                         },
  //                       ),
  //                       const SizedBox(height: 8),
  //                       PriorityCard(
  //                         title: 'LT Platinum',
  //                         discount: 'Скидка 15%',
  //                         price: '59 900 ₽/год',
  //                         features: const [
  //                           '+20 минут дополнительной репетиции на сцене во время тетарального фестиваля.',
  //                           '+3 минуты на каждый номер во время хореографического конкурса.',
  //                           'Возврат 25% от стоимости трансфера (автобус от ж/д вокзала или аэропорта до отеля и обратно).',
  //                           'Возврат 25% от стоимости ж/д билетов и 15% от стоимости авиабилетов для руководителя коллектива в город проведения фестиваля и обратно.',
  //                           'Приоритет в выборе даты и времени показа спектакля/танцевального номера (до официального опубликования программы фестиваля).',
  //                         ],
  //                         value: PriorityLevel.platinum,
  //                         groupValue: null,
  //                         //_selectedPriority,
  //                         onChanged: (value) {
  //                           // setState(() {
  //                           //   _selectedPriority = value;
  //                           // });
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 16),
  //               // LTButtons.elevatedButton(
  //               //   onPressed: () {},
  //               //   child: Text("Выберите карту", style: Styles.button1),
  //               // ),
  //               // const SizedBox(height: 10),
  //               LTButtons.elevatedButton(
  //                 onPressed: () {
  //                   _launchUrl('https://ltfest.ru/priority');
  //                 },
  //                 foregroundColor: Palette.secondary,
  //                 backgroundColor: Palette.white,
  //                 child: Text("Подробнее на сайте",
  //                     style: Styles.button1.copyWith(color: Palette.secondary)),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showExitPopup(BuildContext context, WidgetRef ref) {
  //   showModalBottomSheet(
  //     useRootNavigator: true,
  //     context: context,
  //     backgroundColor: Palette.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: const EdgeInsets.all(16)
  //             .copyWith(bottom: 16 + MediaQuery.of(context).padding.bottom),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               width: 40,
  //               height: 4,
  //               decoration: BoxDecoration(
  //                   color: Palette.stroke,
  //                   borderRadius: BorderRadius.circular(2)),
  //             ),
  //             const SizedBox(height: 24),
  //             Text('Выход из аккаунта', style: Styles.h4),
  //             const SizedBox(height: 16),
  //             Text('Вы уверены, что хотите выйти из аккаунта?',
  //                 style: Styles.b2, textAlign: TextAlign.center),
  //             const SizedBox(height: 32),
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: LTButtons.elevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                       ref.read(authNotifierProvider.notifier).logout();
  //                     },
  //                     backgroundColor: Palette.error,
  //                     foregroundColor: Palette.white,
  //                     child: Text("Выйти", style: Styles.button1),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Expanded(
  //                   child: OutlinedButton(
  //                     onPressed: () => Navigator.pop(context),
  //                     style: OutlinedButton.styleFrom(
  //                       side: BorderSide(color: Palette.stroke),
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(12)),
  //                       padding: const EdgeInsets.symmetric(vertical: 14),
  //                     ),
  //                     child: Text("Отмена",
  //                         style: Styles.button1.copyWith(color: Palette.black)),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(user!.lastname.toString(), style: Styles.h3),
                      Text(user.activity!.title.toString(), style: Styles.b2),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4),
              child: ProfileCard(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  _ActionCard(
                    iconPath: 'assets/icons/social/tg.svg',
                    title: "LT Blog",
                    onTap: () {
                      launchUrl(Uri.parse('https://t.me/ltfest'),
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                  const SizedBox(width: 4),
                  _ActionCard(
                    iconPath: 'assets/icons/social/wa.svg',
                    title: "Связаться с нами",
                    onTap: () {
                      launchUrl(Uri.parse('https://t.me/ltfest'),
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: Decor.base,
                child: _MenuTile(
                  iconPath: 'assets/icons/news.svg',
                  title: "Новости LT Fest",
                  onTap: () {
                    context.push(AppRoutes.news);
                  },
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: Decor.base,
                child: _MenuTile(
                    iconPath: 'assets/icons/favourite.svg',
                    title: "Избранное СКОРО",
                    onTap: () {}
                    //{
                    //context.push(AppRoutes.favorites);
                    //},
                    ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: Decor.base,
                child: Column(
                  children: [
                    _MenuTile(
                      iconPath: 'assets/icons/shop.svg',
                      title: "LT Shop",
                      onTap: () {
                        context.push(AppRoutes.shop);
                      },
                    ),
                    _MenuTileCart(
                      iconPath: 'assets/icons/cart.svg',
                      title: "Корзина",
                      onTap: () {
                        context.push(AppRoutes.cart);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: Decor.base,
                child: Column(
                  children: [
                    _MenuTile(
                      iconPath: 'assets/icons/person.svg',
                      title: "Настройки аккаунта",
                      onTap: () {
                        context.push(AppRoutes.user);
                      },
                    ),
                    _MenuTile(
                      iconPath: 'assets/icons/settings.svg',
                      title: "Настройки приложения",
                      onTap: () {
                        context
                            .push(AppRoutes.settings);
                      },
                    ),
                    _MenuTile(
                      iconPath: 'assets/icons/info.svg',
                      title: "О приложении",
                      onTap: () {
                        context.push(AppRoutes.about);
                      },
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
}

enum PriorityLevel { silver, gold, platinum }

class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => context.push(AppRoutes.ltPriority),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
            color: Palette.primaryLime, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Text("LT Priority", style: Styles.h4.copyWith(color: Palette.white)),
            const Spacer(),
            Text("Подключить",
                style: Styles.button1.copyWith(color: Palette.white)),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/icons/arrow_right.svg',
                colorFilter: ColorFilter.mode(Palette.white, BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }
}

class PriorityCard extends StatelessWidget {
  final String title;
  final String discount;
  final String price;
  final List<String> features;
  final PriorityLevel value;
  final PriorityLevel? groupValue;
  final ValueChanged<PriorityLevel?> onChanged;

  const PriorityCard({
    super.key,
    required this.title,
    required this.discount,
    required this.price,
    required this.features,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // final bool isSelected = value == groupValue;
    // const Color selectedColor = Color(0xFFF9A825); // Оранжевый для выделения

    return InkWell(
      // Делаем всю карточку кликабельной
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Palette.stroke,
            // isSelected ? selectedColor.withOpacity(0.7) :
            width: 1.0, // isSelected ? 2.0 :
          ),
          // boxShadow: isSelected
          //     ? [
          //         BoxShadow(
          //           color: selectedColor.withOpacity(0.1),
          //           blurRadius: 8,
          //           offset: const Offset(0, 4),
          //         )
          //       ]
          //     : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Styles.h6,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      discount,
                      style: Styles.b2,
                    ),
                  ],
                ),
                // Radio<PriorityLevel>(
                //   value: value,
                //   groupValue: groupValue,
                //   onChanged: onChanged,
                //   activeColor: selectedColor,
                //   // Увеличим область нажатия для Radio
                //   materialTapTargetSize: MaterialTapTargetSize.padded,
                // ),
              ],
            ),
            const SizedBox(height: 20),
            // Список преимуществ
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    feature,
                    style: Styles.b2,
                  ),
                )),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Text(
                price,
                style: Styles.h3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const _ActionCard(
      {required this.iconPath, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: Decor.base,
          child: Column(
            children: [
              SvgPicture.asset(iconPath, height: 32, width: 32),
              const SizedBox(height: 8),
              Text(title, style: Styles.b2),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const _MenuTile(
      {required this.iconPath, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            SvgPicture.asset(iconPath,
                width: 20,
                colorFilter: ColorFilter.mode(Palette.black, BlendMode.srcIn)),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: Styles.b1)),
            SvgPicture.asset('assets/icons/arrow_right.svg'),
          ],
        ),
      ),
    );
  }
}

class _MenuTileCart extends ConsumerWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const _MenuTileCart(
      {required this.iconPath, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(cartTotalItemsProvider);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            SvgPicture.asset(iconPath,
                width: 20,
                colorFilter: ColorFilter.mode(Palette.black, BlendMode.srcIn)),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: Styles.b1)),
            if (count > 0)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Palette.primaryLime,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  count.toString(),
                  style: Styles.h5.copyWith(color: Palette.white),
                ),
              ),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/icons/arrow_right.svg'),
          ],
        ),
      ),
    );
  }
}
