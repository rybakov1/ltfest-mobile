import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/lt_appbar.dart';
import '../../../constants.dart';
import '../../../data/models/festival_tariff.dart';
import '../../../data/models/user.dart';
import '../../../providers/user_provider.dart';
import '../components/loyalty_promo_section.dart';
import '../order_provider.dart';

class FestivalOrderPage extends ConsumerStatefulWidget {
  final FestivalTariff tariff;

  const FestivalOrderPage({super.key, required this.tariff});

  @override
  ConsumerState<FestivalOrderPage> createState() => _FestivalOrderPageState();
}

class _FestivalOrderPageState extends ConsumerState<FestivalOrderPage> {
  final _formKey = GlobalKey<FormState>();
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
    Future.microtask(() => ref.read(orderProvider.notifier).startOrder(
          type: OrderType.festival,
          item: widget.tariff,
        ));
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
                              label: "Название коллектива",
                              hint: "Лопушки",
                              onChanged: orderNotifier.updateCollectiveName,
                              validator: (val) =>
                                  val!.isEmpty ? 'Обязательное поле' : null,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: _participantsNameController,
                              label: "Имя участника*",
                              hint: "Иван,",
                              onChanged: orderNotifier.updateParticipantNames,
                              validator: (val) =>
                                  val!.isEmpty ? 'Обязательное поле' : null,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Если участников несколько, напишите имена через запятую",
                              style: Styles.b3.copyWith(color: Palette.gray),
                            )
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
                              'Тариф "${widget.tariff.title}"',
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

  Widget _buildSummarySection(int totalPrice, OrderNotifier orderNotifier) {
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
              if (!_formKey.currentState!.validate()) {
                return;
              }
              orderNotifier.placeOrderAndPay(context, totalPrice);
            },
            child: Text("Оплатить ${Utils.formatMoney(totalPrice)}",
                style: Styles.button1),
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
