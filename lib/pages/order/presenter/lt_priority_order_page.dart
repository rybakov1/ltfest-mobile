import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/priority_tariff.dart';
import 'package:ltfest/pages/order/order_provider.dart';

import '../../../providers/user_provider.dart';
import '../components/custom_text_fields.dart';
import '../components/loyalty_promo_section.dart';

@immutable
class LtPriorityFormValidationState {
  final bool isNameInvalid;
  final bool isEmailInvalid;
  final bool isPhoneInvalid;
  final bool isPassportInvalid;
  final bool isCollectiveNameInvalid;
  final bool isCityInvalid;
  final bool isAddressInvalid;

  const LtPriorityFormValidationState({
    this.isNameInvalid = false,
    this.isEmailInvalid = false,
    this.isPhoneInvalid = false,
    this.isPassportInvalid = false,
    this.isCollectiveNameInvalid = false,
    this.isCityInvalid = false,
    this.isAddressInvalid = false,
  });

  bool get hasErrors =>
      isNameInvalid ||
      isEmailInvalid ||
      isPhoneInvalid ||
      isPassportInvalid ||
      isCollectiveNameInvalid ||
      isCityInvalid ||
      isAddressInvalid;
}

final ltPriorityFormValidationProvider =
    StateProvider<LtPriorityFormValidationState>(
        (ref) => const LtPriorityFormValidationState());

class LtPriorityOrderPage extends ConsumerStatefulWidget {
  final PriorityTariff tariff;

  const LtPriorityOrderPage({super.key, required this.tariff});

  @override
  ConsumerState<LtPriorityOrderPage> createState() =>
      _LtPriorityOrderPageState();
}

class _LtPriorityOrderPageState extends ConsumerState<LtPriorityOrderPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passportController;
  late final TextEditingController _cityController;

  late final TextEditingController _collectiveNameController;
  late final TextEditingController _addressController;

  late final TextEditingController _loyaltyCardController;
  late final TextEditingController _promocodeController;

  @override
  void initState() {
    super.initState();
    ref.read(orderProvider.notifier).startOrder(
          type: OrderType.ltpriority,
          item: widget.tariff,
        );

    final state = ref.read(orderProvider);
    final user = ref.read(userProvider);

    _nameController = TextEditingController(text: state.payerName);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);
    _cityController = TextEditingController(text: user!.residence!);

    _collectiveNameController =
        TextEditingController(text: state.collectiveName);
    _addressController = TextEditingController(text: state.deliveryAddress);
    _passportController = TextEditingController();

    _loyaltyCardController = TextEditingController();
    _promocodeController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _collectiveNameController.dispose();
    _addressController.dispose();
    _passportController.dispose();
    _loyaltyCardController.dispose();
    _promocodeController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    final validationNotifier =
        ref.read(ltPriorityFormValidationProvider.notifier);

    final newState = LtPriorityFormValidationState(
      isNameInvalid: _nameController.text.isEmpty,
      isEmailInvalid: _emailController.text.isEmpty,
      isPhoneInvalid: _phoneController.text.isEmpty,
      isPassportInvalid: _passportController.text.isEmpty,
      isCollectiveNameInvalid: _collectiveNameController.text.isEmpty,
      isCityInvalid: _cityController.text.isEmpty,
      isAddressInvalid: _addressController.text.isEmpty,
    );
    validationNotifier.state = newState;
    return !newState.hasErrors;
  }

  void _resetValidationState() {
    if (ref.read(ltPriorityFormValidationProvider).hasErrors) {
      ref.read(ltPriorityFormValidationProvider.notifier).state =
          const LtPriorityFormValidationState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderNotifier = ref.read(orderProvider.notifier);
    final user = ref.watch(userProvider);
    final validationState = ref.watch(ltPriorityFormValidationProvider);

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
                    const LTAppBar(title: "Оплата"),
                    Container(
                      decoration: Decor.base,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          buildTextField(
                            controller: _nameController,
                            label: "Имя плательщика*",
                            hint: "ФИО",
                            onChanged: orderNotifier.updatePayerName,
                            isInvalid: validationState.isNameInvalid,
                          ),
                          const SizedBox(height: 16),
                          buildTextField(
                            controller: _emailController,
                            label: "Email*",
                            hint: "Email",
                            onChanged: orderNotifier.updateEmail,
                            keyboardType: TextInputType.emailAddress,
                            isInvalid: validationState.isEmailInvalid,
                          ),
                          const SizedBox(height: 16),
                          buildTextField(
                            controller: _phoneController,
                            label: "Номер телефона*",
                            hint: "+7",
                            onChanged: orderNotifier.updatePhone,
                            keyboardType: TextInputType.phone,
                            isInvalid: validationState.isPhoneInvalid,
                          ),
                          const SizedBox(height: 16),
                          buildTextField(
                            controller: _passportController,
                            label: "Паспортные данные*",
                            hint: "Серия, Номер и Дата выдачи",
                            func: _resetValidationState,
                            onChanged: orderNotifier.updatePassport,
                            isInvalid: validationState.isPassportInvalid,
                          ),
                          const SizedBox(height: 16),
                          buildTextField(
                            controller: _collectiveNameController,
                            label: "Название коллектива*",
                            hint: "Название коллектива",
                            onChanged: orderNotifier.updateCollectiveName,
                            func: _resetValidationState,
                            isInvalid: validationState.isCollectiveNameInvalid,
                          ),
                          const SizedBox(height: 16),
                          buildTextField(
                            controller: _cityController,
                            label: "Город проживания*",
                            hint: "Выберите город",
                            onChanged: orderNotifier.updateResidence,
                            func: _resetValidationState,
                            isInvalid: validationState.isCityInvalid,
                          ),
                          const SizedBox(height: 16),
                          _buildDeliverySection(
                              validationState.isAddressInvalid),
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
                          horizontal: 12, vertical: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: buildLoyaltyOrPromoSection(
                        context,
                        user!,
                        widget.tariff.title,
                        ref,
                        _loyaltyCardController,
                        _promocodeController,
                        cartTotal: baseTotal,
                        finalTotal: finalTotal,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              ),
            ),
            _buildPayButton(finalTotal),
          ],
        ),
      ),
    );
  }

  Widget _buildCdekDelivery(bool isInvalid) {
    final orderNotifier = ref.read(orderProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Доставка CDEK", style: Styles.b2),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Palette.primaryLime.withValues(alpha: 0.1),
            border: Border.all(color: Palette.primaryLime),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info, color: Palette.primaryLime),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Стоимость доставки оплачивается отдельно во время получения.",
                  style: Styles.b2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        buildTextField(
          controller: _addressController,
          label: 'Адрес пункта выдачи CDEK*',
          hint: 'Введите ближайший к вам адрес',
          onChanged: orderNotifier.updateDeliveryAddress,
          isInvalid: isInvalid,
        ),
      ],
    );
  }

  Widget _buildDeliverySection(bool isAddressInvalid) {
    return Container(
      decoration: Decor.base,
      child: _buildCdekDelivery(isAddressInvalid),
    );
  }

  Widget _buildPayButton(int totalPrice) {
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
            decoration: BoxDecoration(
              color: Palette.primaryLime.withValues(alpha: 0.1),
              border: Border.all(color: Palette.primaryLime),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Text("Рекомендуем оплачивать через СБП",
                style: Styles.b2),
          ),
          const SizedBox(height: 8),
          LTButtons.elevatedButton(
            onPressed: () {
              if (!_validateForm()) return;
              ref
                  .read(orderProvider.notifier)
                  .placeOrderAndPay(context, totalPrice);
            },
            child: Text("Оплатить", style: Styles.button1),
          ),
        ],
      ),
    );
  }
}
