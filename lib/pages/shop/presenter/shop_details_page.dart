import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/pages/shop/provider/shop_provider.dart';

import '../../../components/favorite_button.dart';
import '../../../components/share_button.dart';
import '../../../providers/favorites_provider.dart';

class ShopDetailsPage extends ConsumerStatefulWidget {
  final String id;

  const ShopDetailsPage({super.key, required this.id});

  @override
  ConsumerState<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends ConsumerState<ShopDetailsPage> {
  Color hexToColor(String hexColorString) {
    // Remove the '#' if present
    String formattedHex = hexColorString.replaceAll("#", "");

    // Prepend '0xFF' for full opacity if alpha is not included
    if (formattedHex.length == 6) {
      formattedHex = "FF" + formattedHex;
    }

    // Parse the hex string to an integer
    int hexValue = int.parse(formattedHex, radix: 16);

    // Create and return the Color object
    return Color(hexValue);
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(productByIdProvider(widget.id));

    return Scaffold(
      backgroundColor: Palette.background,
      body: product.when(
        data: (product) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Image.network(
                  "http://37.46.132.144:1337${product.images![0].url}",
                  height: 360,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                width: 43,
                                height: 43,
                                color: Palette.primaryLime,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Palette.white,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    context.pop();
                                  },
                                ),
                              ),
                            ),
                            const Spacer(),
                            ShareButton(
                              link: "https://ltfest.ru",
                              color: Palette.primaryLime,
                            ),
                            const SizedBox(width: 8),
                            FavoriteButtonDetails(
                              id: 1,
                              eventType: EventType.laboratory,
                              color: Palette.primaryLime,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: 270 - MediaQuery.of(context).padding.top),
                      Container(
                        decoration: Decor.base,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 12,
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title!, style: Styles.h3),
                            const SizedBox(height: 8),
                            Text(Utils.formatMoney(product.price!),
                                style: Styles.h4),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        decoration: Decor.base,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 12),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Выберите размер", style: Styles.b3),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              children: [
                                for (int i = 0;
                                    i < product.productSizes!.length;
                                    i++)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Palette.stroke),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Text(
                                      product.productSizes![i].title!,
                                    ),
                                  )
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text("Цвет", style: Styles.b3),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Palette.stroke),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButton(
                                menuWidth: double.infinity, //TODO: ?
                                items: [
                                  for (int i = 0;
                                      i < product.productColors!.length;
                                      i++)
                                    DropdownMenuItem(
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: hexToColor(product
                                                  .productColors![i].hex!),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            product.productColors![i].title!,
                                            style: Styles.b2,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                                onChanged: null,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text("О товаре", style: Styles.h4),
                            const SizedBox(height: 16),
                            Text(product.description!, style: Styles.b2),
                            const SizedBox(height: 16),
                            Text("Характеристики", style: Styles.h4),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 36,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Материал",
                                    style: Styles.b2,
                                  ),
                                  Text(
                                    product.productMaterial![0].title!,
                                    style: Styles.b2,
                                  )
                                ],
                              ),
                            ),
                            const Divider(),
                            SizedBox(
                              height: 36,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Артикул",
                                    style: Styles.b2,
                                  ),
                                  Text(
                                    product.article!,
                                    style: Styles.b2,
                                  )
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 98),
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    decoration: Decor.base,
                    child: LTButtons.elevatedButton(
                        onPressed: () {},
                        child: const Text("Добавить к корзину")),
                  ),
                ),
              ],
            ),
          );
        },
        error: (_, st) {
          return Text("This is error, $st");
        },
        loading: () {
          return Text("loading.......");
        },
      ),
    );
  }
}
