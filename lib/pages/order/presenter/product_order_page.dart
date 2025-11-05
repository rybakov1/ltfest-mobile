import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/festival.dart';
import 'package:ltfest/pages/cart/provider/cart_provider.dart';
import 'package:ltfest/pages/order/order_provider.dart';
import 'package:ltfest/providers/festival_provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/models/user.dart';
import '../../../providers/user_provider.dart';

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
    ref.read(orderProvider.notifier).reset(OrderType.products);
    final state = ref.read(orderProvider);
    _nameController = TextEditingController(text: state.payerName);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);
    _collectiveNameController =
        TextEditingController(text: state.collectiveName);
    _addressController = TextEditingController(text: state.deliveryAddress);
    loyaltyCardController = TextEditingController();
    promocodeController = TextEditingController();
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

    _showModalPicker<Festival>(
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

  Widget _buildShimmerList() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 300.0,
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 150.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showModalPicker<T>({
    required BuildContext context,
    required String title,
    required FutureProvider<List<T>> provider,
    required String Function(T) itemBuilder,
    T? initialValue,
    required ValueChanged<T?> onConfirm,
  }) {
    T? tempSelectedItem = initialValue;

    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (modalContext) {
        return Consumer(builder: (context, ref, child) {
          return SizedBox(
            height: 500,
            child: StatefulBuilder(
              builder: (context, setModalState) {
                final asyncValue = ref.watch(provider);

                final bool isItemSelected = tempSelectedItem != null;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: 24 + MediaQuery.of(context).viewPadding.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 4, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 40),
                            Expanded(
                              child: Text(title,
                                  textAlign: TextAlign.center,
                                  style: Styles.h4),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Palette.gray),
                              onPressed: () => Navigator.pop(modalContext),
                            ),
                          ],
                        ),
                      ),

                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: asyncValue.when(
                            loading: () => _buildShimmerList(),
                            error: (err, st) =>
                                Center(child: Text('Ошибка: $err')),
                            data: (items) {
                              if (items.isEmpty) {
                                return const Center(
                                    child: Text("Нет данных для выбора"));
                              }
                              // ListView теперь сам по себе, без shrinkWrap, т.к. Flexible дает ему границы
                              return ListView.builder(
                                shrinkWrap: true,
                                // Оставляем shrinkWrap для работы внутри Column + Flexible
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  return _buildRadioListTile<T>(
                                    title: itemBuilder(item),
                                    value: item,
                                    groupValue: tempSelectedItem,
                                    onChanged: (newValue) {
                                      setModalState(() {
                                        tempSelectedItem = newValue;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      // --- Футер модального окна (кнопка) ---
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: LTButtons.elevatedButton(
                            onPressed: isItemSelected
                                ? () => onConfirm(tempSelectedItem)
                                : null,
                            child: Text(
                              'Выбрать',
                              style: Styles.button1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
      },
    );
  }

// --- НОВЫЙ ХЕЛПЕР ДЛЯ СТИЛИЗОВАННОЙ RADIO-КНОПКИ ---

  Widget _buildRadioListTile<T>({
    required String title,
    required T value,
    required T? groupValue,
    required ValueChanged<T?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: Palette.secondary,
            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return Palette.secondary;
              }
              return Palette.stroke;
            }),
          ),
          const SizedBox(width: 0.0),
          // Контролируем расстояние между Radio и текстом
          Expanded(
            child: Text(title, style: Styles.b2),
          ),
        ],
      ),
    );
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
                    controller: loyaltyCardController,
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
                    controller: promocodeController,
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
                  child: Icon(Icons.arrow_forward_outlined,
                      color: Palette.white, size: 24),
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
          _buildRadioListTile(
            title: 'На фестивале',
            value: DeliveryMethod.onFestival,
            groupValue: orderState.deliveryMethod,
            onChanged: (value) => orderNotifier.setDeliveryMethod(value!),
          ),
          _buildRadioListTile(
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
          ref.read(orderProvider.notifier).placeOrderAndPay(context);
        },
        child: Text("Оплатить", style: Styles.button1),
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
