import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';
import '../../../data/models/user.dart';
import '../../../providers/loyalty_card_provider.dart';
import '../../../providers/promocode_provider.dart';
import 'custom_text_fields.dart';

Widget buildLoyaltyOrPromoSection(BuildContext context,
    User user,
    String? type,
    WidgetRef ref,
    TextEditingController loyaltyCardController,
    TextEditingController promocodeController, {
      required int cartTotal,
      required int finalTotal,
    }) {
  final promoCodeState = ref.watch(promoCodeNotifierProvider);
  final promoCodeNotifier = ref.read(promoCodeNotifierProvider.notifier);

  final loyaltyCardState = ref.watch(loyaltyCardNotifierProvider);
  final loyaltyCardNotifier = ref.read(loyaltyCardNotifierProvider.notifier);

  final discountAmount = cartTotal - finalTotal;

  final String discountLabel = loyaltyCardState.maybeMap(
    success: (successState) {
      final card = successState.loyaltyCard;
      return 'Скидка по карте (${card.discountPercent}%)';
    },
    orElse: () =>
        promoCodeState.maybeMap(
          success: (successState) {
            final promo = successState.promoCode;
            if (promo.discountType == 'percentage') {
              return 'Скидка (${promo.discountValue.toStringAsFixed(0)}%)';
            } else {
              return 'Скидка (${promo.discountValue.round()} ₽)';
            }
          },
          orElse: () => 'Скидка',
        ),
  );

  // final bool isLoading = loyaltyCardState is  _Loading || promoCodeState is _Loading;
  String? errorMessage;

  loyaltyCardState.mapOrNull(
      error: (e) => errorMessage = 'Карта лояльности не найдена');

  if (errorMessage == null) {
    promoCodeState.mapOrNull(error: (e) => errorMessage = 'Промокод не найден');
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (user.activity!.title == "Руководитель коллектива") ...[
            Expanded(
              child: buildTextField(
                controller: loyaltyCardController,
                label: "Карта лояльности",
                hint: "Введите номер карты",
                onChanged: (val) {
                  loyaltyCardState.maybeMap(
                    loading: (_) {},
                    orElse: () => loyaltyCardNotifier.reset(),
                  );
                },
              ),
            ),
          ] else
            ...[
              Expanded(
                child: buildTextField(
                  controller: promocodeController,
                  label: "Промокод",
                  hint: "Введите промокод",
                  onChanged: (val) {
                    promoCodeState.maybeMap(
                      loading: (_) {},
                      orElse: () => promoCodeNotifier.reset(),
                    );
                  },
                ),
              ),
            ],
          const SizedBox(width: 8),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: loyaltyCardController,
            builder: (context, loyaltyValue, child) {
              return ValueListenableBuilder<TextEditingValue>(
                valueListenable: promocodeController,
                builder: (context, promoValue, child) {
                  final bool isButtonActive = user.activity!.title ==
                      "Руководитель коллектива"
                      ? loyaltyValue.text.isNotEmpty
                      : promoValue.text.isNotEmpty;

                  return InkWell(
                    onTap: !isButtonActive
                        ? null
                        : () {
                      FocusScope.of(context).unfocus();
                      if (user.activity!.title == "Руководитель коллектива") {
                        final cardNumber = loyaltyCardController.text.trim();
                        loyaltyCardNotifier.getLoyaltyCard(cardNumber, user.id);
                      } else {
                        final code = promocodeController.text.trim();
                        promoCodeNotifier.validatePromoCode(code);
                      }
                    },
                    child: Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isButtonActive
                            ? Palette.primaryLime
                            : Palette.stroke,
                      ),
                      child: Icon(Icons.arrow_forward_outlined,
                          color: Palette.white, size: 24),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      promoCodeState.maybeWhen(
        loading: () =>
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: LinearProgressIndicator(),
        ),
        // error: (message) => Padding(
        //   padding: const EdgeInsets.only(top: 8.0),
        //   child: Text(
        //     message,
        //     style: const TextStyle(color: Colors.red, fontSize: 12),
        //     textAlign: TextAlign.right,
        //   ),
        // ),
        orElse: () => const SizedBox.shrink(), // Ничего не показываем в др. случаях
      ),

      // if (isLoading)
      //   const Padding(
      //     padding: EdgeInsets.only(top: 8.0),
      //     child: LinearProgressIndicator(),
      //   )
      if (errorMessage != null)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 12),
            textAlign: TextAlign.right,
          ),
        ),

      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type ?? "Стоимость заказа", style: Styles.b2),
          Text(Utils.formatMoney(cartTotal), style: Styles.h4),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            discountLabel,
            style: Styles.b2.copyWith(color: Palette.secondary),
          ),
          Text(
            Utils.formatMoney(discountAmount),
            style: Styles.h4,
          ),
        ],
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Итого:", style: Styles.h4),
          Text(Utils.formatMoney(finalTotal), style: Styles.h3),
        ],
      ),
    ],
  );
}
