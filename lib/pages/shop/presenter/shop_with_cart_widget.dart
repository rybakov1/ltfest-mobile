import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';
import '../../cart/models/cart_item.dart';
import '../../cart/provider/cart_provider.dart';
import '../provider/shop_catalog_provider.dart';

class ShopWithCartWidget extends ConsumerStatefulWidget {
  const ShopWithCartWidget({super.key});

  @override
  ConsumerState<ShopWithCartWidget> createState() => _ShopWithCartWidgetState();
}

class _ShopWithCartWidgetState extends ConsumerState<ShopWithCartWidget> {
  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(shopCatalogProvider);

    return catalogAsync.when(
      data: (catalogState) {
        final groups = catalogState.groups;
        if (groups.isEmpty) {
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
          padding: const EdgeInsets.only(bottom: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
            mainAxisExtent: 235,
          ),
          itemCount: groups.length,
          itemBuilder: (context, index) {
            final group = groups[index];
            final product = group.product;

            return GestureDetector(
              onTap: () => context.push(
                  '${AppRoutes.shop}/${product.id}?colorId=${group.color.id}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Image.network(
                          group.imageUrl,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              height: 160,
                              width: double.infinity,
                              color: Colors.grey[100],
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 160,
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image,
                                  color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final cartState = ref.watch(cartProvider);
                            final cartData = cartState.valueOrNull;
                            final isLoading = cartState.isLoading;

                            CartItem? cartItem;
                            if (cartData != null && cartData.items.isNotEmpty) {
                              try {
                                cartItem = cartData.items.firstWhere(
                                  (item) =>
                                      item.productInStock?.id ==
                                      group.defaultVariationId,
                                );
                              } catch (_) {
                                cartItem = null;
                              }
                            }

                            final quantity = cartItem?.quantity ?? 0;
                            final cartItemId = cartItem?.id;

                            if (quantity == 0) {
                              return InkWell(
                                onTap: isLoading
                                    ? null
                                    : () {
                                        ref
                                            .read(cartProvider.notifier)
                                            .addItem(group.defaultVariationId);
                                      },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: isLoading && cartState.hasValue
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        )
                                      : const Icon(Icons.add,
                                          size: 20, color: Colors.black),
                                ),
                              );
                            }

                            return Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: (isLoading || cartItemId == null)
                                        ? null
                                        : () {
                                            ref
                                                .read(cartProvider.notifier)
                                                .updateItemQuantity(
                                                    cartItemId, quantity - 1);
                                          },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(
                                        Icons.remove,
                                        size: 18,
                                        color: isLoading
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: Text(
                                      '$quantity',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (isLoading || cartItemId == null)
                                        ? null
                                        : () {
                                            ref
                                                .read(cartProvider.notifier)
                                                .updateItemQuantity(
                                                    cartItemId, quantity + 1);
                                          },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: isLoading
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Utils.formatMoney(group.minPrice),
                    style: Styles.h5,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.b2.copyWith(
                      color: Palette.gray,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    group.subtitle,
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
        return Center(child: Text("Ошибка загрузки товаров: $error"));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
