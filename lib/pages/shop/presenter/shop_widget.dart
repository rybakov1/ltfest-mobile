import 'dart:math';
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
  int _visibleCount = 4;
  final int _incrementCount = 4;
  bool _isBtnLoading = false;

  @override
  Widget build(BuildContext context) {
    final shopStateAsync = ref.watch(productsNotifierProvider);

    return shopStateAsync.when(
      data: (shopState) {
        final productList = shopState.products;

        if (productList.isEmpty) {
          return Center(child: Text('Продукты не найдены', style: Styles.b1));
        }

        final currentDisplayCount = min(_visibleCount, productList.length);
        final bool showButton =
            (_visibleCount < productList.length) || shopState.hasMore;

        return Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 16,
                mainAxisExtent: 256,
              ),
              itemCount: currentDisplayCount,
              itemBuilder: (context, index) {
                final product = productList[index];
                String sizes = "";
                if (product.variations.isNotEmpty) {
                  for (var v in product.variations) {
                    sizes += "${v.productSize.title} ";
                  }
                }
                final firstVariation = product.variations.isNotEmpty
                    ? product.variations[0]
                    : null;
                final imageUrl = (firstVariation != null &&
                        firstVariation.images.isNotEmpty)
                    ? 'http://37.46.132.144:1337${firstVariation.images[0].url}'
                    : '';
                final price = firstVariation?.price.toInt() ?? 0;

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
                              imageUrl: imageUrl,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              memCacheHeight: (160 *
                                      MediaQuery.of(context).devicePixelRatio)
                                  .round(),
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Palette.shimmerBase,
                                highlightColor: Palette.shimmerHighlight,
                                child:
                                    Container(height: 160, color: Colors.white),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 160,
                                color: Colors.grey[200],
                                child: const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(Utils.formatMoney(price), style: Styles.h5),
                      const SizedBox(height: 4),
                      Text(product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.b2.copyWith(color: Palette.gray)),
                      const Spacer(),
                      const SizedBox(height: 4),
                      Text(sizes,
                          overflow: TextOverflow.ellipsis, style: Styles.b3),
                    ],
                  ),
                );
              },
            ),
            if (showButton) ...[
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: LTButtons.elevatedButton(
                  onPressed: _isBtnLoading
                      ? null
                      : () async {
                          if (_visibleCount < productList.length) {
                            setState(() {
                              _visibleCount += _incrementCount;
                            });
                          } else {
                            setState(() {
                              _isBtnLoading = true;
                            });

                            await ref
                                .read(productsNotifierProvider.notifier)
                                .fetchNextPage();

                            if (mounted) {
                              setState(() {
                                _isBtnLoading = false;
                                _visibleCount += _incrementCount;
                              });
                            }
                          }
                        },
                  child: _isBtnLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : Text("Посмотреть все",
                          style: Styles.b1.copyWith(color: Colors.white)),
                ),
              ),
            ],
          ],
        );
      },
      error: (error, stacktrace) => _buildShimmerLoading(),
      loading: () => _buildShimmerLoading(),
    );
  }

  // Shimmer метод тот же самый, что и был
  Widget _buildShimmerLoading() {
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
        return Shimmer.fromColors(
          baseColor: Palette.shimmerBase,
          highlightColor: Palette.shimmerHighlight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 160,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12))),
              const SizedBox(height: 8),
              Container(height: 20, width: 80, color: Colors.white),
              const SizedBox(height: 4),
              Container(
                  height: 16, width: double.infinity, color: Colors.white),
              const SizedBox(height: 4),
              Container(height: 16, width: 100, color: Colors.white),
              const Spacer(),
              Container(height: 14, width: 50, color: Colors.white),
            ],
          ),
        );
      },
    );
  }
}
