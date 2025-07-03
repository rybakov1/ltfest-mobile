import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/providers/festival_provider.dart';
import 'package:ltfest/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/jury.dart';

class FestivalDetailPage extends ConsumerWidget {
  final String id;

  const FestivalDetailPage({super.key, required this.id});

  void _showPriceInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 41,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Palette.stroke,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text('Информация о тарифах', style: Styles.h4),
              ),
              const SizedBox(height: 32),
              Text(
                'Стоимость зависит от выбранного тарифа. Чтобы ознакомиться с тарифами, просмотрите положение мероприятия.',
                style: Styles.b2,
              ),
              const SizedBox(height: 32),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Palette.stroke,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Закрыть",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Palette.primaryLime,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "Положение",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showJuryInfo(BuildContext context, Jury jury) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 41,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Palette.stroke,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text('Состав жюри', style: Styles.h4),
              ),
              const SizedBox(height: 32),
              Text("${jury.firstname} ${jury.lastname}", style: Styles.h3),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/jury_placeholder.png',
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(jury.description ?? 'Описание отсутствует'),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Palette.black,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Закрыть",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final festivalAsync = ref.watch(festivalByIdProvider(id));

    return Scaffold(
      backgroundColor: Palette.black,
      body: SafeArea(
        child: Stack(
          children: [
            festivalAsync.when(
              data: (festival) => SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          child: Image.asset(
                            'assets/images/teatr_placeholder.png',
                            height: 393,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: Container(
                                        width: 43,
                                        height: 43,
                                        color: const Color.fromRGBO(
                                            142, 142, 142, 1),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Palette.white,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            context.pop();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 300),
                              Container(
                                width: double.infinity,
                                decoration: Decor.base,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        festival.title,
                                        style: Styles.h3,
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Text(
                                            "от ${festival.price} ₽/чел",
                                            style: Styles.h4
                                                .copyWith(color: Palette.gray),
                                          ),
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () =>
                                                _showPriceInfo(context),
                                            child: SvgPicture.asset(
                                                'assets/icons/info.svg'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/calendar.svg'),
                                          const SizedBox(width: 12),
                                          Text(festival.date, style: Styles.b2),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/map_point.svg'),
                                          const SizedBox(width: 12),
                                          Text(
                                            festival.address ?? 'Не указано',
                                            style: Styles.b2,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: Decor.base,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Описание",
                                        style: Styles.h4,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        festival.description ??
                                            'Описание отсутствует',
                                        style: Styles.b2,
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Palette.black,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Подробнее в положении",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        "Жюри",
                                        style: Styles.h4,
                                      ),
                                      const SizedBox(height: 16),
                                      if (festival.jury.isEmpty)
                                        Text(
                                          "Информация о жюри отсутствует",
                                          style: TextStyle(color: Palette.gray),
                                        )
                                      else
                                        Row(
                                          children: [
                                            ...festival.jury
                                                .expand(
                                                  (jury) => [
                                                    Flexible(
                                                      child: InkWell(
                                                        onTap: () =>
                                                            _showJuryInfo(
                                                                context, jury),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/jury_placeholder.png',
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 12),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${jury.firstname}\n${jury.lastname}',
                                                                    style:
                                                                        Styles
                                                                            .h4,
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          4),
                                                                  Text(
                                                                    'Подробнее',
                                                                    style: Styles
                                                                        .b3
                                                                        .copyWith(
                                                                            color:
                                                                                Palette.secondary),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                  ],
                                                )
                                                .toList()
                                              ..removeLast(),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 96),
                  ],
                ),
              ),
              loading: () => const SingleChildScrollView(),
              error: (error, stack) => Container(),

              // loading: () => initialFestivalData != null
              //     ? SingleChildScrollView(
              //   child: Column(
              //     children: [
              //       Stack(
              //         children: [
              //           ClipRRect(
              //             borderRadius: const BorderRadius.only(
              //               bottomLeft: Radius.circular(12),
              //               bottomRight: Radius.circular(12),
              //             ),
              //             child: Image.asset(
              //               'assets/images/teatr_placeholder.png',
              //               height: 393,
              //               width: double.infinity,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           Padding(
              //             padding:
              //             const EdgeInsets.symmetric(horizontal: 4.0),
              //             child: Column(
              //               children: [
              //                 Row(
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.all(12.0),
              //                       child: ClipRRect(
              //                         borderRadius:
              //                         const BorderRadius.all(
              //                             Radius.circular(12)),
              //                         child: Container(
              //                           width: 43,
              //                           height: 43,
              //                           color: const Color.fromRGBO(
              //                               142, 142, 142, 1),
              //                           child: IconButton(
              //                             icon: Icon(
              //                               Icons.arrow_back,
              //                               color: Palette.white,
              //                               size: 18,
              //                             ),
              //                             onPressed: () {
              //                               context.go('/fest');
              //                             },
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 const SizedBox(height: 300),
              //                 Container(
              //                   width: double.infinity,
              //                   decoration: Decor.base,
              //                   child: Padding(
              //                     padding: const EdgeInsets.symmetric(
              //                         horizontal: 12.0, vertical: 20),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                       CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           initialFestivalData.title,
              //                           style: Styles.h3,
              //                         ),
              //                         const SizedBox(height: 12),
              //                         Row(
              //                           children: [
              //                             Text(
              //                               "от ${initialFestivalData.price} ₽/чел",
              //                               style: Styles.h4.copyWith(
              //                                   color: Palette.gray),
              //                             ),
              //                             const SizedBox(width: 8),
              //                             GestureDetector(
              //                               onTap: () =>
              //                                   _showPriceInfo(context),
              //                               child: SvgPicture.asset(
              //                                   'assets/icons/info.svg'),
              //                             ),
              //                           ],
              //                         ),
              //                         const SizedBox(height: 24),
              //                         Row(
              //                           children: [
              //                             SvgPicture.asset(
              //                                 'assets/icons/calendar.svg'),
              //                             const SizedBox(width: 12),
              //                             Text(initialFestivalData.date,
              //                                 style: Styles.b2),
              //                           ],
              //                         ),
              //                         const SizedBox(height: 16),
              //                         Row(
              //                           children: [
              //                             SvgPicture.asset(
              //                                 'assets/icons/map_point.svg'),
              //                             const SizedBox(width: 12),
              //                             Text(
              //                               initialFestivalData.address ??
              //                                   'Не указано',
              //                               style: Styles.b2,
              //                             ),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Container(
              //                   width: double.infinity,
              //                   decoration: Decor.base,
              //                   child: Padding(
              //                     padding: const EdgeInsets.symmetric(
              //                         horizontal: 12.0, vertical: 20),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                       CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           "Описание",
              //                           style: Styles.h4,
              //                         ),
              //                         const SizedBox(height: 16),
              //                         Text(
              //                           initialFestivalData.description ??
              //                               'Описание отсутствует',
              //                           style: Styles.b2,
              //                         ),
              //                         const SizedBox(height: 16),
              //                         Container(
              //                           width: double.infinity,
              //                           padding: const EdgeInsets.symmetric(
              //                               vertical: 12),
              //                           decoration: BoxDecoration(
              //                             borderRadius:
              //                             BorderRadius.circular(8),
              //                             border: Border.all(
              //                               color: Palette.black,
              //                             ),
              //                           ),
              //                           child: const Center(
              //                             child: Text(
              //                               "Подробнее в положении",
              //                               style: TextStyle(
              //                                 fontWeight: FontWeight.w500,
              //                                 fontSize: 16,
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         const SizedBox(height: 24),
              //                         Text(
              //                           "Жюри",
              //                           style: Styles.h4,
              //                         ),
              //                         const SizedBox(height: 16),
              //                         Text(
              //                           "Загрузка информации о жюри...",
              //                           style: TextStyle(
              //                               color: Palette.gray),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 const SizedBox(height: 96),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // )
              //     : Center(
              //     child: CircularProgressIndicator(color: Palette.primary)),
              // error: (error, stack) => SingleChildScrollView(
              //   child: Column(
              //     children: [
              //       Stack(
              //         children: [
              //           ClipRRect(
              //             borderRadius: const BorderRadius.only(
              //               bottomLeft: Radius.circular(12),
              //               bottomRight: Radius.circular(12),
              //             ),
              //             child: Image.asset(
              //               'assets/images/teatr_placeholder.png',
              //               height: 393,
              //               width: double.infinity,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           Padding(
              //             padding:
              //             const EdgeInsets.symmetric(horizontal: 4.0),
              //             child: Column(
              //               children: [
              //                 Row(
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.all(12.0),
              //                       child: ClipRRect(
              //                         borderRadius: const BorderRadius.all(
              //                             Radius.circular(12)),
              //                         child: Container(
              //                           width: 43,
              //                           height: 43,
              //                           color: const Color.fromRGBO(
              //                               142, 142, 142, 1),
              //                           child: IconButton(
              //                             icon: Icon(
              //                               Icons.arrow_back,
              //                               color: Palette.white,
              //                               size: 18,
              //                             ),
              //                             onPressed: () {
              //                               context.go('/fest');
              //                             },
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 const SizedBox(height: 300),
              //                 Container(
              //                   width: double.infinity,
              //                   decoration: Decor.base,
              //                   child: Padding(
              //                     padding: const EdgeInsets.symmetric(
              //                         horizontal: 12.0, vertical: 20),
              //                     child: Column(
              //                       crossAxisAlignment:
              //                       CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           initialFestivalData?.title ??
              //                               'Ошибка загрузки',
              //                           style: Styles.h3,
              //                         ),
              //                         const SizedBox(height: 12),
              //                         Text(
              //                           'Ошибка: $error',
              //                           style: Styles.b2
              //                               .copyWith(color: Palette.gray),
              //                         ),
              //                         if (initialFestivalData != null) ...[
              //                           const SizedBox(height: 24),
              //                           Row(
              //                             children: [
              //                               Text(
              //                                 "от ${initialFestivalData.price} ₽/чел",
              //                                 style: Styles.h4.copyWith(
              //                                     color: Palette.gray),
              //                               ),
              //                               const SizedBox(width: 8),
              //                               GestureDetector(
              //                                 onTap: () =>
              //                                     _showPriceInfo(context),
              //                                 child: SvgPicture.asset(
              //                                     'assets/icons/info.svg'),
              //                               ),
              //                             ],
              //                           ),
              //                           const SizedBox(height: 24),
              //                           Row(
              //                             children: [
              //                               SvgPicture.asset(
              //                                   'assets/icons/calendar.svg'),
              //                               const SizedBox(width: 12),
              //                               Text(initialFestivalData.date,
              //                                   style: Styles.b2),
              //                             ],
              //                           ),
              //                           const SizedBox(height: 16),
              //                           Row(
              //                             children: [
              //                               SvgPicture.asset(
              //                                   'assets/icons/map_point.svg'),
              //                               const SizedBox(width: 12),
              //                               Text(
              //                                 initialFestivalData.address ??
              //                                     'Не указано',
              //                                 style: Styles.b2,
              //                               ),
              //                             ],
              //                           ),
              //                         ],
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 if (initialFestivalData != null)
              //                   Container(
              //                     width: double.infinity,
              //                     decoration: Decor.base,
              //                     child: Padding(
              //                       padding: const EdgeInsets.symmetric(
              //                           horizontal: 12.0, vertical: 20),
              //                       child: Column(
              //                         crossAxisAlignment:
              //                         CrossAxisAlignment.start,
              //                         children: [
              //                           Text(
              //                             "Описание",
              //                             style: Styles.h4,
              //                           ),
              //                           const SizedBox(height: 16),
              //                           Text(
              //                             initialFestivalData.description ??
              //                                 'Описание отсутствует',
              //                             style: Styles.b2,
              //                           ),
              //                           const SizedBox(height: 16),
              //                           Container(
              //                             width: double.infinity,
              //                             padding: const EdgeInsets.symmetric(
              //                                 vertical: 12),
              //                             decoration: BoxDecoration(
              //                               borderRadius:
              //                               BorderRadius.circular(8),
              //                               border: Border.all(
              //                                 color: Palette.black,
              //                               ),
              //                             ),
              //                             child: const Center(
              //                               child: Text(
              //                                 "Подробнее в положении",
              //                                 style: TextStyle(
              //                                   fontWeight: FontWeight.w500,
              //                                   fontSize: 16,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                           const SizedBox(height: 24),
              //                           Text(
              //                             "Жюри",
              //                             style: Styles.h4,
              //                           ),
              //                           const SizedBox(height: 16),
              //                           Text(
              //                             "Информация о жюри отсутствует",
              //                             style: TextStyle(
              //                                 color: Palette.gray),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 const SizedBox(height: 96),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //       ElevatedButton(
              //         onPressed: () => ref.refresh(festivalByIdProvider(id)),
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Palette.primary,
              //           foregroundColor: Palette.black,
              //         ),
              //         child: const Text('Попробовать снова'),
              //       ),
              //     ],
              //   ),
              // ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).padding.bottom,
              child: Container(
                height: 92,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Palette.white,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: GestureDetector(
                  onTap: () async {
                    final Uri uri = Uri.parse(
                      'https://ltfest.artpro.art/webapp/public/application/af419d70-ec8d-42fb-a4b1-65482dcd3236',
                    );
                    await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Palette.primaryLime,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Заявка на участие",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Palette.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
