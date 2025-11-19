import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/image_data.dart';
import 'package:ltfest/pages/shop/provider/shop_provider.dart';
import '../../../components/favorite_button.dart';
import '../../../components/share_button.dart';
import '../../../data/models/product/product.dart';
import '../../../data/models/product/product_attribute.dart';
import '../../../data/models/product/product_in_stock.dart';
import '../../../providers/favorites_provider.dart';
import '../../../router/app_routes.dart';
import '../../cart/models/cart_item.dart';
import '../../cart/provider/cart_provider.dart';
import '../provider/shop_selection_provider.dart';

final carouselPageIndexProvider =
    StateProvider.family.autoDispose<int, int>((ref, productVariationId) {
  return 0; // Начальная страница всегда 0
});

class ShopDetailsPage extends ConsumerStatefulWidget {
  final String id;

  const ShopDetailsPage({super.key, required this.id});

  @override
  ConsumerState<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends ConsumerState<ShopDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showHeader = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 150 && !_showHeader) {
        setState(() => _showHeader = true);
      } else if (_scrollController.offset <= 150 && _showHeader) {
        setState(() => _showHeader = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showColorPicker(BuildContext context, List<ProductColor> productColors,
      List<ProductInStock> variations) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (BuildContext context) {
        return Consumer(
          builder: (context, ref, child) {
            final selectionState =
                ref.watch(productSelectionProvider(widget.id));
            final selectedVariation = selectionState.selectedVariation;

            return Container(
              height: 400,
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
                  const SizedBox(height: 16),
                  Center(child: Text('Цвет', style: Styles.h4)),
                  const SizedBox(height: 32),
                  for (final color in productColors)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () {
                          ref
                              .read(
                                  productSelectionProvider(widget.id).notifier)
                              .updateSelection(colorId: color.id);
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: hexToColor(color.hex!),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              color.title,
                              style: Styles.b1.copyWith(color: Palette.black),
                            ),
                            const Spacer(),
                            if (selectedVariation?.productColor.id == color.id)
                              Icon(
                                Icons.check_circle,
                                color: Palette.primaryLime,
                              ),
                          ],
                        ),
                      ),
                    ),
                  const Spacer(),
                  LTButtons.elevatedButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      "Применить",
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

  Color hexToColor(String hexColorString) {
    String formattedHex = hexColorString.replaceAll("#", "");
    if (formattedHex.length == 6) {
      formattedHex = "FF$formattedHex";
    }
    int hexValue = int.parse(formattedHex, radix: 16);
    return Color(hexValue);
  }

  bool _isVariationAvailable(
      List<ProductInStock> variations, int colorId, int sizeId) {
    final variation = variations.firstWhere(
      (v) => v.productColor.id == colorId && v.productSize.id == sizeId,
      orElse: () => ProductInStock(
        id: -1,
        price: 0,
        stockQuantity: 0,
        productColor: ProductColor(id: colorId, title: ''),
        productSize: ProductSize(id: sizeId, title: ''),
      ),
    );
    return variation.stockQuantity > 0;
  }

  @override
  Widget build(BuildContext context) {
    final productDetailsAsync = ref.watch(productByIdProvider(widget.id));
    final cartAsync = ref.watch(cartProvider);

    final selectionState = ref.watch(productSelectionProvider(widget.id));
    final selectedVariation = selectionState.selectedVariation;

    ref.listen<AsyncValue<Product>>(productByIdProvider(widget.id),
        (previous, next) {
      if (!next.isLoading && next.hasValue && selectedVariation == null) {
        final variations = next.value!.variations;
        if (variations.isNotEmpty) {
          ProductInStock initialVariation = variations.firstWhere(
            (v) => v.images.isNotEmpty,
            orElse: () => variations.first,
          );
          ref
              .read(productSelectionProvider(widget.id).notifier)
              .setInitial(initialVariation);
        }
      }
    });

    return Scaffold(
      backgroundColor: Palette.background,
      body: productDetailsAsync.when(
        data: (product) {
          if (selectedVariation == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final cart = cartAsync.valueOrNull;
          CartItem? currentCartItem;
          if (cart != null) {
            for (final item in cart.items) {
              if (item.productInStock?.id == selectedVariation.id) {
                currentCartItem = item;
                break;
              }
            }
          }

          final uniqueSizes = ref.watch(uniqueProductSizesProvider(widget.id));
          final uniqueColors =
              ref.watch(uniqueProductColorsProvider(widget.id));
          final variations = product.variations;

          return Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Stack(
                  children: [
                    selectedVariation.images.isNotEmpty
                        ? ProductImageCarousel(
                            images: selectedVariation.images,
                            productVariationId: selectedVariation.id,
                          )
                        : Container(
                            height: 360,
                            color: Colors.grey.withAlpha(77),
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 64,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                    SafeArea(
                      child: Column(
                        children: [
                          LTAppBar(
                            postfixWidget: Row(
                              children: [
                                ShareButton(
                                  link: "https://ltfest.ru",
                                  color: Palette.primaryLime,
                                ),
                                const SizedBox(width: 8),
                                FavoriteButton(
                                  size: 40,
                                  type: EventType.product,
                                  color: Palette.primaryLime,
                                  id: product.id,
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
                                vertical: 20, horizontal: 12),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name, style: Styles.h3),
                                const SizedBox(height: 8),
                                Text(
                                  Utils.formatMoney(
                                    selectedVariation.price.toInt(),
                                  ),
                                  style: Styles.h4,
                                ),
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
                                  runSpacing: 8,
                                  children: [
                                    for (final sizeItem in uniqueSizes)
                                      Builder(
                                        builder: (context) {
                                          final isSelected = selectedVariation
                                                  .productSize.id ==
                                              sizeItem.id;
                                          final isAvailable =
                                              _isVariationAvailable(
                                                  variations,
                                                  selectedVariation
                                                      .productColor.id,
                                                  sizeItem.id);

                                          return InkWell(
                                            onTap: () {
                                              ref
                                                  .read(
                                                      productSelectionProvider(
                                                              widget.id)
                                                          .notifier)
                                                  .updateSelection(
                                                      sizeId: sizeItem.id);
                                            },
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? isAvailable
                                                          ? Palette.primaryLime
                                                          : Palette.background
                                                      : isAvailable
                                                          ? Palette.white
                                                          : Palette.background,
                                                  border: Border.all(
                                                    width: isSelected ? 2 : 1,
                                                    color: isSelected
                                                        ? Palette.primaryLime
                                                        : isAvailable
                                                            ? Palette.stroke
                                                            : Palette
                                                                .background,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Text(
                                                sizeItem.title,
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? isAvailable
                                                          ? Palette.white
                                                          : Palette.gray
                                                      : isAvailable
                                                          ? Palette.black
                                                          : Palette.gray,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text("Цвет", style: Styles.b3),
                                const SizedBox(height: 16),
                                if (uniqueColors.isNotEmpty)
                                  GestureDetector(
                                    onTap: () => _showColorPicker(
                                        context, uniqueColors, variations),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Palette.stroke),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: hexToColor(
                                                  selectedVariation
                                                      .productColor.hex!),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            selectedVariation
                                                .productColor.title,
                                            style: Styles.b2,
                                          ),
                                        ],
                                      ),
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
                                        product.productMaterials[0].title,
                                        style: Styles.b2,
                                      )
                                    ],
                                  ),
                                ),
                                Divider(color: Palette.stroke),
                                SizedBox(
                                  height: 36,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                Divider(color: Palette.stroke),
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  76 + MediaQuery.of(context).padding.bottom),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: AnimatedOpacity(
                  opacity: _showHeader ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Palette.background,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: LTAppBar(
                      postfixWidget: Row(
                        children: [
                          ShareButton(
                            link: "https://ltfest.ru",
                            color: Palette.primaryLime,
                          ),
                          const SizedBox(width: 8),
                          FavoriteButton(
                            size: 40,
                            type: EventType.product,
                            color: Palette.primaryLime,
                            id: product.id,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CartBottomBar(
                  selectedVariation: selectedVariation,
                  cartItem: currentCartItem,
                  isLoading: cartAsync.isLoading,
                  isAvailable: selectedVariation.stockQuantity > 0,
                ),
              ),
            ],
          );
        },
        error: (_, st) {
          debugPrint(st.toString());
          return Text("This is error, $st");
        },
        loading: () {
          return const Text("loading.......");
        },
      ),
    );
  }
}

/// Виджет для нижней панели с кнопками управления корзиной.
class CartBottomBar extends ConsumerWidget {
  const CartBottomBar({
    super.key,
    required this.selectedVariation,
    this.cartItem,
    required this.isLoading,
    required this.isAvailable,
  });

  final ProductInStock selectedVariation;
  final CartItem? cartItem;
  final bool isLoading;
  final bool isAvailable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isAvailableQuantity = true;

    if(cartItem != null) {
      final productStock = cartItem!.productInStock!;

      if (cartItem!.quantity >= productStock.stockQuantity) {
        isAvailableQuantity = false;
      }
    }

    final bool isInCart = cartItem != null;
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 24, 16, MediaQuery.of(context).padding.bottom + 24),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: !isAvailable
            ? Column(
                children: [
                  // Text(
                  //   "Нет в наличии",
                  //   style: Styles.b2.copyWith(color: Palette.gray),
                  // ),
                  // TODO: Notification
                  // const SizedBox(height: 12),
                  // LTButtons.outlinedButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     "Сообщить об поступлении",
                  //     style: Styles.button1,
                  //   ),
                  // )
                  LTButtons.outlinedButton(
                    onPressed: null,
                    disabledBackgroundColor: Palette.white,
                    disabledForegroundColor: const Color(0xFF9D9D9D),
                    child: Text(
                      "Нет в наличии",
                      style: Styles.button1,
                    ),
                  )
                ],
              )
            : !isInCart
                ? LTButtons.elevatedButton(
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .addItem(selectedVariation.id);
                    },
                    child: Text(
                      'Добавить в корзину',
                      style: Styles.button1,
                    ),
                  )
                : Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle,
                            size: 32, color: Palette.primaryLime),
                        onPressed: () {
                          ref.read(cartProvider.notifier).updateItemQuantity(
                              cartItem!.id, cartItem!.quantity - 1);
                        },
                      ),
                      const SizedBox(width: 10),
                      Text('${cartItem!.quantity}', style: Styles.h4),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          size: 32,
                          color: !isAvailableQuantity
                              ? Palette.stroke
                              : Palette.primaryLime,
                        ),
                        onPressed: !isAvailableQuantity
                            ? null
                            : () {
                                ref
                                    .read(cartProvider.notifier)
                                    .updateItemQuantity(
                                        cartItem!.id, cartItem!.quantity + 1);
                              },
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: LTButtons.elevatedButton(
                          onPressed: () {
                            context.push(AppRoutes.cart);
                          },
                          child: isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(),
                                )
                              : Text('В корзину', style: Styles.button1),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class ProductImageCarousel extends ConsumerWidget {
  final List<ImageData> images;
  final int productVariationId;

  const ProductImageCarousel(
      {super.key, required this.images, required this.productVariationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage =
        ref.watch(carouselPageIndexProvider(productVariationId));

    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: images.length,
            // onPageChanged обновляет состояние провайдера при свайпе
            onPageChanged: (page) {
              ref
                  .read(carouselPageIndexProvider(productVariationId).notifier)
                  .state = page;
            },
            itemBuilder: (context, index) {
              final imageUrl = "http://37.46.132.144:1337${images[index].url}";
              return Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child:
                        Icon(Icons.error_outline, color: Colors.grey, size: 48),
                  );
                },
              );
            },
          ),
          if (images.length > 1)
            Positioned(
              bottom: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: currentPage == index ? 16 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Palette.black
                          : Palette.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
