import 'package:ltfest/data/models/product/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/services/api_service.dart';

part 'shop_provider.g.dart';

class ShopState {
  final List<Product> products;
  final bool hasMore;

  ShopState({
    required this.products,
    required this.hasMore,
  });

  ShopState copyWith({List<Product>? products, bool? hasMore}) {
    return ShopState(
      products: products ?? this.products,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

@Riverpod(keepAlive: true)
class ProductsNotifier extends _$ProductsNotifier {
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  Future<ShopState> build() async {
    _currentPage = 1;
    _isLoadingMore = false;

    final apiService = ref.read(apiServiceProvider);
    final products = await apiService.getProductsForCatalog(page: _currentPage);

    return ShopState(products: products, hasMore: products.isNotEmpty);
  }

  Future<void> fetchNextPage() async {
    final currentState = state.value;
    if (currentState == null || _isLoadingMore || !currentState.hasMore) return;

    _isLoadingMore = true;
    final apiService = ref.read(apiServiceProvider);

    try {
      final nextPage = _currentPage + 1;
      final newProducts = await apiService.getProductsForCatalog(page: nextPage);

      if (newProducts.isEmpty) {
        state = AsyncData(currentState.copyWith(hasMore: false));
      } else {
        _currentPage = nextPage;
        state = AsyncData(ShopState(
          products: [...currentState.products, ...newProducts],
          hasMore: true,
        ));
      }
    } catch (e) {
      print('Error loading more products: $e');
    } finally {
      _isLoadingMore = false;
    }
  }
}

final productByIdProvider = FutureProvider.family<Product, String>(
      (ref, id) {
    final apiService = ref.watch(apiServiceProvider);
    return apiService.getProductDetailsById(id);
  },
);