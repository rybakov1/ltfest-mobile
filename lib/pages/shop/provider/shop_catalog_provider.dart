import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/product/product.dart';
import 'package:ltfest/data/models/product/product_attribute.dart';
import 'package:ltfest/data/models/product/product_in_stock.dart';
import 'package:ltfest/data/services/api_endpoints.dart';

import 'shop_provider.dart';

class ShopCatalogViewState {
  final List<ShopColorGroup> groups;
  final bool hasMore;

  const ShopCatalogViewState({required this.groups, required this.hasMore});
}

class ShopColorGroup {
  final Product product;
  final ProductColor color;
  final List<ProductInStock> variations;
  final int minPrice;
  final String subtitle;
  final String imageUrl;
  final int defaultVariationId;

  const ShopColorGroup({
    required this.product,
    required this.color,
    required this.variations,
    required this.minPrice,
    required this.subtitle,
    required this.imageUrl,
    required this.defaultVariationId,
  });
}

final shopCatalogProvider = Provider<AsyncValue<ShopCatalogViewState>>((ref) {
  final asyncShop = ref.watch(productsNotifierProvider);
  return asyncShop.whenData((state) {
    final groups = _groupProductsByColor(state.products);
    return ShopCatalogViewState(groups: groups, hasMore: state.hasMore);
  });
});

List<ShopColorGroup> _groupProductsByColor(List<Product> products) {
  final result = <ShopColorGroup>[];

  for (final product in products) {
    if (product.variations.isEmpty) continue;

    final map = <int, List<ProductInStock>>{};
    final colors = <int, ProductColor>{};

    for (final variation in product.variations) {
      map.putIfAbsent(variation.productColor.id, () => []).add(variation);
      colors[variation.productColor.id] = variation.productColor;
    }

    final entries = map.entries.toList()
      ..sort((a, b) {
        final at = colors[a.key]?.title ?? '';
        final bt = colors[b.key]?.title ?? '';
        return at.compareTo(bt);
      });

    for (final entry in entries) {
      final variations = entry.value;
      if (variations.isEmpty) continue;

      final color = colors[entry.key] ?? variations.first.productColor;
      final minPrice = variations.map((v) => v.price).reduce(min);
      final sizes =
          variations.map((v) => v.productSize.title).toSet().join(', ');
      final subtitle = sizes;

      final imageVariation = variations.firstWhere(
        (v) => v.images.isNotEmpty,
        orElse: () => variations.first,
      );
      final imageUrl = imageVariation.images.isNotEmpty
          ? '${ApiEndpoints.baseStrapiUrl}${imageVariation.images.first.url}'
          : '';

      final defaultVariationId = _pickDefaultVariationId(variations);

      result.add(
        ShopColorGroup(
          product: product,
          color: color,
          variations: variations,
          minPrice: minPrice,
          subtitle: subtitle,
          imageUrl: imageUrl,
          defaultVariationId: defaultVariationId,
        ),
      );
    }
  }

  return result;
}

int _pickDefaultVariationId(List<ProductInStock> variations) {
  final inStock = variations.where((v) => v.stockQuantity > 0).toList();
  final source = inStock.isNotEmpty ? inStock : variations;
  source.sort((a, b) => a.price.compareTo(b.price));
  return source.first.id;
}
