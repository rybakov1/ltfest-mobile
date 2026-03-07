import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/shop_repository.dart';
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
  late final ShopRepository _repo = ref.read(shopRepositoryProvider);

  @override
  Future<Cart> build() async {
    return _repo.getMyCart();
  }

  Future<void> addItem(int productInStockId) async {
    state = const AsyncValue<Cart>.loading().copyWithPrevious(state);
    try {
      await _repo.addToCart(productInStockId: productInStockId);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue<Cart>.error(e, st).copyWithPrevious(state);
    }
  }

  Future<void> updateItemQuantity(int cartItemId, int newQuantity) async {
    state = const AsyncValue<Cart>.loading().copyWithPrevious(state);
    try {
      if (newQuantity > 0) {
        await _repo.updateCartItemQuantity(
            cartItemId: cartItemId, newQuantity: newQuantity);
      } else {
        await _repo.removeCartItem(cartItemId: cartItemId);
      }
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue<Cart>.error(e, st).copyWithPrevious(state);
    }
  }

  Future<void> removeItem(int cartItemId) async {
    state = const AsyncValue<Cart>.loading().copyWithPrevious(state);
    try {
      await _repo.removeCartItem(cartItemId: cartItemId);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue<Cart>.error(e, st).copyWithPrevious(state);
    }
  }

  Future<void> clearCart() async {
    final currentCart = state.valueOrNull;
    if (currentCart == null || currentCart.items.isEmpty) return;

    state = const AsyncValue<Cart>.loading().copyWithPrevious(state);
    try {
      final futures = currentCart.items
          .map((item) => _repo.removeCartItem(cartItemId: item.id));
      await Future.wait(futures);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue<Cart>.error(e, st).copyWithPrevious(state);
    }
  }
}

final cartItemsProvider = Provider<List<CartItem>>((ref) {
  return ref.watch(cartProvider).valueOrNull?.items ?? [];
});

final cartItemProvider = Provider.family<CartItem?, int>((ref, cartItemId) {
  final items = ref.watch(cartItemsProvider);
  try {
    return items.firstWhere((item) => item.id == cartItemId);
  } catch (e) {
    return null;
  }
});
