import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pages/cart/models/cart.dart';
import '../api/api_client.dart';
import '../models/product/product.dart';
import '../models/product/product_in_stock.dart';
import '../services/api_exception.dart';

final shopRepositoryProvider = Provider<ShopRepository>((ref) {
  return ShopRepository(ref.watch(apiClientProvider));
});

class ShopRepository with ApiErrorHandler {
  final ApiClient _client;

  ShopRepository(this._client);

  // ── Products ──

  Future<List<Product>> getProducts({int page = 1, int pageSize = 20}) async {
    try {
      final res = await _client.getProducts({
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
        'populate[0]': 'product_in_stocks',
        'populate[1]': 'product_in_stocks.product_color',
        'populate[2]': 'product_in_stocks.product_size',
        'populate[3]': 'product_in_stocks.images',
        'populate[4]': 'product_materials',
      });
      final response = res.data;

      final dynamic rawData = response['data'];
      if (rawData == null || rawData is! List) return [];

      return rawData
          .map((json) {
            if (json == null) return null;
            try {
              return Product.fromJson(json as Map<String, dynamic>);
            } catch (e) {
              debugPrint('Error parsing product: $e');
              return null;
            }
          })
          .whereType<Product>()
          .toList();
    } catch (e) {
      handleError(e);
    }
  }

  Future<Product> getProductDetailsById(String id) async {
    try {
      final res = await _client.getProducts({
        'filters[id][\$eq]': id,
        'populate[0]': 'product_in_stocks',
        'populate[1]': 'product_in_stocks.product_color',
        'populate[2]': 'product_in_stocks.product_size',
        'populate[3]': 'product_in_stocks.images',
        'populate[4]': 'product_materials',
      });
      final response = res.data;
      final List<dynamic> dataList = response['data'];
      if (dataList.isEmpty) {
        throw ApiException(message: 'Product with id $id not found');
      }
      return Product.fromJson(dataList.first as Map<String, dynamic>);
    } catch (e) {
      handleError(e);
    }
  }

  Future<List<ProductInStock>> getAllVariations() async {
    try {
      final res = await _client.getProductInStocks({'populate': '*'});
      final response = res.data;
      final List<dynamic> data = response['data'];
      return data
          .map((json) => ProductInStock.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> updateProductInStockQuantity({
    required String documentId,
    required int newQuantity,
  }) async {
    try {
      await _client.updateProductInStock(documentId, {
        'data': {'quantity': newQuantity},
      });
    } catch (e) {
      handleError(e);
    }
  }

  // ── Cart ──

  Future<Cart> getMyCart() async {
    try {
      final response = await _client.getMyCart({'populate': '*'});
      return Cart.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> addToCart({required int productInStockId, int quantity = 1}) async {
    try {
      await _client.addCartItem({
        'data': {'product_in_stock': productInStockId, 'quantity': quantity},
      });
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> updateCartItemQuantity({
    required int cartItemId,
    required int newQuantity,
  }) async {
    try {
      await _client.updateCartItem(cartItemId, {'quantity': newQuantity});
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> removeCartItem({required int cartItemId}) async {
    try {
      await _client.removeCartItem(cartItemId);
    } catch (e) {
      handleError(e);
    }
  }
}
