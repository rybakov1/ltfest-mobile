import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ltfest/data/models/laboratory_order_args_model.dart';

import '../../../components/lt_appbar.dart';
import '../../../constants.dart';
import '../../../data/models/user.dart';
import '../../../providers/user_provider.dart';
import '../components/custom_text_fields.dart';
import '../components/loyalty_promo_section.dart';
import '../order_provider.dart';

@immutable
class LaboratoryFormValidationState {
  final bool isNameInvalid;
  final bool isEmailInvalid;
  final bool isPhoneInvalid;
  final bool isBirthdateInvalid;
  final bool isCollectiveNameInvalid;
  final bool isEducationInvalid;

  const LaboratoryFormValidationState({
    this.isNameInvalid = false,
    this.isEmailInvalid = false,
    this.isPhoneInvalid = false,
    this.isCollectiveNameInvalid = false,
    this.isBirthdateInvalid = false,
    this.isEducationInvalid = false,
  });

  bool get hasErrors =>
      isNameInvalid ||
      isEmailInvalid ||
      isPhoneInvalid ||
      isCollectiveNameInvalid ||
      isEducationInvalid ||
      isBirthdateInvalid;
}

final laboratoryFormValidationProvider =
    StateProvider<LaboratoryFormValidationState>(
        (ref) => const LaboratoryFormValidationState());

class LaboratoryOrderPage extends ConsumerStatefulWidget {
  final LaboratoryOrderArgsModel args;

  const LaboratoryOrderPage({super.key, required this.args});

  @override
  ConsumerState<LaboratoryOrderPage> createState() =>
      _LaboratoryOrderPageState();
}

class _LaboratoryOrderPageState extends ConsumerState<LaboratoryOrderPage> {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderProvider.notifier).startOrder(
            type: OrderType.laboratory,
            item: widget.args.learningType,
            laboratory: widget.args.laboratory,
          );

      // Обновляем контроллеры значениями из стейта, если они там уже есть
      final state = ref.read(orderProvider);
      final user = ref.read(userProvider);

      if (_nameController.text != state.payerName) {
        _nameController.text = state.payerName;
      }
      if (_emailController.text != state.email) {
        _emailController.text = state.email;
      }
      if (_phoneController.text != state.phone) {
        _phoneController.text = state.phone;
      }
      if (_birthDateController.text != state.birthdate) {
        _birthDateController.text = state.birthdate;
      }
      if (_cityController.text != (user?.residence ?? '')) {
        _cityController.text = user?.residence ?? '';
      }
      if (_collectiveNameController.text != state.collectiveName) {
        _collectiveNameController.text = state.collectiveName;
      }
    });

    // Инициализируем контроллеры пустыми значениями
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _birthDateController = TextEditingController();
    _cityController = TextEditingController();
    _collectiveNameController = TextEditingController();
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

  bool _validateForm() {
    final validationStateNotifier =
        ref.read(laboratoryFormValidationProvider.notifier);

    final newState = LaboratoryFormValidationState(
      isNameInvalid: _nameController.text.isEmpty,
      isEmailInvalid: _emailController.text.isEmpty,
      isPhoneInvalid: _phoneController.text.isEmpty,
      isEducationInvalid: _educationController.text.isEmpty,
      isBirthdateInvalid: _birthDateController.text.isEmpty,
      isCollectiveNameInvalid: _collectiveNameController.text.isEmpty,
    );

    validationStateNotifier.state = newState;
    return !newState.hasErrors;
  }

  void _resetValidationState() {
    if (ref.read(laboratoryFormValidationProvider).hasErrors) {
      ref.read(laboratoryFormValidationProvider.notifier).state =
          const LaboratoryFormValidationState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);
    final user = ref.watch(userProvider);

    final validationState = ref.watch(laboratoryFormValidationProvider);

    final baseTotal = ref.watch(orderBasePriceProvider);
    final serviceFee = ref.watch(orderServiceFeeProvider);
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
                    const LTAppBar(title: "Оплата участия"),
                    Container(
                      decoration: Decor.base,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            controller: _birthDateController,
                            label: "Дата рождения*",
                            hint: "дд.мм.гггг",
                            func: _resetValidationState,
                            onChanged: orderNotifier.updateBirthdate,
                            isInvalid: validationState.isBirthdateInvalid,
                          ),
                          const SizedBox(height: 16),
                          buildTextField(
                            controller: _cityController,
                            label: "Город проживания*",
                            hint: "Выберите город",
                            func: _resetValidationState,
                            onChanged: orderNotifier.updateResidence,
                          ),
                          const SizedBox(height: 16),
                          buildTextField(
                            controller: _collectiveNameController,
                            label: "Название коллектива*",
                            hint: "Название коллектива",
                            func: _resetValidationState,
                            onChanged: orderNotifier.updateCollectiveName,
                            isInvalid: validationState.isCollectiveNameInvalid,
                          ),
                          const SizedBox(height: 16),
                          buildTextField(
                            controller: _educationController,
                            label: "Образование*",
                            hint: "Образование",
                            onChanged: orderNotifier.updateEducation,
                            func: _resetValidationState,
                            isInvalid: validationState.isEducationInvalid,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Где учились и ФИО мастера курса",
                            style: Styles.b3,
                          ),
                          const SizedBox(height: 16),
                          // if (user?.activity!.title ==
                          //     "Руководитель коллектива")
                          //   buildTextField(
                          //     controller: _collectiveInfoController,
                          //     label:
                          //         "Руководителем какого коллектива/театра Вы являетесь? Сколько лет коллективу",
                          //     hint: "Название коллектива",
                          //     keyboardType: TextInputType.number,
                          //     func: _resetValidationState,
                          //     onChanged: orderNotifier.updateCollectiveInfo,
                          //   ),
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
                                orderNotifier
                                    .updateSeatCount(orderState.seatCount - 1);
                              }
                            },
                          ),
                          const SizedBox(height: 24),
                          buildLoyaltyOrPromoSection(
                            context,
                            user!,
                            widget.args.learningType.type.toString(),
                            ref,
                            loyaltyCardController,
                            promocodeController,
                            cartTotal: baseTotal,
                            finalTotal: finalTotal,
                            serviceFee: serviceFee,
                            serviceMultiplier: orderState.seatCount,
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
          icon: Icon(Icons.remove_circle,
              size: 32,
              color: count > 1 ? Palette.primaryLime : Palette.stroke),
          onPressed: count > 1 ? onDecrease : null,
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
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Palette.primaryLime.withValues(alpha: 0.1),
              border: Border.all(color: Palette.primaryLime),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Center(
                child:
                    Text("Рекомендуем оплачивать через СБП", style: Styles.b2)),
          ),
          const SizedBox(height: 8),
          LTButtons.elevatedButton(
            onPressed: () {
              // Используем новый метод валидации
              if (!_validateForm()) return;
              ref
                  .read(orderProvider.notifier)
                  .placeOrderAndPay(context, totalPrice, ref.read(orderBasePriceProvider));
            },
            child: Text("Оплатить", style: Styles.button1),
          ),
        ],
      ),
    );
  }
}
