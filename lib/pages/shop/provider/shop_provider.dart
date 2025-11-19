import 'package:ltfest/data/models/product/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/services/api_service.dart';

part 'shop_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductsNotifier extends _$ProductsNotifier {
  @override
  Future<List<Product>> build() async {
    final apiService = ref.read(apiServiceProvider);
    return await apiService.getProductsForCatalog();
  }
}

final productByIdProvider = FutureProvider.family<Product, String>((ref, id) {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getProductDetailsById(id);
});