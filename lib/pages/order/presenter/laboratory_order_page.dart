import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/laboratory_learning_type.dart';

import '../../../components/lt_appbar.dart';
import '../../../constants.dart';
import '../../../data/models/user.dart';
import '../../../providers/user_provider.dart';
import '../components/loyalty_promo_section.dart';
import '../order_provider.dart';

class LaboratoryOrderPage extends ConsumerStatefulWidget {
  final LearningType learningType;

  const LaboratoryOrderPage({super.key, required this.learningType});

  @override
  ConsumerState<LaboratoryOrderPage> createState() =>
      _LaboratoryOrderPageState();
}

class _LaboratoryOrderPageState extends ConsumerState<LaboratoryOrderPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _birthDateController;

  late final TextEditingController loyaltyCardController;
  late final TextEditingController promocodeController;

  late final TextEditingController _collectiveNameController;
  late final TextEditingController _cityController;
  late final TextEditingController _educationController;
  late final TextEditingController _collectiveInfoController;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(orderProvider.notifier).startOrder(
          type: OrderType.laboratory,
          item: widget.learningType,
        ));
    final state = ref.read(orderProvider);

    // ref.read(orderProvider.notifier).reset(OrderType.laboratory);
    final user = ref.read(userProvider);

    _nameController = TextEditingController(text: state.payerName);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);

    _birthDateController =
        TextEditingController(text: user?.birthdate.toString() ?? '');
    _cityController = TextEditingController(text: user?.residence ?? '');

    _collectiveNameController =
        TextEditingController(text: state.collectiveName);
    _educationController = TextEditingController();
    _collectiveInfoController = TextEditingController();

    loyaltyCardController = TextEditingController();
    promocodeController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _collectiveNameController.dispose();

    _birthDateController.dispose();
    _cityController.dispose();
    _educationController.dispose();
    _collectiveInfoController.dispose();

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
                      const LTAppBar(title: "Оплата участия"),
                      Container(
                        decoration: Decor.base,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    hint: "Email",
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
                                    hint: "+7 ",
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
                              controller: _birthDateController,
                              label: "Дата рождения",
                              hint: "дд.мм.гггг",
                              onChanged: (_) {}, // TODO: сохранить в state
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: _cityController,
                              label: "Город проживания",
                              hint: "Выберите город",
                              onChanged: (_) {},
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: _collectiveNameController,
                              label: "Название коллектива",
                              hint: "Лопушки",
                              onChanged: orderNotifier.updateCollectiveName,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: _educationController,
                              label: "Образование*",
                              hint: "Образование",
                              onChanged: (_) {},
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Где учились и ФИО мастера курса",
                              style: Styles.b3,
                            ),
                            const SizedBox(height: 16),
                            if (user?.activity!.title ==
                                "Руководитель коллектива")
                              _buildTextField(
                                controller: _collectiveInfoController,
                                label:
                                    "Руководителем какого коллектива/театра Вы являетесь? Сколько лет коллективу",
                                hint: "Название коллектива",
                                keyboardType: TextInputType.number,
                                onChanged: (_) {},
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
                                  orderNotifier.updateSeatCount(
                                      orderState.seatCount - 1);
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                            buildLoyaltyOrPromoSection(
                              context,
                              user!,
                              widget.learningType.type.toString(),
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
              _buildSummarySection(finalTotal, orderState, user),
            ],
          ),
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
          icon: Icon(Icons.remove_circle, size: 32, color: Palette.primaryLime),
          onPressed: onDecrease,
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

  Widget _buildSummarySection(
      int totalPrice, OrderState orderState, User? user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        children: [
          LTButtons.elevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
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
}
