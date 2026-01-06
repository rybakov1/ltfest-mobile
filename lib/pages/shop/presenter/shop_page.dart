import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:shimmer/shimmer.dart';

import '../../../data/models/product/product.dart';

class ShopPage extends ConsumerStatefulWidget {
  const ShopPage({super.key});

  @override
  ConsumerState<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends ConsumerState<ShopPage> {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    final initialQuery =
        ref.read(laboratoriesNotifierProvider).valueOrNull?.searchQuery ?? '';
    _searchController = TextEditingController(text: initialQuery);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(productsNotifierProvider.notifier).fetchNextPage();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildShimmerProductCard() {
    return Shimmer.fromColors(
      baseColor: Palette.shimmerBase,
      highlightColor: Palette.shimmerHighlight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 196,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 20,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 16,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 14,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsNotifierProvider);
    final cartIsNotEmpty = ref.watch(cartTotalItemsProvider);

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 100.0,
                  floating: true,
                  pinned: false,
                  snap: true,
                  backgroundColor: Palette.background,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Builder(builder: (innerContext) {
                      return Container(
                        color: Palette.background,
                        child: LTAppBar(
                          title: "LT Shop",
                          postfixWidget: Container(
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
                      );
                    }),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: products.when(
                      data: (productList) {
                        if (productList.products.isEmpty) {
                          return const Center(child: Text('Товары не найдены'));
                        }

                        return Column(
                          children: [
                            const SizedBox(height: 24),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              // GridView внутри скролла не должен скроллиться сам
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 16,
                                mainAxisExtent: 292,
                              ),
                              itemCount: productList.products.length,
                              itemBuilder: (context, index) {
                                return ProductCard(product: productList.products[index]);
                              },
                            ),
                            if (products.isLoading)
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                      error: (err, st) => Text("Error: $err"),
                      loading: () => _buildShimmerGrid(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
        mainAxisExtent: 288,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildShimmerProductCard(),
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
                child: CachedNetworkImage(
                  imageUrl:
                      'http://37.46.132.144:1337${firstVariation.images.first.url}',
                  height: 196,
                  memCacheHeight:
                      (196 * MediaQuery.of(context).devicePixelRatio).round(),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Palette.shimmerBase,
                    highlightColor: Palette.shimmerHighlight,
                    child: Container(
                      height: 196,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  fadeInDuration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  fit: BoxFit.cover,
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
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
