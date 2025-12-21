import 'package:ltfest/data/models/product/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/services/api_service.dart';

part 'shop_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductsNotifier extends _$ProductsNotifier {
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  @override
  Future<List<Product>> build() async {
    _currentPage = 1;
    _hasMore = true;
    final apiService = ref.read(apiServiceProvider);
    return await apiService.getProductsForCatalog(page: _currentPage);
  }

  Future<void> fetchNextPage() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    final apiService = ref.read(apiServiceProvider);

    try {
      final nextPage = _currentPage + 1;
      final newProducts = await apiService.getProductsForCatalog(page: nextPage);

      if (newProducts.isEmpty) {
        _hasMore = false;
        // Принудительно обновляем состояние, чтобы убрать индикатор загрузки, если он был
        state = AsyncData(state.value ?? []);
      } else {
        _currentPage = nextPage;
        state = AsyncData([...state.value ?? [], ...newProducts]);
      }
    } catch (e, st) {
      print('Error loading more products: $e');
      // Опционально: state = AsyncError(e, st);
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
