import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/pages/order/order_provider.dart';
import 'package:ltfest/providers/promocode_provider.dart';

import '../../../components/modal.dart';
import '../../../data/models/user.dart';
import '../../../providers/user_provider.dart';
import '../components/loyalty_promo_section.dart';

class ProductOrderPage extends ConsumerStatefulWidget {
  const ProductOrderPage({super.key});

  @override
  ConsumerState<ProductOrderPage> createState() => _ProductOrderPageState();
}

class _ProductOrderPageState extends ConsumerState<ProductOrderPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _collectiveNameController;
  late final TextEditingController _addressController;

  late final TextEditingController loyaltyCardController;
  late final TextEditingController promocodeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _collectiveNameController = TextEditingController();
    _addressController = TextEditingController();
    loyaltyCardController = TextEditingController();
    promocodeController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderProvider.notifier).reset(OrderType.products);
      final state = ref.read(orderProvider);
      _nameController.text = state.payerName;
      _emailController.text = state.email;
      _phoneController.text = state.phone;
      _collectiveNameController.text = state.collectiveName;
      _addressController.text = state.deliveryAddress;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _collectiveNameController.dispose();
    _addressController.dispose();

    loyaltyCardController.dispose();
    promocodeController.dispose();
    super.dispose();
  }

  void _showFestivalSelection(
      BuildContext context, OrderNotifier orderNotifier) {
    final currentFestival = ref.read(orderProvider).selectedFestival;

    showModalPicker<Festival>(
      context: context,
      title: "Выбор фестиваля",
      provider: allFestivalsProvider,
      itemBuilder: (festival) => festival.title,
      initialValue: currentFestival,
      onConfirm: (selectedFestival) {
        if (selectedFestival != null) {
          orderNotifier.selectFestival(selectedFestival);
        }
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final user = ref.watch(userProvider);

    ref.listen<OrderState>(orderProvider, (previous, next) {
      if (previous?.payerName != next.payerName)
        _nameController.text = next.payerName;
      if (previous?.email != next.email) _emailController.text = next.email;
      if (previous?.phone != next.phone) _phoneController.text = next.phone;
      if (previous?.collectiveName != next.collectiveName)
        _collectiveNameController.text = next.collectiveName;
    });

    final baseTotal = ref.watch(orderBasePriceProvider); // <--- Начальная цена
    final finalTotal = ref.watch(orderTotalPriceProvider); // <--- Итоговая цена со скидкой

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
                              controller: _collectiveNameController,
                              label: "Название коллектива*",
                              hint: "Введите название",
                              onChanged: orderNotifier.updateCollectiveName,
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
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: buildLoyaltyOrPromoSection(
                          context,
                          user!,
                          ref,
                          loyaltyCardController,
                          promocodeController,
                          cartTotal: baseTotal,
                          finalTotal: finalTotal,
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ),
              _buildPayButton(orderState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCdekDelivery() {
    final orderNotifier = ref.read(orderProvider.notifier);
    return Column(
      children: [
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Получение заказа", style: Styles.b2),
          const SizedBox(height: 16),
          buildRadioListTile(
            title: 'На фестивале',
            value: DeliveryMethod.onFestival,
            groupValue: orderState.deliveryMethod,
            onChanged: (value) => orderNotifier.setDeliveryMethod(value!),
          ),
          buildRadioListTile(
            title: 'Доставкой CDEK',
            value: DeliveryMethod.cdek,
            groupValue: orderState.deliveryMethod,
            onChanged: (value) => orderNotifier.setDeliveryMethod(value!),
          ),
          const SizedBox(height: 16),
          if (orderState.deliveryMethod == DeliveryMethod.onFestival)
            _buildFestivalPicker(orderState, orderNotifier),
          if (orderState.deliveryMethod == DeliveryMethod.cdek)
            _buildCdekDelivery()
        ],
      ),
    );
  }

  Widget _buildFestivalPicker(
      OrderState orderState, OrderNotifier orderNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Выбор фестиваля*", style: Styles.b3),
        const SizedBox(height: 6),
        InkWell(
          onTap: () => _showFestivalSelection(context, orderNotifier),
          child: Container(
            height: 43,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Palette.white,
              border: Border.all(color: Palette.stroke),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    orderState.selectedFestival?.title ?? 'Выберите фестиваль',
                    style: orderState.selectedFestival == null
                        ? Styles.b2.copyWith(color: Palette.gray)
                        : Styles.b2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.keyboard_arrow_right, color: Palette.gray),
              ],
            ),
          ),
        ),
      ],
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

  Widget _buildPayButton(OrderState orderState) {
    final finalTotal = ref.watch(orderTotalPriceProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: LTButtons.elevatedButton(
        // Блокируем кнопку, если идет загрузка
        onPressed: orderState.isLoading
            ? null
            : () {
                if (!_formKey.currentState!.validate()) return;
                if (orderState.deliveryMethod == DeliveryMethod.onFestival &&
                    orderState.selectedFestival == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Выберите фестиваль')));
                  return;
                }
                ref
                    .read(orderProvider.notifier)
                    .placeOrderAndPay(context, finalTotal);
              },
        // Показываем индикатор загрузки
        child: orderState.isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text("Оплатить", style: Styles.button1),
      ),
    );
  }
}
