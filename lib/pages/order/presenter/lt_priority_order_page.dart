import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/priority_tariff.dart';
import 'package:ltfest/pages/order/order_provider.dart';

import '../../../data/models/user.dart';
import '../../../providers/user_provider.dart';
import '../components/loyalty_promo_section.dart';

class LtPriorityOrderPage extends ConsumerStatefulWidget {
  final PriorityTariff tariff;

  const LtPriorityOrderPage({super.key, required this.tariff});

  @override
  ConsumerState<LtPriorityOrderPage> createState() =>
      _LtPriorityOrderPageState();
}

class _LtPriorityOrderPageState extends ConsumerState<LtPriorityOrderPage> {
  final _formKey = GlobalKey<FormState>();
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
    Future.microtask(() => ref.read(orderProvider.notifier).startOrder(
          type: OrderType.ltpriority,
          item: widget.tariff,
        ));
    final state = ref.read(orderProvider);
    final user = ref.read(userProvider);

    _nameController = TextEditingController(text: state.payerName);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);
    _cityController = TextEditingController(text: user!.residence!);

    _collectiveNameController = TextEditingController(text: state.collectiveName);
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

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final user = ref.watch(userProvider);

    final baseTotal = ref.watch(orderBasePriceProvider);
    final finalTotal = ref.watch(orderTotalPriceProvider);

    return Scaffold(
      backgroundColor: Palette.background,
      body: Form(
        key: _formKey,
        child: SafeArea(
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
                            _buildTextField(
                              controller: _nameController,
                              label: "Имя плательщика*",
                              hint: "Иванов Иван Иванович",
                              onChanged: orderNotifier.updatePayerName,
                              validator: (val) =>
                                  val!.isEmpty ? 'Обязательное поле' : null,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _emailController,
                                    label: "Email*",
                                    hint: "example@mail.com",
                                    onChanged: orderNotifier.updateEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val) => val!.isEmpty
                                        ? 'Обязательное поле'
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildTextField(
                                    controller: _phoneController,
                                    label: "Номер телефона*",
                                    hint: "+7 (999) 999-99-99",
                                    onChanged: orderNotifier.updatePhone,
                                    keyboardType: TextInputType.phone,
                                    validator: (val) => val!.isEmpty
                                        ? 'Обязательное поле'
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: _passportController,
                              label: "Паспортные данные*",
                              hint: "Серия, Номер и Дата выдачи",
                              onChanged: orderNotifier.updatePassport,
                              validator: (val) =>
                                  val!.isEmpty ? 'Обязательное поле' : null,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: _collectiveNameController,
                              label: "Название коллектива*",
                              hint: "Введите название",
                              onChanged: orderNotifier.updateCollectiveName,
                              validator: (val) =>
                                  val!.isEmpty ? 'Обязательное поле' : null,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: _cityController,
                              label: "Город проживания*",
                              hint: "Иванов Иван Иванович",
                              onChanged: orderNotifier.updateResidence,
                              validator: (val) =>
                                  val!.isEmpty ? 'Обязательное поле' : null,
                            ),
                            const SizedBox(height: 16),
                            _buildDeliverySection(
                                orderState, orderNotifier, _addressController),
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
              _buildPayButton(finalTotal, orderState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCdekDelivery() {
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
        _buildTextField(
          controller: _addressController,
          label: 'Адрес пункта выдачи CDEK*',
          hint: 'Введите ближайший к вам адрес',
          onChanged: orderNotifier.updateDeliveryAddress,
          validator: (val) => val!.isEmpty ? 'Укажите адрес' : null,
        ),
      ],
    );
  }

  Widget _buildDeliverySection(OrderState orderState,
      OrderNotifier orderNotifier, TextEditingController addressController) {
    return Container(
      decoration: Decor.base,
      child: _buildCdekDelivery(),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Styles.b3),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          validator: validator,
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
              borderSide: BorderSide(color: Palette.stroke, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Palette.stroke, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Palette.primaryLime, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPayButton(int totalPrice, OrderState orderState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: LTButtons.elevatedButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) return;
          ref
              .read(orderProvider.notifier)
              .placeOrderAndPay(context, totalPrice);
        },
        child: Text("Оплатить", style: Styles.button1),
      ),
    );
  }
}
