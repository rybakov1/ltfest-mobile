import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/pages/order/order_provider.dart';

import '../../../data/models/user.dart';
import '../../../providers/user_provider.dart';

class LtPriorityOrderPage extends ConsumerStatefulWidget {
  const LtPriorityOrderPage({super.key});

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

  late final TextEditingController _collectiveNameController;
  late final TextEditingController _addressController;

  late final TextEditingController _loyaltyCardController;
  late final TextEditingController _promocodeController;

  @override
  void initState() {
    super.initState();
    ref.read(orderProvider.notifier).reset(OrderType.ltpriority);
    final state = ref.read(orderProvider);
    _nameController = TextEditingController(text: state.payerName);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);
    _collectiveNameController =
        TextEditingController(text: state.collectiveName);
    _addressController = TextEditingController(text: state.deliveryAddress);
    _loyaltyCardController = TextEditingController();
    _promocodeController = TextEditingController();
    _passportController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
    final totalPrice = ref.watch(cartTotalPriceProvider);
    final user = ref.watch(userProvider);

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
                              onChanged: orderNotifier.updatePayerName,
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
                              controller: _nameController,
                              label: "Город проживания*",
                              hint: "Иванов Иван Иванович",
                              onChanged: orderNotifier.updatePayerName,
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
                      _buildLoyaltyOrPromoSection(user!, totalPrice),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ),
              _buildPayButton(totalPrice, orderState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoyaltyOrPromoSection(User user, totalPrice) {
    return Container(
      decoration: Decor.base,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (user.activity!.title == "Руководитель коллектива") ...[
                Expanded(
                  child: _buildTextField(
                    controller: _loyaltyCardController,
                    label: "Карта лояльности",
                    hint: "Введите номер карты",
                    onChanged: (val) {
                      // TODO: обработка промокода — пока не реализована
                    },
                  ),
                ),
              ] else ...[
                Expanded(
                  child: _buildTextField(
                    controller: _promocodeController,
                    label: "Промокод",
                    hint: "Введите промокод",
                    onChanged: (val) {
                      // TODO: обработка промокода — пока не реализована
                    },
                  ),
                ),
              ],
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  // TODO: применить промокод/карту
                },
                child: Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Palette.stroke,
                  ),
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    color: Palette.white,
                    size: 24,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Стоимость заказа", style: Styles.b2),
              Text(Utils.formatMoney(totalPrice), style: Styles.h4),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Скидка",
                  style: Styles.b2.copyWith(color: Palette.secondary)),
              Text(Utils.formatMoney(0), style: Styles.h4),
              // пока без скидки
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Итого:", style: Styles.h4),
              Text(Utils.formatMoney(totalPrice), style: Styles.h3),
            ],
          ),
        ],
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
          if (orderState.deliveryMethod == DeliveryMethod.onFestival &&
              orderState.selectedFestival == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Выберите фестиваль')));
            return;
          }
          ref.read(orderProvider.notifier).placeOrderAndPay(context, totalPrice);
        },
        child: Text("Оплатить", style: Styles.button1),
      ),
    );
  }
}
