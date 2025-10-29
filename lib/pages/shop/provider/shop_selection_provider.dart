// provider/product_selection_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/pages/shop/provider/shop_provider.dart';
import '../../../data/models/product/product_in_stock.dart';
import '../../../data/models/product/product_attribute.dart';

/// Состояние, которое хранит все, что раньше было в `_ShopDetailsPageState`
class ProductSelectionState {
  final ProductInStock? selectedVariation;
  final ProductColor? selectedColor;
  final ProductSize? selectedSize;

  const ProductSelectionState({
    this.selectedVariation,
    this.selectedColor,
    this.selectedSize,
  });

  ProductSelectionState copyWith({
    ProductInStock? selectedVariation,
    ProductColor? selectedColor,
    ProductSize? selectedSize,
  }) {
    return ProductSelectionState(
      selectedVariation: selectedVariation ?? this.selectedVariation,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }
}

class ProductSelectionNotifier extends StateNotifier<ProductSelectionState> {

  final Ref ref;
  final String productId;

  ProductSelectionNotifier(this.ref, this.productId) : super(const ProductSelectionState());

  /// Устанавливает начальное состояние, как это делал `addPostFrameCallback`
  void setInitial(ProductInStock initialVariation) {
    state = ProductSelectionState(
      selectedVariation: initialVariation,
      selectedColor: initialVariation.productColor,
      selectedSize: initialVariation.productSize,
    );
  }

  /// ТОЧНАЯ КОПИЯ ВАШЕГО МЕТОДА _updateSelectedVariation
  void updateSelection({int? colorId, int? sizeId}) {
    final productData = ref.read(productByIdProvider(productId)).valueOrNull;
    if (productData == null) return; // Защита, если данные еще не загружены

    final variations = productData.variations;
    final currentColorId = colorId ?? state.selectedVariation?.productColor.id;
    final currentSizeId = sizeId ?? state.selectedVariation?.productSize.id;

    // Этот блок логики скопирован 1 в 1 из вашего виджета
    final newVariation = variations.firstWhere(
          (v) =>
      v.productColor.id == currentColorId &&
          v.productSize.id == currentSizeId,
      orElse: () {
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

        // Создаем "поддельную" вариацию, если комбинация не найдена
        return ProductInStock(
          id: -1,
          price: variations.first.price,
          stockQuantity: 0,
          productColor: color,
          productSize: size,
          images: [], // Используем пустой массив, чтобы избежать ошибок
        );
      },
    );

    // Вместо setState, мы просто обновляем состояние notifier'а
    state = state.copyWith(
      selectedVariation: newVariation,
      selectedColor: newVariation.productColor,
      selectedSize: newVariation.productSize,
    );
  }
}

final productSelectionProvider =
StateNotifierProvider.family<ProductSelectionNotifier, ProductSelectionState, String>(
      (ref, productId) => ProductSelectionNotifier(ref, productId),
);

// ПРОВАЙДЕРЫ-СЕЛЕКТОРЫ для уникальных атрибутов
final uniqueProductColorsProvider = Provider.family<List<ProductColor>, String>((ref, productId) {
  final product = ref.watch(productByIdProvider(productId)).valueOrNull;
  if (product == null) return [];

  final uniqueIds = <int>{};
  final result = <ProductColor>[];
  for (final variation in product.variations) {
    if (uniqueIds.add(variation.productColor.id)) {
      result.add(variation.productColor);
    }
  }
  return result;
});

final uniqueProductSizesProvider = Provider.family<List<ProductSize>, String>((ref, productId) {
  final product = ref.watch(productByIdProvider(productId)).valueOrNull;
  if (product == null) return [];

  final uniqueIds = <int>{};
  final result = <ProductSize>[];
  for (final variation in product.variations) {
    if (uniqueIds.add(variation.productSize.id)) {
      result.add(variation.productSize);
    }
  }
  return result;
});