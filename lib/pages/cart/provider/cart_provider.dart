import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/services/api_service.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';

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
    state = const AsyncValue<Cart>.loading().copyWithPrevious(state);

    try {
      await _apiService.addToCart(productInStockId: productInStockId);
      // После успешного добавления, инвалидируем провайдер.
      // Это заставит Riverpod заново вызвать build() и получить свежую корзину с сервера.
      // Это самый простой и надежный способ синхронизации.
      ref.invalidateSelf();
    } catch (e, st) {
      // В случае ошибки, возвращаем предыдущее состояние
      state = AsyncValue<Cart>.error(e, st).copyWithPrevious(state);
    }
  }

  /// Обновляет количество товара или удаляет его, если количество <= 0.
  Future<void> updateItemQuantity(int cartItemId, int newQuantity) async {
    state = const AsyncValue<Cart>.loading().copyWithPrevious(state);

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
      state = AsyncValue<Cart>.error(e, st).copyWithPrevious(state);
    }
  }

  /// Полностью удаляет товар из корзины.
  Future<void> removeItem(int cartItemId) async {
    state = const AsyncValue<Cart>.loading().copyWithPrevious(state);
    try {
      await _apiService.removeCartItem(cartItemId: cartItemId);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue<Cart>.error(e, st).copyWithPrevious(state);
    }
  }

  /// Полностью очищает корзину.
  Future<void> clearCart() async {
    final currentCart = state.valueOrNull;
    if (currentCart == null || currentCart.items.isEmpty) return;

    state = const AsyncValue<Cart>.loading().copyWithPrevious(state);
    try {
      // Отправляем запросы на удаление для каждого элемента в корзине
      final futures = currentCart.items
          .map((item) => _apiService.removeCartItem(cartItemId: item.id));
      await Future.wait(futures); // Ждем завершения всех запросов

      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue<Cart>.error(e, st).copyWithPrevious(state);
    }
  }
}

final cartItemsProvider = Provider<List<CartItem>>((ref) {
  // Мы следим за cartProvider, и если он меняется,
  // этот провайдер вернет обновленный список товаров.
  return ref.watch(cartProvider).valueOrNull?.items ?? [];
});

/// Провайдер, который по ID возвращает ОДИН конкретный товар.
/// Каждая карточка товара (CartItemCard) будет следить за своим таким провайдером.
final cartItemProvider = Provider.family<CartItem?, int>((ref, cartItemId) {
  final items = ref.watch(cartItemsProvider);
  // Ищем в списке нужный товар.
  try {
    return items.firstWhere((item) => item.id == cartItemId);
  } catch (e) {
    return null; // Возвращаем null, если товар был удален
  }
});
