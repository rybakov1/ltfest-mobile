import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/components/banner_carousel.dart';
import 'package:ltfest/pages/shop/provider/shop_provider.dart';
import 'package:ltfest/providers/laboratory_provider.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';

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
        ref.read(laboratoriesProvider).valueOrNull?.searchQuery ?? '';
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

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 24, bottom: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "LT Shop",
                        style: Styles.h4.copyWith(color: Palette.black),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 43,
                        width: 43,
                        decoration:
                            Decor.base.copyWith(color: Palette.primaryLime),
                        child: IconButton(
                          onPressed: () => context.pop(),
                          icon: Icon(Icons.arrow_back, color: Palette.white),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 43,
                        width: 43,
                        decoration:
                            Decor.base.copyWith(color: Palette.primaryLime),
                        child: IconButton(
                          onPressed: () => context.pop(),
                          icon: Icon(Icons.shopping_cart_outlined,
                              color: Palette.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      style: Styles.b2,
                      controller: _searchController,
                      onChanged: (query) {
                        ref
                            .read(laboratoriesProvider.notifier)
                            .setSearchQuery(query);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Palette.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Palette.stroke, width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Palette.stroke, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Palette.primaryLime, width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Palette.error, width: 1)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Palette.error, width: 1)),
                        hintText: "Поиск",
                        hintStyle: Styles.b2,
                        contentPadding: const EdgeInsets.only(
                            left: 16, top: 13, bottom: 13),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const BannerCarousel(),
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
                                    String sizes = "";

                                    for (var i = 0;
                                        i < product.productSizes!.length;
                                        i++) {
                                      sizes +=
                                          "${product.productSizes![i].title!} ";
                                    }

                                    return GestureDetector(
                                      onTap: () => context.push(
                                          '${AppRoutes.shop}/${product.id}'),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.network(
                                                  'http://37.46.132.144:1337${product.images![0].url}',
                                                  height: 196,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            Utils.formatMoney(
                                              product.price!.toInt(),
                                            ),
                                            style: Styles.h5,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            product.title!,
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
                              error: (_, st) {
                                print(st);
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
