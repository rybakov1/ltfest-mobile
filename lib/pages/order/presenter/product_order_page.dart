import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/pages/order/order_provider.dart';

import '../../../components/modal.dart';
import '../../../providers/user_provider.dart';
import '../components/custom_text_fields.dart';
import '../components/loyalty_promo_section.dart';

@immutable
class ProductFormValidationState {
  final bool isNameInvalid;
  final bool isEmailInvalid;
  final bool isPhoneInvalid;
  final bool isCollectiveNameInvalid;
  final bool isAddressInvalid;
  final bool isFestivalInvalid;

  const ProductFormValidationState({
    this.isNameInvalid = false,
    this.isEmailInvalid = false,
    this.isPhoneInvalid = false,
    this.isCollectiveNameInvalid = false,
    this.isAddressInvalid = false,
    this.isFestivalInvalid = false,
  });

  bool get hasErrors =>
      isNameInvalid ||
      isEmailInvalid ||
      isPhoneInvalid ||
      isCollectiveNameInvalid ||
      isAddressInvalid ||
      isFestivalInvalid;
}

final productFormValidationProvider = StateProvider<ProductFormValidationState>(
    (ref) => const ProductFormValidationState());

class ProductOrderPage extends ConsumerStatefulWidget {
  const ProductOrderPage({super.key});

  @override
  ConsumerState<ProductOrderPage> createState() => _ProductOrderPageState();
}

class _ProductOrderPageState extends ConsumerState<ProductOrderPage> {
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

  bool _validateForm() {
    final orderState = ref.read(orderProvider);
    final validationNotifier = ref.read(productFormValidationProvider.notifier);

    final newState = ProductFormValidationState(
      isNameInvalid: _nameController.text.isEmpty,
      isEmailInvalid: _emailController.text.isEmpty,
      isPhoneInvalid: _phoneController.text.isEmpty,
      isCollectiveNameInvalid: _collectiveNameController.text.isEmpty,
      // Адрес обязателен, только если выбран CDEK
      isAddressInvalid: orderState.deliveryMethod == DeliveryMethod.cdek &&
          _addressController.text.isEmpty,
      // Фестиваль обязателен, только если выбран самовывоз
      isFestivalInvalid:
          orderState.deliveryMethod == DeliveryMethod.onFestival &&
              orderState.selectedFestival == null,
    );

    validationNotifier.state = newState;
    return !newState.hasErrors;
  }

  void _resetValidationState() {
    if (ref.read(productFormValidationProvider).hasErrors) {
      ref.read(productFormValidationProvider.notifier).state =
          const ProductFormValidationState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final user = ref.watch(userProvider);
    final validationState = ref.watch(productFormValidationProvider);

    ref.listen<OrderState>(orderProvider, (previous, next) {
      if (previous?.payerName != next.payerName)
        _nameController.text = next.payerName;
      if (previous?.email != next.email) _emailController.text = next.email;
      if (previous?.phone != next.phone) _phoneController.text = next.phone;
      if (previous?.collectiveName != next.collectiveName)
        _collectiveNameController.text = next.collectiveName;
    });

    final baseTotal = ref.watch(orderBasePriceProvider); // <--- Начальная цена
    final finalTotal =
        ref.watch(orderTotalPriceProvider); // <--- Итоговая цена со скидкой

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
                            controller: _collectiveNameController,
                            label: "Название коллектива*",
                            hint: "Название коллектива",
                            onChanged: orderNotifier.updateCollectiveName,
                            isInvalid: validationState.isCollectiveNameInvalid,
                            func: _resetValidationState,
                          ),
                          const SizedBox(height: 16),
                          _buildDeliverySection(
                              orderState, orderNotifier, validationState),
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
                        null,
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
            _buildPayButton(orderState, finalTotal),
          ],
        ),
      ),
    );
  }

  Widget _buildCdekDelivery(bool isInvalid) {
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
        buildTextField(
          controller: _addressController,
          label: 'Адрес пункта выдачи CDEK*',
          hint: 'Введите ближайший к вам адрес',
          onChanged: orderNotifier.updateDeliveryAddress,
          isInvalid: isInvalid,
          func: _resetValidationState,
        ),
      ],
    );
  }

  Widget _buildDeliverySection(OrderState orderState,
      OrderNotifier orderNotifier, ProductFormValidationState validationState) {
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
            _buildFestivalPicker(
                orderState, orderNotifier, validationState.isFestivalInvalid),
          if (orderState.deliveryMethod == DeliveryMethod.cdek)
            _buildCdekDelivery(validationState.isAddressInvalid)
        ],
      ),
    );
  }

  Widget _buildFestivalPicker(
      OrderState orderState, OrderNotifier orderNotifier, bool isInvalid) {
    final borderColor = isInvalid ? Palette.error : Palette.stroke;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Выбор фестиваля*", style: Styles.b3),
        const SizedBox(height: 6),
        InkWell(
          onTap: () {
            _resetValidationState();
            _showFestivalSelection(context, orderNotifier);
          },
          child: Container(
            height: 43,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Palette.white,
              border: Border.all(color: borderColor), // Используем цвет ошибки
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

  Widget _buildPayButton(OrderState orderState, int finalTotal) {
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
            onPressed: orderState.isLoading
                ? null
                : () {
                    if (!_validateForm()) return;
                    ref
                        .read(orderProvider.notifier)
                        .placeOrderAndPay(context, finalTotal, ref.read(orderBasePriceProvider));
                  },
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
        ],
      ),
    );
  }
}
