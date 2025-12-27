import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';
import 'package:shimmer/shimmer.dart';
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

    return products.when(
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
            mainAxisExtent: 256,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            final product = productList[index];
            String sizes = "";

            for (int i = 0; i < product.variations.length; i++) {
              sizes += product.variations[i].productSize.title;
            }

            return GestureDetector(
              onTap: () => context.push('${AppRoutes.shop}/${product.id}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: CachedNetworkImage(
                          imageUrl:
                          'http://37.46.132.144:1337${product.variations[0].images[0].url}',
                          height: 160,
                          memCacheHeight: (160 * MediaQuery.of(context).devicePixelRatio).round(),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Palette.shimmerBase,
                            highlightColor: Palette.shimmerHighlight,
                            child: Container(
                              height: 160,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                          ),
                          fadeInDuration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.b2.copyWith(color: Palette.gray),
                  ),
                  const Spacer(),
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
    );
  }
}
