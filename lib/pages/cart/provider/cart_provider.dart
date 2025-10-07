import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/services/api_service.dart';

import '../models/cart.dart';

final cartProvider =
    AsyncNotifierProvider<CartNotifier, Cart>(() => CartNotifier());

final cartTotalItemsProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider).valueOrNull;
  if (cart == null || cart.items.isEmpty) return 0;

  return cart.items.fold(0, (total, current) => total + current.quantity);
});

final cartTotalPriceProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider).valueOrNull;
  if (cart == null || cart.items.isEmpty) return 0;

  return cart.items.fold(
      0,
      (total, current) =>
          total + current.productInStock!.price * current.quantity);
});

extension CartHelpers on Cart {
  int get totalItems =>
      items.fold(0, (total, current) => total + current.quantity);

  double get totalPrice => items.fold(
      0.0,
      (total, current) =>
          total + (current.productInStock!.price * current.quantity));
}

class CartNotifier extends AsyncNotifier<Cart> {
  late final ApiService _apiService = ref.read(apiServiceProvider);

  @override
  Future<Cart> build() async {
    // Просто получаем корзину с сервера
    return _apiService.getMyCart();
  }

  /// Добавляет товар в корзину.
  Future<void> addItem(int productInStockId) async {
    // Устанавливаем состояние загрузки, сохраняя предыдущие данные для плавного UI
    state = const AsyncValue.loading();

    try {
      await _apiService.addToCart(productInStockId: productInStockId);
      // После успешного добавления, инвалидируем провайдер.
      // Это заставит Riverpod заново вызвать build() и получить свежую корзину с сервера.
      // Это самый простой и надежный способ синхронизации.
      ref.invalidateSelf();
    } catch (e, st) {
      // В случае ошибки, возвращаем предыдущее состояние
      state = AsyncValue.error(e, st);
    }
  }

  /// Обновляет количество товара или удаляет его, если количество <= 0.
  Future<void> updateItemQuantity(int cartItemId, int newQuantity) async {
    state = const AsyncValue.loading();

    try {
      if (newQuantity > 0) {
        await _apiService.updateCartItemQuantity(
            cartItemId: cartItemId, newQuantity: newQuantity);
      } else {
        // Если количество 0 или меньше, удаляем товар
        await _apiService.removeCartItem(cartItemId: cartItemId);
      }
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Полностью удаляет товар из корзины.
  Future<void> removeItem(int cartItemId) async {
    state = const AsyncValue.loading();
    try {
      await _apiService.removeCartItem(cartItemId: cartItemId);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Полностью очищает корзину.
  Future<void> clearCart() async {
    final currentCart = state.valueOrNull;
    if (currentCart == null || currentCart.items.isEmpty) return;

    state = const AsyncValue.loading();
    try {
      // Отправляем запросы на удаление для каждого элемента в корзине
      final futures = currentCart.items
          .map((item) => _apiService.removeCartItem(cartItemId: item.id));
      await Future.wait(futures); // Ждем завершения всех запросов

      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
