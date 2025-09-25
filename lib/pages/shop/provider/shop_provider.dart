import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/product.dart';
import '../../../data/services/api_service.dart';

part 'shop_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductsNotifier extends _$ProductsNotifier {
  @override
  Future<List<Product>> build() async {
    final apiService = ref.read(apiServiceProvider);
    return await apiService.getProducts();
  }
}

final productByIdProvider = FutureProvider.family<Product, String>((ref, id) {
  return ref.read(apiServiceProvider).getProductById(id);
});