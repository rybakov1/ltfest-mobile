import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/festival_order_args_model.dart';

import '../../../components/lt_appbar.dart';
import '../../../constants.dart';
import '../../../providers/user_provider.dart';
import '../components/loyalty_promo_section.dart';
import '../order_provider.dart';

@immutable
class FormValidationState {
  final bool isNameInvalid;
  final bool isEmailInvalid;
  final bool isPhoneInvalid;
  final bool isCollectiveNameInvalid;
  final bool isParticipantsNameInvalid;

  const FormValidationState({
    this.isNameInvalid = false,
    this.isEmailInvalid = false,
    this.isPhoneInvalid = false,
    this.isCollectiveNameInvalid = false,
    this.isParticipantsNameInvalid = false,
  });

  bool get hasErrors =>
      isNameInvalid ||
      isEmailInvalid ||
      isPhoneInvalid ||
      isCollectiveNameInvalid ||
      isParticipantsNameInvalid;
}

final formValidationProvider =
    StateProvider<FormValidationState>((ref) => const FormValidationState());

class FestivalOrderPage extends ConsumerStatefulWidget {
  final FestivalOrderArgs args;

  const FestivalOrderPage({super.key, required this.args});

  @override
  ConsumerState<FestivalOrderPage> createState() => _FestivalOrderPageState();
}

class _FestivalOrderPageState extends ConsumerState<FestivalOrderPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _collectiveNameController;
  late final TextEditingController _participantsNameController;
  late final TextEditingController loyaltyCardController;
  late final TextEditingController promocodeController;

  @override
  void initState() {
    super.initState();

    ref.read(orderProvider.notifier).startOrder(
          type: OrderType.festival,
          item: widget.args.tariff,
          festival: widget.args.festival,
        );

    final state = ref.read(orderProvider);

    _nameController = TextEditingController(text: state.payerName);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);
    _collectiveNameController =
        TextEditingController(text: state.collectiveName);
    _participantsNameController = TextEditingController();
    loyaltyCardController = TextEditingController();
    promocodeController = TextEditingController();
  }

  @override
  void dispose() {
    loyaltyCardController.dispose();
    promocodeController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    final validationStateNotifier = ref.read(formValidationProvider.notifier);

    final newState = FormValidationState(
      isNameInvalid: _nameController.text.isEmpty,
      isEmailInvalid: _emailController.text.isEmpty,
      isPhoneInvalid: _phoneController.text.isEmpty,
      isCollectiveNameInvalid: _collectiveNameController.text.isEmpty,
      isParticipantsNameInvalid: _participantsNameController.text.isEmpty,
    );

    validationStateNotifier.state = newState;
    return !newState.hasErrors;
  }

  void _resetValidationState() {
    if (ref.read(formValidationProvider).hasErrors) {
      ref.read(formValidationProvider.notifier).state =
          const FormValidationState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final user = ref.watch(userProvider);
    final validationState = ref.watch(formValidationProvider);

    final baseTotal = ref.watch(orderBasePriceProvider);
    final finalTotal = ref.watch(orderTotalPriceProvider);

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const LTAppBar(title: "Оплата участия"),
                    Container(
                      decoration: Decor.base,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          _buildTextField(
                            controller: _nameController,
                            label: "Имя плательщика*",
                            hint: "ФИО",
                            onChanged: orderNotifier.updatePayerName,
                            isInvalid: validationState.isNameInvalid,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _emailController,
                            label: "Email*",
                            hint: "Email",
                            onChanged: orderNotifier.updateEmail,
                            keyboardType: TextInputType.emailAddress,
                            isInvalid: validationState.isEmailInvalid,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _phoneController,
                            label: "Номер телефона*",
                            hint: "+7",
                            onChanged: orderNotifier.updatePhone,
                            keyboardType: TextInputType.phone,
                            isInvalid: validationState.isPhoneInvalid,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _collectiveNameController,
                            label: "Название коллектива",
                            hint: "Название коллектива",
                            onChanged: orderNotifier.updateCollectiveName,
                            isInvalid: validationState.isCollectiveNameInvalid,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _participantsNameController,
                            label: "Имя участника*",
                            hint: "Имя участника",
                            onChanged: orderNotifier.updateParticipantNames,
                            isInvalid:
                                validationState.isParticipantsNameInvalid,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Если участников несколько, напишите имена через запятую",
                            style: Styles.b3.copyWith(color: Palette.gray),
                          ),
                          if (validationState.hasErrors)
                            Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: Text(
                                "Заполните все обязательные поля",
                                style: Styles.b2.copyWith(color: Palette.error),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      decoration: Decor.base,
                      padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 20)
                          .copyWith(top: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          _buildSeatsCounter(
                            label: "Количество мест",
                            count: orderState.seatCount,
                            onIncrease: () => orderNotifier
                                .updateSeatCount(orderState.seatCount + 1),
                            onDecrease: () {
                              if (orderState.seatCount > 1) {
                                orderNotifier
                                    .updateSeatCount(orderState.seatCount - 1);
                              }
                            },
                          ),
                          const SizedBox(height: 24),
                          buildLoyaltyOrPromoSection(
                            context,
                            user!,
                            'Тариф "${widget.args.tariff.title}"',
                            ref,
                            loyaltyCardController,
                            promocodeController,
                            cartTotal: baseTotal,
                            finalTotal: finalTotal,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2),
            _buildSummarySection(finalTotal, orderNotifier),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatsCounter({
    required String label,
    required int count,
    required VoidCallback onIncrease,
    required VoidCallback onDecrease,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: Styles.h4),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.remove_circle,
              size: 32,
              color: count > 1 ? Palette.primaryLime : Palette.stroke),
          onPressed: count > 1 ? onDecrease : null,
        ),
        const SizedBox(width: 10),
        Text('$count', style: Styles.h4),
        const SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.add_circle, size: 32, color: Palette.primaryLime),
          onPressed: onIncrease,
        ),
      ],
    );
  }

  Widget _buildSummarySection(int totalPrice, OrderNotifier orderNotifier) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Palette.primaryLime.withValues(alpha: 0.1),
              border: Border.all(color: Palette.primaryLime),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Center(child: Text("Рекомендуем оплачивать через СБП", style: Styles.b2)),
          ),
          const SizedBox(height: 8),
          LTButtons.elevatedButton(
            onPressed: () {
              if (!_validateForm()) {
                return;
              }
              orderNotifier.placeOrderAndPay(context, totalPrice);
            },
            child: Text("Оплатить", style: Styles.button1),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    bool isInvalid = false,
  }) {
    final borderColor = isInvalid ? Palette.error : Palette.stroke;
    final focusedBorderColor = isInvalid ? Palette.error : Palette.primaryLime;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Styles.b3),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          onChanged: (value) {
            _resetValidationState();
            onChanged(value);
          },
          keyboardType: keyboardType,
          style: Styles.b2,
          decoration: InputDecoration(
            hintText: hint,
            constraints: const BoxConstraints(maxHeight: 43),
            hintStyle: Styles.b2.copyWith(color: Palette.gray),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            filled: true,
            fillColor: Palette.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: focusedBorderColor, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
