import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/loyalty_card.dart';
import '../data/repositories/misc_repository.dart';
import '../data/services/api_exception.dart';

part 'loyalty_card_provider.freezed.dart';
part 'loyalty_card_provider.g.dart';

@freezed
class LoyaltyCardState with _$LoyaltyCardState {
  const factory LoyaltyCardState.initial() = _Initial;
  const factory LoyaltyCardState.loading() = _Loading;
  const factory LoyaltyCardState.success(LoyaltyCard loyaltyCard) = _Success;
  const factory LoyaltyCardState.error(String message) = _Error;
}

@riverpod
class LoyaltyCardNotifier extends _$LoyaltyCardNotifier {
  @override
  LoyaltyCardState build() => const LoyaltyCardState.initial();

  Future<void> getLoyaltyCard(String cardNumber, int currentUserId) async {
    if (cardNumber.trim().isEmpty) {
      state = const LoyaltyCardState.error('Введите номер карты');
      return;
    }
    state = const LoyaltyCardState.loading();
    try {
      final repo = ref.read(miscRepositoryProvider);
      final card = await repo.getLoyaltyCardByNumber(cardNumber);
      if (card.user.id == currentUserId) {
        state = LoyaltyCardState.success(card);
      } else {
        state = const LoyaltyCardState.error(
            'Эта карта лояльности принадлежит другому пользователю');
      }
    } on ApiException {
      state = const LoyaltyCardState.error("Карта лояльности не найдена");
    } catch (e) {
      state = const LoyaltyCardState.error('Произошла неизвестная ошибка');
    }
  }

  void reset() {
    state = const LoyaltyCardState.initial();
  }
}
