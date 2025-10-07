import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';

import '../provider/shop_provider.dart';

class ShopWidget extends ConsumerStatefulWidget {
  const ShopWidget({super.key});

  @override
  ConsumerState<ShopWidget> createState() => _ShopWidgetState();
}

class _ShopWidgetState extends ConsumerState<ShopWidget> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsNotifierProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("LT Shop", style: Styles.h3),
            GestureDetector(
              onTap: () => context.push(AppRoutes.shop),
              child: Text(
                "Все",
                style: Styles.b2.copyWith(color: Palette.secondary),
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        products.when(
          data: (productList) {
            if (productList.isEmpty) {
              return Center(
                child: Text(
                  'Продукты не найдены',
                  style: Styles.b1,
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 16,
                mainAxisExtent: 235,
              ),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                String sizes = "";

                for (int i = 0; i < product.variations.length; i++) {
                  sizes += product.variations[i].productSize.title;
                }

                return GestureDetector(
                  onTap: () =>
                      context.push('${AppRoutes.shop}/${product.id}'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'http://37.46.132.144:1337${product.variations[0].images[0].url}',
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : const Center(
                                          child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 160,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.broken_image,
                                        color: Colors.grey),
                                  );
                                },
                              )),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Utils.formatMoney(
                          product.variations[0].price.toInt(),
                        ),
                        style: Styles.h5,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.name,
                        style: Styles.b2.copyWith(
                          color: Palette.gray,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        sizes,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.b3,
                      ),
                    ],
                  ),
                );
              },
            );
          },
          error: (error, stacktrace) {
            print("===================");
            print("This is error, $error");
            print("===================");
            print("This is stacktrace, $stacktrace");
            print("===================");
            return Text("This is error, $stacktrace");
          },
          loading: () {
            return Text("loading.......");
          },
        ),
      ],
    );
  }
}
