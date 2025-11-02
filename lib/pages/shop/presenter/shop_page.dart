import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/components/favorite_button.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/pages/shop/provider/shop_provider.dart';
import 'package:ltfest/providers/favorites_provider.dart';
import 'package:ltfest/providers/laboratory_provider.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';

import '../../../data/models/product/product.dart';

class ShopPage extends ConsumerStatefulWidget {
  const ShopPage({super.key});

  @override
  ConsumerState<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends ConsumerState<ShopPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    final initialQuery =
        ref.read(laboratoriesNotifierProvider).valueOrNull?.searchQuery ?? '';
    _searchController = TextEditingController(text: initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsNotifierProvider);
    final cartIsNotEmpty = ref.watch(cartTotalItemsProvider);

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: LTAppBar(
                title: "LT Shop",
                postfixWidget:

                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Palette.primaryLime,
                  ),
                  child: IconButton(
                    onPressed: () => context.push(AppRoutes.cart),
                    icon: Icon(
                      cartIsNotEmpty > 0
                          ? Icons.shopping_cart
                          : Icons.shopping_cart_outlined,
                      color: Palette.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // TODO: const BannerCarousel(),
                            const SizedBox(height: 24),
                            products.when(
                              data: (productList) {
                                if (productList.isEmpty) {
                                  return const Center(
                                      child: Text('Товары не найдены'));
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 16,
                                    mainAxisExtent: 288,
                                  ),
                                  itemCount: productList.length,
                                  itemBuilder: (context, index) {
                                    final product = productList[index];
                                    return ProductCard(product: product);
                                  },
                                );
                              },
                              error: (_, st) {
                                return Text("This is error, $st");
                              },
                              loading: () {
                                return Text("loading.......");
                              },
                            ),
                          ],
                        ),
                      ),
                    )
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

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    if (product.variations.isEmpty) {
      return const SizedBox.shrink();
    }

    final firstVariation = product.variations.first;
    final minPrice = product.variations.map((v) => v.price).reduce(min);
    final availableSizes =
        product.variations.map((v) => v.productSize.title).toSet().join(', ');

    return GestureDetector(
      onTap: () => context.push('${AppRoutes.shop}/${product.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: (firstVariation.images.isNotEmpty)
                    ? Image.network(
                        'http://37.46.132.144:1337${firstVariation.images.first.url}',
                        height: 196,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      )
                    : Container(
                        height: 196,
                        color: Palette.stroke,
                        child: const Center(
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FavoriteButton(
                    id: product.id,
                    type: EventType.product,
                    color: const Color(0x8E8A8A80),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            Utils.formatMoney(minPrice),
            style: Styles.h5,
          ),
          const SizedBox(height: 4),
          Text(
            product.name,
            style: Styles.b2.copyWith(color: Palette.gray),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          if (availableSizes.isNotEmpty)
            Text(
              availableSizes,
              overflow: TextOverflow.ellipsis,
              style: Styles.b3,
            ),
        ],
      ),
    );
  }
}
