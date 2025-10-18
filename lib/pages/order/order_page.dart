import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/pages/order/order_provider.dart';
import 'package:ltfest/providers/festival_provider.dart';

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
  late final TextEditingController _loyaltyCardController;


  @override
  void initState() {
    super.initState();
    final initialState = ref.read(orderProvider);
    _nameController = TextEditingController(text: initialState.payerName);
    _emailController = TextEditingController(text: initialState.email);
    _phoneController = TextEditingController(text: initialState.phone);
    _collectiveController = TextEditingController(text: initialState.collectiveName);
    _addressController = TextEditingController(text: initialState.deliveryAddress);
    _loyaltyCardController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _collectiveController.dispose();
    _addressController.dispose();
    _loyaltyCardController.dispose();
    super.dispose();
  }

  void _showFestivalSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) => const FestivalsList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final totalPrice = ref.watch(cartTotalPriceProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 24, bottom: 16),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Оплата",
                                style: Styles.h4.copyWith(color: Palette.black),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 43,
                                width: 43,
                                decoration: Decor.base
                                    .copyWith(color: Palette.primaryLime),
                                child: IconButton(
                                  onPressed: () => context.pop(),
                                  icon: Icon(Icons.arrow_back,
                                      color: Palette.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              controller: _collectiveController,
                              label: "Название коллектива*",
                              hint: "Коллектив",
                              onChanged: orderNotifier.updateCollectiveName,
                            ),
                            const SizedBox(height: 16),
                            _buildDeliverySection(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        decoration: Decor.base,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _loyaltyCardController,
                                    label: "Карта лояльности",
                                    hint: "Введите номер карты",
                                    onChanged:
                                        orderNotifier.updateCollectiveName,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {},
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
                                Text(Utils.formatMoney(totalPrice),
                                    style: Styles.h4),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Скидка",
                                    style: Styles.b2
                                        .copyWith(color: Palette.secondary)),
                                Text(Utils.formatMoney(-0), style: Styles.h4),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Итого:", style: Styles.h4),
                                Text(Utils.formatMoney(totalPrice),
                                    style: Styles.h3),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
              _buildSummaryAndPayButton(totalPrice, orderState),
            ],
          ),
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

  Widget _buildDeliverySection() {
    final orderState = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);

    return Container(
      decoration: Decor.base,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Получение заказа", style: Styles.b2),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
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
        Text("Выбор фестиваля*", style: Styles.b3),
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
                    selectedFestival?.title ?? 'Выберите фестиваль',
                    style: selectedFestival == null
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

  Widget _buildCdekDelivery() {
    final orderNotifier = ref.read(orderProvider.notifier);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Palette.primaryLime.withValues(alpha: 0.1),
            border: Border.all(color: Palette.primaryLime),
            borderRadius: BorderRadius.circular(8),
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

  Widget _buildSummaryAndPayButton(int totalPrice, OrderState orderState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12))),
      child: Column(
        children: [
          LTButtons.elevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (orderState.deliveryMethod == DeliveryMethod.onFestival &&
                    orderState.selectedFestival == null) {
                  // TODO:
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Пожалуйста, выберите фестиваль'),
                    ),
                  );
                  return;
                }
                ref.read(orderProvider.notifier).placeOrderAndPay(context);
              }
            },
            child: Text("Оплатить", style: Styles.button1),
          ),
        ],
      ),
    );
  }
}

class FestivalsList extends ConsumerWidget {
  const FestivalsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(festivalsNotifierProvider());

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Ошибка: $err')),
      data: (data) {
        if (data.filteredFestivals.isEmpty) {
          return const Center(child: Text('Нет фестивалей'));
        }
        return RefreshIndicator(
          onRefresh: () =>
              ref.read(festivalsNotifierProvider().notifier).refresh(),
          child: ListView.builder(
            itemCount: data.filteredFestivals.length,
            itemBuilder: (_, i) {
              final f = data.filteredFestivals[i];
              return ListTile(title: Text(f.title));
            },
          ),
        );
      },
    );
  }
}
