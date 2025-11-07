// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../components/lt_appbar.dart';
// import '../../../constants.dart';
// import '../../../data/models/user.dart';
// import '../../../providers/user_provider.dart';
// import '../../cart/provider/cart_provider.dart';
// import '../order_provider.dart';
//
// class LaboratoryOrderPage extends ConsumerStatefulWidget {
//   const LaboratoryOrderPage({super.key});
//
//   @override
//   ConsumerState<LaboratoryOrderPage> createState() => _LaboratoryOrderPageState();
// }
//
// class _LaboratoryOrderPageState extends ConsumerState<LaboratoryOrderPage> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _nameController;
//   late final TextEditingController _emailController;
//   late final TextEditingController _phoneController;
//   late final TextEditingController _collectiveNameController;
//   late final TextEditingController _participantsNameController;
//   late int seats = 1;
//   late final TextEditingController _loyaltyController;
//
//   @override
//   void initState() {
//     super.initState();
//     ref.read(orderProvider.notifier).reset(OrderType.festival);
//     final state = ref.read(orderProvider);
//     final user = ref.read(userProvider);
//     _nameController = TextEditingController(text: state.payerName);
//     _emailController = TextEditingController(text: state.email);
//     _phoneController = TextEditingController(text: state.phone);
//     _collectiveNameController =
//         TextEditingController(text: state.collectiveName);
//     _participantsNameController = TextEditingController();
//     _loyaltyController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     // dispose всех контроллеров
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final orderState = ref.watch(orderProvider);
//     final orderNotifier = ref.read(orderProvider.notifier);
//     final totalPrice = ref.watch(cartTotalPriceProvider);
//     final user = ref.watch(userProvider);
//
//     return Scaffold(
//       backgroundColor: Palette.background,
//       body: Form(
//         key: _formKey,
//         child: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       const LTAppBar(title: "Оплата участия"),
//                       Container(
//                         decoration: Decor.base,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 20),
//                         margin: const EdgeInsets.symmetric(horizontal: 4),
//                         child: Column(
//                           children: [
//                             _buildTextField(
//                               controller: _nameController,
//                               label: "Имя плательщика*",
//                               hint: "Иванов Иван Иванович",
//                               onChanged: orderNotifier.updatePayerName,
//                               validator: (val) =>
//                               val!.isEmpty ? 'Обязательное поле' : null,
//                             ),
//                             const SizedBox(height: 16),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: _buildTextField(
//                                     controller: _emailController,
//                                     label: "Email*",
//                                     hint: "example@mail.com",
//                                     onChanged: orderNotifier.updateEmail,
//                                     keyboardType: TextInputType.emailAddress,
//                                     validator: (val) => val!.isEmpty
//                                         ? 'Обязательное поле'
//                                         : null,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: _buildTextField(
//                                     controller: _phoneController,
//                                     label: "Номер телефона*",
//                                     hint: "+7 (999) 999-99-99",
//                                     onChanged: orderNotifier.updatePhone,
//                                     keyboardType: TextInputType.phone,
//                                     validator: (val) => val!.isEmpty
//                                         ? 'Обязательное поле'
//                                         : null,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 16),
//                             _buildTextField(
//                               controller: _collectiveNameController,
//                               label: "Название коллектива",
//                               hint: "Лопушки",
//                               onChanged: orderNotifier.updateCollectiveName,
//                             ),
//                             const SizedBox(height: 16),
//                             _buildTextField(
//                               controller: _participantsNameController,
//                               label: "Имя участника(ов) (через запятую)",
//                               hint: "Иванов И.И., Петров П.П.",
//                               onChanged:
//                                   (_) {}, // TODO: сохранить в state при необходимости
//                             ),
//                             const SizedBox(height: 16),
//                             _buildSeatsCounter(
//                               label: "Количество мест",
//                               count: seats,
//                               onIncrease: () => setState(() => seats++),
//                               onDecrease: () => setState(() {
//                                 if (seats > 1) seats--;
//                               }),
//                             ),
//                             const SizedBox(height: 16),
//                             // Фестиваль выбор
//                             // _buildFestivalPicker(orderState, orderNotifier),
//                           ],
//                         ),
//                       ),
//                       _buildLoyaltyOrPromoSection(user!),
//                       // _buildSummarySection(totalPrice),
//                     ],
//                   ),
//                 ),
//               ),
//               _buildSummarySection(totalPrice, orderState, user),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSeatsCounter({
//     required String label,
//     required int count,
//     required VoidCallback onIncrease,
//     required VoidCallback onDecrease,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: Styles.b3),
//         const SizedBox(height: 6),
//         Row(
//           children: [
//             IconButton(
//               onPressed: onDecrease,
//               icon: const Icon(Icons.remove),
//               color: Palette.black,
//             ),
//             Text('$count', style: Styles.b1),
//             IconButton(
//               onPressed: onIncrease,
//               icon: const Icon(Icons.add),
//               color: Palette.black,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSummarySection(
//       int totalPrice, OrderState orderState, User? user) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Palette.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//       ),
//       child: Column(
//         children: [
//           LTButtons.elevatedButton(
//             onPressed: () {
//               if (!_formKey.currentState!.validate()) return;
//
//               // Валидация специфичных полей
//
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Пожалуйста, выберите фестиваль')),
//               );
//
//               // TODO: сохранить дополнительные поля (участники, дата рождения и т.д.)
//               // Пока просто инициируем оплату
//               ref.read(orderProvider.notifier).placeOrderAndPay(context);
//             },
//             child: Text("Оплатить", style: Styles.button1),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoyaltyOrPromoSection(User user) {
//     return Container(
//       decoration: Decor.base,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           if (user.activity?.title == "Руководитель коллектива") ...[
//             Expanded(
//               child: _buildTextField(
//                 controller: _loyaltyController,
//                 label: "Карта лояльности",
//                 hint: "Введите номер карты",
//                 onChanged: (_) {},
//               ),
//             ),
//           ] else ...[
//             Expanded(
//               child: _buildTextField(
//                 controller: _loyaltyController, // или отдельный промокод
//                 label: "Промокод",
//                 hint: "Введите промокод",
//                 onChanged: (_) {},
//               ),
//             ),
//           ],
//           const SizedBox(width: 8),
//           // кнопка применить
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required ValueChanged<String> onChanged,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: Styles.b3),
//         const SizedBox(height: 6),
//         TextFormField(
//           controller: controller,
//           onChanged: onChanged,
//           keyboardType: keyboardType,
//           validator: validator,
//           style: Styles.b2,
//           decoration: InputDecoration(
//             hintText: hint,
//             constraints: const BoxConstraints(maxHeight: 43),
//             hintStyle: Styles.b2.copyWith(color: Palette.gray),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//             filled: true,
//             fillColor: Palette.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Palette.stroke, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Palette.stroke, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Palette.primaryLime, width: 1),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// // остальные методы — как в общем OrderPage
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/lt_appbar.dart';
import '../../../constants.dart';
import '../../../data/models/user.dart';
import '../../../providers/user_provider.dart';
import '../../cart/provider/cart_provider.dart';
import '../order_provider.dart';

class LaboratoryOrderPage extends ConsumerStatefulWidget {
  const LaboratoryOrderPage({super.key});

  @override
  ConsumerState<LaboratoryOrderPage> createState() =>
      _LaboratoryOrderPageState();
}

class _LaboratoryOrderPageState extends ConsumerState<LaboratoryOrderPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _collectiveNameController;
  late final TextEditingController _participantsNameController;
  late int seats = 1;
  late final TextEditingController loyaltyCardController;
  late final TextEditingController promocodeController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _cityController;
  late final TextEditingController _educationPlaceController;
  late final TextEditingController _masterNameController;
  late final TextEditingController _collectiveAgeController;

  @override
  void initState() {
    super.initState();
    ref.read(orderProvider.notifier).reset(OrderType.festival);
    final state = ref.read(orderProvider);
    final user = ref.read(userProvider);

    _nameController = TextEditingController(text: state.payerName);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);
    _collectiveNameController =
        TextEditingController(text: state.collectiveName);
    _participantsNameController = TextEditingController();
    loyaltyCardController = TextEditingController();
    promocodeController = TextEditingController();

    _birthDateController =
        TextEditingController(text: user?.birthdate.toString() ?? '');
    _cityController = TextEditingController(text: user?.collectiveCity ?? '');
    _educationPlaceController =
        TextEditingController(text: user?.educationPlace ?? '');
    _masterNameController = TextEditingController(text: user?.masterName ?? '');
    _collectiveAgeController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _collectiveNameController.dispose();

    _participantsNameController.dispose();
    _birthDateController.dispose();
    _cityController.dispose();
    _educationPlaceController.dispose();
    _masterNameController.dispose();
    _collectiveAgeController.dispose();

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
                              controller: _educationPlaceController,
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
                                controller: _collectiveAgeController,
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
                      _buildLoyaltyOrPromoSection(user!, totalPrice),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 2),
              _buildSummarySection(totalPrice, orderState, user),
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
          onPressed: () {
            setState(() {
              seats--;
            });
          },
        ),
        const SizedBox(width: 10),
        Text('$seats', style: Styles.h4),
        const SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.add_circle, size: 32, color: Palette.primaryLime),
          onPressed: () {
            setState(() {
              seats++;
            });
          },
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

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Пожалуйста, выберите фестиваль')),
              );
              // TODO: сохранить дополнительные поля (участники, дата рождения и т.д.)
              ref.read(orderProvider.notifier).placeOrderAndPay(context, totalPrice);
            },
            child: Text("Оплатить", style: Styles.button1),
          ),
        ],
      ),
    );
  }

  Widget _buildLoyaltyOrPromoSection(User user, totalPrice) {
    return Container(
      decoration: Decor.base,
      padding: const EdgeInsets.only(right: 12, left: 12, top: 12, bottom: 20),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          _buildSeatsCounter(
            label: "Количество мест",
            count: seats,
            onIncrease: () => setState(() => seats++),
            onDecrease: () => setState(() {
              if (seats > 1) seats--;
            }),
          ),
          const SizedBox(height: 24),
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
