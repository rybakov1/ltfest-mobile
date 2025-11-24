import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';
import '../../cart/models/cart_item.dart';
import '../../cart/provider/cart_provider.dart';
import '../provider/shop_provider.dart';

class ShopWithCartWidget extends ConsumerStatefulWidget {
  const ShopWithCartWidget({super.key});

  @override
  ConsumerState<ShopWithCartWidget> createState() => _ShopWithCartWidgetState();
}

class _ShopWithCartWidgetState extends ConsumerState<ShopWithCartWidget> {
  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsNotifierProvider);

    return productsAsync.when(
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
          padding: const EdgeInsets.only(bottom: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
            mainAxisExtent: 235,
          ),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            final product = productList[index];

            // Логика: для карточки в каталоге работаем с первой вариацией (дефолтной)
            // Если вариаций нет, товар нельзя купить через каталог
            final defaultVariation = product.variations.isNotEmpty
                ? product.variations[0]
                : null;

            String sizes = "";
            for (int i = 0; i < product.variations.length; i++) {
              sizes += product.variations[i].productSize.title;
              if (i < product.variations.length - 1) sizes += ", ";
            }

            return GestureDetector(
              onTap: () => context.push('${AppRoutes.shop}/${product.id}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // --- КАРТИНКА ТОВАРА ---
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        child: Image.network(
                          defaultVariation != null
                              ? 'http://37.46.132.144:1337${defaultVariation.images[0].url}'
                              : '',
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              height: 160,
                              width: double.infinity,
                              color: Colors.grey[100],
                              child: const Center(child: CircularProgressIndicator()),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 160,
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image, color: Colors.grey),
                            );
                          },
                        ),
                      ),

                      // --- КНОПКИ УПРАВЛЕНИЯ КОРЗИНОЙ ---
                      if (defaultVariation != null)
                        Positioned(
                          right: 8,
                          bottom: 8,
                          child: Consumer(
                            builder: (context, ref, child) {
                              final cartState = ref.watch(cartProvider);
                              final cartData = cartState.valueOrNull;
                              final isLoading = cartState.isLoading;

                              // Ищем, есть ли ЭТА вариация в корзине
                              CartItem? cartItem;
                              if (cartData != null && cartData.items.isNotEmpty) {
                                try {
                                  cartItem = cartData.items.firstWhere(
                                          (item) => item.productInStock?.id == defaultVariation.id
                                  );
                                } catch (_) {
                                  cartItem = null;
                                }
                              }

                              final quantity = cartItem?.quantity ?? 0;
                              final cartItemId = cartItem?.id;

                              // 1. Товар НЕ в корзине -> Кнопка [+]
                              if (quantity == 0) {
                                return InkWell(
                                  onTap: isLoading
                                      ? null
                                      : () {
                                    ref.read(cartProvider.notifier).addItem(defaultVariation.id);
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
                                    child: isLoading && cartState.hasValue // Показываем лоадер, если грузится, но не блокируем UI полностью
                                        ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                        : const Icon(Icons.add, size: 20, color: Colors.black),
                                  ),
                                );
                              }

                              // 2. Товар В корзине -> Панель [- Qty +]
                              else {
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
                                      // Кнопка Минус
                                      InkWell(
                                        onTap: (isLoading || cartItemId == null)
                                            ? null
                                            : () {
                                          // Уменьшаем на 1. Провайдер сам удалит, если станет 0.
                                          ref.read(cartProvider.notifier)
                                              .updateItemQuantity(cartItemId, quantity - 1);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Icon(Icons.remove, size: 18, color: isLoading ? Colors.grey : Colors.black),
                                        ),
                                      ),

                                      // Количество
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2),
                                        child: Text(
                                          '$quantity',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),

                                      // Кнопка Плюс
                                      InkWell(
                                        onTap: (isLoading || cartItemId == null)
                                            ? null
                                            : () {
                                          ref.read(cartProvider.notifier)
                                              .updateItemQuantity(cartItemId, quantity + 1);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Icon(Icons.add, size: 18, color: isLoading ? Colors.grey : Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    defaultVariation != null
                        ? Utils.formatMoney(defaultVariation.price.toInt())
                        : 'Нет цены',
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
        return Center(child: Text("Ошибка загрузки товаров: $error"));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}