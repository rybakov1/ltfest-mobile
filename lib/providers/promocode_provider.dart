import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/promocode.dart';
import '../data/repositories/misc_repository.dart';
import '../data/services/api_exception.dart';

part 'promocode_provider.freezed.dart';
part 'promocode_provider.g.dart';

@freezed
class PromoCodeState with _$PromoCodeState {
  const factory PromoCodeState.initial() = _Initial;
  const factory PromoCodeState.loading() = _Loading;
  const factory PromoCodeState.success(PromoCode promoCode) = _Success;
  const factory PromoCodeState.error(String message) = _Error;
}

@riverpod
class PromoCodeNotifier extends _$PromoCodeNotifier {
  @override
  PromoCodeState build() => const PromoCodeState.initial();

  Future<void> validatePromoCode(String code) async {
    if (code.trim().isEmpty) {
      state = const PromoCodeState.error('Введите промокод');
      return;
    }
    state = const PromoCodeState.loading();
    try {
      final repo = ref.read(miscRepositoryProvider);
      final promo = await repo.getPromoCodeByCode(code);

      if (promo.validUntil.isBefore(DateTime.now())) {
        state = const PromoCodeState.error('Срок действия промокода истек');
        return;
      }

      if (promo.currentUses >= promo.maxUses) {
        state = const PromoCodeState.error('Этот промокод больше не действителен');
        return;
      }

      state = PromoCodeState.success(promo);
    } on ApiException catch (e) {
      state = PromoCodeState.error(e.message);
    } catch (e) {
      state = const PromoCodeState.error('Произошла неизвестная ошибка');
    }
  }

  void reset() {
    state = const PromoCodeState.initial();
  }
}
