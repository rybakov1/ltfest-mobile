import 'package:flutter/foundation.dart';
import 'package:ltfest/data/models/product/product.dart';
import 'package:ltfest/data/repositories/shop_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shop_provider.g.dart';

class ShopState {
  final List<Product> products;
  final bool hasMore;

  const ShopState({this.products = const [], this.hasMore = true});
}

@Riverpod(keepAlive: true)
class ProductsNotifier extends _$ProductsNotifier {
  int _currentPage = 1;
  bool _isLoadingMore = false;

  ShopRepository get _repo => ref.read(shopRepositoryProvider);

  @override
  Future<ShopState> build() async {
    _currentPage = 1;
    final products = await _repo.getProducts(page: 1);
    return ShopState(products: products, hasMore: products.length >= 20);
  }

  Future<void> fetchNextPage() async {
    final currentState = state.valueOrNull;
    if (currentState == null || _isLoadingMore || !currentState.hasMore) return;

    _isLoadingMore = true;
    try {
      _currentPage++;
      final newProducts = await _repo.getProducts(page: _currentPage);
      if (newProducts.isEmpty) {
        state = AsyncData(ShopState(
          products: currentState.products,
          hasMore: false,
        ));
      } else {
        state = AsyncData(ShopState(
          products: [...currentState.products, ...newProducts],
          hasMore: true,
        ));
      }
    } catch (e) {
      debugPrint('Error loading more products: $e');
    } finally {
      _isLoadingMore = false;
    }
  }
}

final productByIdProvider = FutureProvider.family<Product, String>(
  (ref, id) {
    final repo = ref.read(shopRepositoryProvider);
    return repo.getProductDetailsById(id);
  },
);
