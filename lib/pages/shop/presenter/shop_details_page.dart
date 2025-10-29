import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/pages/shop/provider/shop_provider.dart';
import '../../../components/favorite_button.dart';
import '../../../components/share_button.dart';
import '../../../data/models/product/product_attribute.dart';
import '../../../data/models/product/product_in_stock.dart';
import '../../../providers/favorites_provider.dart';
import '../../../router/app_routes.dart';
import '../../cart/models/cart_item.dart';
import '../../cart/provider/cart_provider.dart';

class ShopDetailsPage extends ConsumerStatefulWidget {
  final String id;

  const ShopDetailsPage({super.key, required this.id});

  @override
  ConsumerState<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends ConsumerState<ShopDetailsPage> {
  ProductColor? _selectedColor;
  ProductSize? _selectedSize;
  ProductInStock? _selectedVariation;

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
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Container(
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
                  Center(
                    child: Text('Цвет', style: Styles.h4),
                  ),
                  const SizedBox(height: 32),
                  for (int i = 0; i < productColors.length; i++)
                    Builder(
                      builder: (context) {
                        final isSelected =
                            _selectedVariation?.productColor.id ==
                                productColors[i].id;
                        final isAvailable = _isVariationAvailable(
                            variations,
                            productColors[i].id,
                            _selectedVariation?.productSize.id ??
                                variations.first.productSize.id);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: InkWell(
                            onTap: () {
                              modalSetState(() {
                                _selectedColor = productColors[i];
                              });
                              // Обновляем вариацию при выборе цвета
                              _updateSelectedVariation(variations,
                                  colorId: productColors[i].id);
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: hexToColor(productColors[i].hex!),
                                    border: isAvailable
                                        ? null
                                        : Border.all(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 1),
                                  ),
                                  child: !isAvailable
                                      ? Icon(
                                          Icons.close,
                                          size: 12,
                                          color: Colors.grey.withOpacity(0.7),
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  productColors[i].title,
                                  style: Styles.b1.copyWith(
                                    color: isAvailable
                                        ? Palette.black
                                        : Palette.black.withOpacity(0.5),
                                  ),
                                ),
                                const Spacer(),
                                if (isSelected)
                                  Icon(
                                    Icons.check,
                                    color: Palette.primaryLime,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 32),
                  LTButtons.elevatedButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      "Сохранить",
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

  void _updateSelectedVariation(List<ProductInStock> variations,
      {int? colorId, int? sizeId}) {
    final currentColorId = colorId ?? _selectedVariation?.productColor.id;
    final currentSizeId = sizeId ?? _selectedVariation?.productSize.id;

    // Ищем точное совпадение
    final newVariation = variations.firstWhere(
      (v) =>
          v.productColor.id == currentColorId &&
          v.productSize.id == currentSizeId,
      orElse: () {
        // Если комбинации нет в наличии, создаем "виртуальную" вариацию
        final colorVariation = variations.firstWhere(
          (v) => v.productColor.id == currentColorId,
          orElse: () => variations.first,
        );
        final sizeVariation = variations.firstWhere(
          (v) => v.productSize.id == currentSizeId,
          orElse: () => variations.first,
        );

        final color = colorVariation.productColor;
        final size = sizeVariation.productSize;

        return ProductInStock(
          id: -1,
          // Специальный ID для недоступных комбинаций
          price: variations.first.price,
          // Используем цену первой доступной вариации
          stockQuantity: 0,
          // Нет в наличии
          productColor: color,
          productSize: size,
          images: [], // Пустой список изображений для недоступных комбинаций
        );
      },
    );

    setState(() {
      _selectedVariation = newVariation;
      _selectedColor = newVariation.productColor;
      _selectedSize = newVariation.productSize;
    });
  }

  List<T> _getUniqueAttributes<T>(List<ProductInStock> variations,
      T Function(ProductInStock) getAttr, int Function(T) getId) {
    final uniqueIds = <int>{};
    final result = <T>[];
    for (final variation in variations) {
      final attr = getAttr(variation);
      if (uniqueIds.add(getId(attr))) {
        result.add(attr);
      }
    }
    return result;
  }

  // Получаем все уникальные цвета и размеры из всех вариаций (включая недоступные)
  List<ProductColor> _getAllUniqueColors(List<ProductInStock> variations) {
    return _getUniqueAttributes(variations, (v) => v.productColor, (c) => c.id);
  }

  List<ProductSize> _getAllUniqueSizes(List<ProductInStock> variations) {
    return _getUniqueAttributes(variations, (v) => v.productSize, (s) => s.id);
  }

  // Проверяем доступность комбинации цвета и размера
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

  // Получаем доступную вариацию или null если недоступна
  ProductInStock? _getAvailableVariation(
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
    return variation.stockQuantity > 0 ? variation : null;
  }

  @override
  Widget build(BuildContext context) {
    final productDetailsAsync = ref.watch(productByIdProvider(widget.id));
    final cartAsync = ref.watch(cartProvider);
    return Scaffold(
      backgroundColor: Palette.background,
      body: productDetailsAsync.when(
        data: (product) {
          final variations = product.variations;

          // Инициализируем выбранную вариацию при первой загрузке
          if (_selectedVariation == null && variations.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                // Ищем первую вариацию с изображениями, если есть
                ProductInStock initialVariation = variations.firstWhere(
                  (v) => v.images.isNotEmpty,
                  orElse: () => variations.first,
                );

                setState(() {
                  _selectedVariation = initialVariation;
                  _selectedColor = initialVariation.productColor;
                  _selectedSize = initialVariation.productSize;
                });
              }
            });
          }

          // Если данные загрузились, а _selectedVariation еще не установлен, показываем загрузку
          if (_selectedVariation == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final cart = cartAsync.valueOrNull;
          CartItem? currentCartItem;
          if (cart != null) {
            for (final item in cart.items) {
              if (item.productInStock?.id == _selectedVariation!.id) {
                currentCartItem = item;
                break; // Нашли, выходим из цикла
              }
            }
          }

          final uniqueSizes = _getAllUniqueSizes(variations);
          final uniqueColors = _getAllUniqueColors(variations);

          return Stack(
            children: [
              SingleChildScrollView(
                child: Stack(
                  children: [
                    _selectedVariation!.images.isNotEmpty
                        ? Image.network(
                            "http://37.46.132.144:1337${_selectedVariation!.images[0].url}",
                            height: 360,
                            fit: BoxFit.cover,
                            // Можно добавить fade-in анимацию при смене картинки
                          )
                        : Container(
                            height: 360,
                            color: Colors.grey.withOpacity(0.3),
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
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
                              vertical: 20,
                              horizontal: 12,
                            ),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name, style: Styles.h3),
                                const SizedBox(height: 8),
                                Text(
                                    Utils.formatMoney(
                                        _selectedVariation!.price.toInt()),
                                    style: Styles.h4),
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
                                          final isSelected = _selectedVariation
                                                  ?.productSize.id ==
                                              sizeItem.id;
                                          final isAvailable =
                                              _isVariationAvailable(
                                                  variations,
                                                  _selectedVariation
                                                          ?.productColor.id ??
                                                      variations.first
                                                          .productColor.id,
                                                  sizeItem.id);

                                          return InkWell(
                                            onTap: () {
                                              _updateSelectedVariation(
                                                  variations,
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
                                                      ? Palette.primaryLime
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                      color: isSelected
                                                          ? Palette.primaryLime
                                                          : isAvailable
                                                              ? Palette.stroke
                                                              : Palette.stroke
                                                                  .withOpacity(
                                                                      0.3)),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Text(
                                                sizeItem.title,
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Palette.white
                                                      : isAvailable
                                                          ? Palette.black
                                                          : Palette.black
                                                              .withOpacity(0.5),
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
                                                  _selectedVariation!
                                                      .productColor.hex!),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            _selectedVariation!
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
                                const Divider(),
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
                                const Divider(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 82),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CartBottomBar(
                  selectedVariation: _selectedVariation!,
                  cartItem: currentCartItem,
                  isLoading: cartAsync.isLoading, // Передаем состояние загрузки
                  isAvailable: _selectedVariation!.stockQuantity > 0,
                ),
              ),
            ],
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
    final bool isInCart = cartItem != null;
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isLoading
            ? const Center(heightFactor: 1, child: CircularProgressIndicator())
            : !isAvailable
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Center(
                      child: Text(
                        'Нет в наличии',
                        style: Styles.button1.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
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
                              ref
                                  .read(cartProvider.notifier)
                                  .updateItemQuantity(
                                      cartItem!.id, cartItem!.quantity - 1);
                            },
                          ),
                          const SizedBox(width: 10),
                          Text('${cartItem!.quantity}', style: Styles.h4),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.add_circle,
                                size: 32, color: Palette.primaryLime),
                            onPressed: () {
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
                              child: Text('В корзину', style: Styles.button1),
                            ),
                          ),
                        ],
                      ),
      ),
    );
  }
}
