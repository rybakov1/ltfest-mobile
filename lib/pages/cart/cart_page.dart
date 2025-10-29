import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/router/app_routes.dart';

import 'models/cart_item.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);
    final cartItems = ref.watch(cartItemsProvider);

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: LTAppBar(title: "Корзина LT Shop"),
            ),
            cartAsync.when(
              data: (cart) {
                if (cartItems.isEmpty) {
                  return SliverFillRemaining(
                    child: Container(
                      decoration: Decor.base,
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 12),
                      child: Column(
                        children: [
                          const Spacer(),
                          Image.asset("assets/icons/states/nothing.png",
                              width: 192),
                          const SizedBox(height: 20),
                          Text("В корзине пока пусто", style: Styles.b2),
                          const Spacer(),
                          LTButtons.elevatedButton(
                            onPressed: () => context.push(AppRoutes.shop),
                            child: Text("За покупками", style: Styles.button1),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  );
                }

                return SliverFillRemaining(
                  child: Stack(
                    children: [
                      ListView.builder(
                        padding:
                            const EdgeInsets.all(0.0).copyWith(bottom: 150),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          return CartItemCard(cartItemId: cartItem.id);
                        },
                      ),
                      const Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: CartSummary(),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => SliverFillRemaining(
                child: Container(
                  decoration: Decor.base,
                  margin: const EdgeInsets.all(4),
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
                  child: Column(
                    children: [
                      const Spacer(),
                      Image.asset("assets/icons/states/nothing.png",
                          width: 192),
                      const SizedBox(height: 20),
                      Text("В корзине пока пусто", style: Styles.b2),
                      const Spacer(),
                      LTButtons.elevatedButton(
                        onPressed: () => context.push(AppRoutes.shop),
                        child: const Text("За покупками"),
                      ),
                      SizedBox(
                          height: 12 + MediaQuery.of(context).padding.bottom),
                    ],
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

/// Виджет для отображения одного товара в корзине
class CartItemCard extends ConsumerWidget {
  final int cartItemId;

  const CartItemCard({super.key, required this.cartItemId});

  void _showItemMore(BuildContext context, CartItem cartItem, WidgetRef ref) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Container(
              height: 320,
              padding: EdgeInsets.only(
                  left: 16, right: 16, bottom: 24 + bottomPadding),
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
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Palette.primaryLime.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.favorite_outline,
                            color: Palette.primaryLime),
                      ),
                      const SizedBox(width: 16),
                      Text("Перенести в избранное", style: Styles.b1),
                    ],
                  ),
                  const SizedBox(height: 26),
                  InkWell(
                    onTap: () =>
                        ref.read(cartProvider.notifier).removeItem(cartItem.id),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Palette.error.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(8)),
                          child: SvgPicture.asset('assets/icons/trash.svg',
                              fit: BoxFit.scaleDown, width: 24, height: 24),
                        ),
                        const SizedBox(width: 16),
                        Text("Удалить из корзины", style: Styles.b1),
                      ],
                    ),
                  ),
                  const SizedBox(height: 68),
                  LTButtons.outlinedButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      "Закрыть",
                      style: Styles.button1,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItem = ref.watch(cartItemProvider(cartItemId));
    final isCartLoading =
        ref.watch(cartProvider.select((asyncCart) => asyncCart.isLoading));

    if (cartItem == null) {
      return const SizedBox.shrink();
    }

    final productStock = cartItem.productInStock!;

    return Container(
      decoration: Decor.base,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (productStock.images.isNotEmpty)
                  ? Image.network(
                      'http://37.46.132.144:1337${productStock.images.first.url}',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                  : Container(width: 80, height: 80, color: Palette.stroke),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          productStock.product!.name,
                          style: Styles.h4,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => _showItemMore(context, cartItem, ref),
                        child: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${productStock.productSize.title.split(' ')[1]} / ${productStock.productColor.title}',
                    style: Styles.b2.copyWith(color: Palette.gray),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(Utils.formatMoney(productStock.price),
                          style: Styles.h4),
                      const Spacer(),
                      IconButton(
                        icon: Icon(Icons.remove_circle,
                            size: 32, color: Palette.primaryLime),
                        onPressed: isCartLoading
                            ? null
                            : () {
                                ref
                                    .read(cartProvider.notifier)
                                    .updateItemQuantity(
                                        cartItem.id, cartItem.quantity - 1);
                              },
                      ),
                      Text('${cartItem.quantity}', style: Styles.h4),
                      IconButton(
                        icon: Icon(Icons.add_circle,
                            size: 32, color: Palette.primaryLime),
                        onPressed: isCartLoading
                            ? null
                            : () {
                                ref
                                    .read(cartProvider.notifier)
                                    .updateItemQuantity(
                                        cartItem.id, cartItem.quantity + 1);
                              },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartSummary extends ConsumerWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPrice = ref.watch(cartTotalPriceProvider);
    final isCartLoading =
        ref.watch(cartProvider.select((asyncCart) => asyncCart.isLoading));

    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 24, 20, MediaQuery.of(context).padding.bottom + 24),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Итого:', style: Styles.h4),
              isCartLoading
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: Palette.primaryLime,
                        ),
                      ),
                    )
                  : Text(Utils.formatMoney(totalPrice), style: Styles.h3),
            ],
          ),
          const SizedBox(height: 24),
          LTButtons.elevatedButton(
            onPressed: () => context.push(AppRoutes.order),
            child: Text(
              "Оформить заказ",
              style: Styles.button1,
            ),
          )
        ],
      ),
    );
  }
}
