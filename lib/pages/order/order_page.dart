//order_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/pages/order/order_provider.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _collectiveController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    // Инициализируем контроллеры начальными значениями из провайдера
    final initialState = ref.read(orderProvider);
    _nameController = TextEditingController(text: initialState.payerName);
    _emailController = TextEditingController(text: initialState.email);
    _phoneController = TextEditingController(text: initialState.phone);
    _collectiveController =
        TextEditingController(text: initialState.collectiveName);
    _addressController =
        TextEditingController(text: initialState.deliveryAddress);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _collectiveController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _showFestivalSelection(BuildContext context) {
    final festivalsAsync = ref.watch(allFestivalsProvider);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        builder: (BuildContext context, ScrollController scrollController) {
          return festivalsAsync.when(
            data: (festivals) => ListView.builder(
              controller: scrollController,
              itemCount: festivals.length,
              itemBuilder: (context, index) {
                final festival = festivals[index];
                return ListTile(
                  title: Text(festival.title, style: Styles.b1),
                  subtitle: Text(
                    'f',
                    //'${festival.city} - ${Utils.formatDateRange(festival.dateStart, festival.dateEnd)}',
                    style: Styles.b3.copyWith(color: Palette.gray),
                  ),
                  onTap: () {
                    ref.read(orderProvider.notifier).selectFestival(festival);
                    context.pop(); // Закрыть BottomSheet
                  },
                );
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Ошибка: $err')),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final totalPrice = ref.watch(cartTotalPriceProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true, // Изменено на true
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              color: Palette.primaryLime,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Palette.white, size: 24),
                onPressed: () => context.pop(),
              ),
            ),
          ),
        ),
        title: Text("Оформление заказа", style: Styles.h4),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
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
                            validator: (val) =>
                                val!.isEmpty ? 'Обязательное поле' : null,
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
                            validator: (val) =>
                                val!.isEmpty ? 'Обязательное поле' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _collectiveController,
                      label: "Название коллектива",
                      hint: "Коллектив",
                      onChanged: orderNotifier.updateCollectiveName,
                    ),
                    const SizedBox(height: 24),
                    _buildDeliverySection(),
                  ],
                ),
              ),
            ),
            _buildSummaryAndPayButton(totalPrice, orderState),
          ],
        ),
      ),
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
            hintStyle: Styles.b2.copyWith(color: Palette.gray),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            filled: true,
            fillColor: Palette.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Palette.stroke, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Palette.stroke, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Palette.primaryLime, width: 1)),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliverySection() {
    final orderState = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: Decor.base,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Получение заказа", style: Styles.h4),
          const SizedBox(height: 8),
          RadioListTile<DeliveryMethod>(
            title: Text('На фестивале', style: Styles.b1),
            value: DeliveryMethod.onFestival,
            groupValue: orderState.deliveryMethod,
            onChanged: (value) => orderNotifier.setDeliveryMethod(value!),
            activeColor: Palette.primaryLime,
            contentPadding: EdgeInsets.zero,
          ),
          RadioListTile<DeliveryMethod>(
            title: Text('Доставкой CDEK', style: Styles.b1),
            value: DeliveryMethod.cdek,
            groupValue: orderState.deliveryMethod,
            onChanged: (value) => orderNotifier.setDeliveryMethod(value!),
            activeColor: Palette.primaryLime,
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 12),
          // --- Условные виджеты ---
          if (orderState.deliveryMethod == DeliveryMethod.onFestival)
            _buildFestivalPicker(),
          if (orderState.deliveryMethod == DeliveryMethod.cdek)
            _buildCdekDelivery(),
        ],
      ),
    );
  }

  Widget _buildFestivalPicker() {
    final selectedFestival = ref.watch(orderProvider).selectedFestival;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 12),
        Text("Выберите фестиваль*", style: Styles.b3),
        const SizedBox(height: 6),
        InkWell(
          onTap: () => _showFestivalSelection(context),
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
                    selectedFestival?.title ?? 'Нажмите для выбора',
                    style: selectedFestival == null
                        ? Styles.b2.copyWith(color: Palette.gray)
                        : Styles.b2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: Palette.gray),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCdekDelivery() {
    final orderNotifier = ref.read(orderProvider.notifier);
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Palette.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Стоимость доставки оплачивается отдельно во время получения.",
            style: Styles.b3.copyWith(color: Palette.gray),
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _addressController,
          label: 'Адрес доставки (Пункт CDEK или ваш адрес)*',
          hint: 'г. Москва, ул. Пушкина, д. 1',
          onChanged: orderNotifier.updateDeliveryAddress,
          validator: (val) => val!.isEmpty ? 'Укажите адрес' : null,
        ),
      ],
    );
  }

  Widget _buildSummaryAndPayButton(int totalPrice, OrderState orderState) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: Palette.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Итого:", style: Styles.h4),
              Text(Utils.formatMoney(totalPrice), style: Styles.h3),
            ],
          ),
          const SizedBox(height: 16),
          LTButtons.elevatedButton(
            onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Дополнительная валидация для способов доставки
                      if (orderState.deliveryMethod ==
                              DeliveryMethod.onFestival &&
                          orderState.selectedFestival == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Пожалуйста, выберите фестиваль')));
                        return;
                      }
                      ref
                          .read(orderProvider.notifier)
                          .placeOrderAndPay(context);
                    }
                  },
            child: Text(
              "Оплатить ${Utils.formatMoney(totalPrice)}",
              style: Styles.button1,
            ),
          ),
        ],
      ),
    );
  }
}
