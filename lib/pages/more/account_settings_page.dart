import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/data/models/user.dart';
import 'package:ltfest/providers/age_category_provider.dart';
import 'package:ltfest/providers/auth_state.dart';
import 'package:ltfest/providers/user_provider.dart';
import 'package:ltfest/router/app_routes.dart';
import '../../components/modal.dart';
import '../../data/models/age_category.dart';

class AccountSettingsPage extends ConsumerStatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  ConsumerState<AccountSettingsPage> createState() =>
      _AccountSettingsPageState();
}

class _AccountSettingsPageState extends ConsumerState<AccountSettingsPage> {
  int _selectedIndex = 0;
  bool _isLoading = false;
  AgeCategory? _selectedAgeCategory;

  final _emailController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _cityController = TextEditingController();
  final _educationController = TextEditingController();
  final _masterFioController = TextEditingController();
  final _collectiveNameController = TextEditingController();
  final _collectiveCityController = TextEditingController();
  final _collectiveAgeCategoryController = TextEditingController();
  final _collectiveCountParticipateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    final authState = ref.read(authNotifierProvider);
    if (authState.value is Authenticated) {
      final user = (authState.value as Authenticated).user;
      String formattedBirthDate;
      final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      final DateTime parsedDate =
          inputFormat.parse(user.birthdate!.toString().split(" ")[0]);
      final DateFormat outputFormat = DateFormat('dd.MM.yyyy');
      formattedBirthDate = outputFormat.format(parsedDate);

      _birthdayController.text = formattedBirthDate;
      _emailController.text = user.email!;
      _cityController.text = user.residence!;
      _educationController.text = user.educationPlace ?? '';
      _masterFioController.text = user.masterName ?? '';
      _collectiveNameController.text = user.collectiveName ?? '';
      _collectiveCityController.text = user.collectiveCity ?? '';
      _collectiveAgeCategoryController.text = user.ageCategory?.title ?? '';
      _collectiveCountParticipateController.text =
          user.countParticipant.toString() != "null"
              ? user.countParticipant.toString()
              : '';
      _selectedAgeCategory = user.ageCategory;
    }
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _educationController.dispose();
    _masterFioController.dispose();
    _collectiveNameController.dispose();
    _collectiveCityController.dispose();
    _collectiveAgeCategoryController.dispose();
    _collectiveCountParticipateController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _saveSettings() async {
    setState(() => _isLoading = true);

    final authNotifier = ref.read(authNotifierProvider.notifier);
    final authState = ref.read(authNotifierProvider);

    String formattedBirthDate;
    try {
      final DateFormat inputFormat = DateFormat('dd.MM.yyyy');
      final DateTime parsedDate = inputFormat.parse(_birthdayController.text);
      final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
      formattedBirthDate = outputFormat.format(parsedDate);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'Ошибка форматирования даты рождения. Проверьте поле.'),
            backgroundColor: Palette.error,
          ),
        );
      }
      setState(() => _isLoading = false);
      return;
    }

    if (authState.value is Authenticated) {
      final user = (authState.value as Authenticated).user;

      await authNotifier.updateProfileInfo(
        lastName: user.lastname!,
        firstName: user.firstname!,
        email: _emailController.text.trim(),
        birthDate: formattedBirthDate,
        residence: _cityController.text.trim(),
        activityId: user.activity?.id ?? 0,
        collectiveName: _collectiveNameController.text.trim(),
        collectiveCity: _collectiveCityController.text.trim(),
        educationPlace: _educationController.text.trim(),
        masterName: _masterFioController.text.trim(),
        countParticipant: _collectiveCountParticipateController.text.isEmpty
            ? 0
            : int.parse(_collectiveCountParticipateController.text.trim()),
        ageCategoryId: _selectedAgeCategory?.id,
      );
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Данные успешно сохранены!'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  void _showAgeCategoryPicker() {
    showModalPicker<AgeCategory>(
      context: context,
      title: 'Возрастная категория',
      provider: ageCategoryProvider,
      isNoNeedSize: true,
      itemBuilder: (ageCategory) => ageCategory.title,
      initialValue: _selectedAgeCategory,
      onConfirm: (ageCategory) {
        setState(() => _selectedAgeCategory = ageCategory);
        Navigator.pop(context);
      },
    );
  }

  void _showExitPopup(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: Palette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16)
              .copyWith(bottom: 16 + MediaQuery.of(context).padding.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 41,
                height: 4,
                decoration: BoxDecoration(
                  color: Palette.stroke,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 12),
              Text('Выход из аккаунта', style: Styles.h4),
              const SizedBox(height: 32),
              Text('Вы уверены, что хотите выйти из аккаунта?',
                  style: Styles.b1.copyWith(color: Palette.gray),
                  textAlign: TextAlign.center),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: LTButtons.elevatedButton(
                      onPressed: () {
                        context.pop();
                        ref.read(authNotifierProvider.notifier).logout();
                      },
                      backgroundColor: Palette.error,
                      foregroundColor: Palette.white,
                      child: Text("Выйти", style: Styles.button1),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LTButtons.outlinedButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        "Отмена",
                        style: Styles.button1.copyWith(color: Palette.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final user = (authState.value is Authenticated)
        ? (authState.value as Authenticated).user
        : null;

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LTAppBar(title: "Настройки аккаунта"),
                  _buildReadOnlySection(user!),
                  const SizedBox(height: 2),
                  Container(
                    width: double.infinity,
                    decoration: Decor.base,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        if (user.activity!.title == "Руководитель коллектива")
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: _CustomSegmentedControl(
                              selectedIndex: _selectedIndex,
                              onTap: _onTabTapped,
                            ),
                          ),
                        const SizedBox(height: 12),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Column(
                            children: [
                              Visibility(
                                visible: _selectedIndex == 0,
                                maintainState: true,
                                child: _AboutMeForm(
                                  birthdayController: _birthdayController,
                                  emailController: _emailController,
                                  cityController: _cityController,
                                  educationController: _educationController,
                                  masterFioController: _masterFioController,
                                ),
                              ),
                              Visibility(
                                visible: _selectedIndex == 1,
                                maintainState: true,
                                child: _CollectiveForm(
                                  collectiveNameController:
                                      _collectiveNameController,
                                  collectiveCityController:
                                      _collectiveCityController,
                                  showAgeCategoryPicker: _showAgeCategoryPicker,
                                  collectiveAgeCategoryController:
                                      _collectiveAgeCategoryController,
                                  collectiveCountParticipateController:
                                      _collectiveCountParticipateController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () => _showExitPopup(context, ref),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.only(
                          top: 24, bottom: 27, right: 12, left: 12),
                      decoration: Decor.base,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Выйти из аккаунта",
                              style:
                                  Styles.button2.copyWith(color: Palette.gray)),
                          SvgPicture.asset("assets/icons/exit_from_app.svg"),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.deleteAccount),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.only(
                          top: 24, bottom: 27, right: 12, left: 12),
                      child: Text(
                        "Удалить аккаунт",
                        style: Styles.button2.copyWith(color: Palette.gray),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70 + MediaQuery.of(context).padding.bottom,
                  ), // TODO: WTF WITH HEIGHT?
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.only(
                    bottom: 0, top: 24, left: 20, right: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: LTButtons.elevatedButton(
                    onPressed: _isLoading ? null : _saveSettings,
                    child: _isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Palette.black,
                            ),
                          )
                        : Text(
                            'Сохранить',
                            style: Styles.button1,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Кастомный переключатель ---
class _CustomSegmentedControl extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _CustomSegmentedControl(
      {required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Palette.background, // Светло-серый фон
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildTabItem(context, 'Обо мне', 0),
          const SizedBox(width: 8),
          _buildTabItem(context, 'Коллектив', 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, String title, int index) {
    final bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Palette.primaryLime : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: isSelected
                ? Styles.h5.copyWith(color: Palette.white)
                : Styles.b2.copyWith(color: Palette.gray),
          ),
        ),
      ),
    );
  }
}

class CitySearchField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isRequired;

  const CitySearchField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isRequired = true,
  });

  // ... _getCitySuggestions остается без изменений ...
  Future<List<String>> _getCitySuggestions(String pattern) async {
    final cities = [
      'Москва',
      'Санкт-Петербург',
      'Новосибирск',
      'Екатеринбург',
      'Казань',
      'Нижний Новгород'
    ];
    await Future.delayed(const Duration(milliseconds: 200));
    if (pattern.isEmpty) return [];
    return cities
        .where((city) => city.toLowerCase().startsWith(pattern.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Styles.b3.copyWith(color: Palette.gray)),
        const SizedBox(height: 6),
        TypeAheadField<String>(
          hideOnUnfocus: false,
          builder: (context, controller, focusNode) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              style: Styles.b2.copyWith(color: Palette.black),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: Styles.b2.copyWith(color: Palette.gray),
                labelStyle: Styles.b2.copyWith(color: Palette.gray),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Palette.stroke, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Palette.stroke, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Palette.primaryLime, width: 1.5)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Palette.error, width: 1)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Palette.error, width: 1.5)),
              ),
              onChanged: (value) => this.controller.text = value,
              validator: (value) {
                if (isRequired && (value == null || value.isEmpty)) {
                  return 'Обязательное поле';
                }
                return null;
              },
            );
          },
          controller: controller,
          suggestionsCallback: _getCitySuggestions,
          itemBuilder: (context, suggestion) {
            return ListTile(title: Text(suggestion));
          },
          onSelected: (suggestion) {
            // ИЗМЕНЕНИЕ 2: После выбора подсказки мы обновляем текст
            // и ВРУЧНУЮ убираем фокус, чтобы закрыть клавиатуру и список.
            controller.text = suggestion;
            FocusScope.of(context).unfocus();
          },
          emptyBuilder: (context) => const Padding(
            padding: EdgeInsets.all(12.0),
            child:
                Text('Город не найден', style: TextStyle(color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}

// --- Форма "Обо мне" ---
class _AboutMeForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController birthdayController;

  final TextEditingController cityController;
  final TextEditingController educationController;
  final TextEditingController masterFioController;

  const _AboutMeForm({
    required this.emailController,
    required this.cityController,
    required this.educationController,
    required this.masterFioController,
    required this.birthdayController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          DatePickerTextField(
            controller: birthdayController,
            label: 'Дата рождения*',
          ),
          const SizedBox(height: 16),
          _buildEditableField(label: 'Email', controller: emailController),
          const SizedBox(height: 16),
          CitySearchField(
              label: "Город проживания*",
              hint: "Город",
              controller: cityController,
              isRequired: false),
          const SizedBox(height: 16),
          _buildEditableField(
              label: 'Образование',
              hint: 'Место обучения',
              controller: educationController),
          const SizedBox(height: 16),
          _buildEditableField(
              label: 'ФИО мастера',
              hint: 'ФИО',
              controller: masterFioController),
        ],
      ),
    );
  }
}

Widget _buildModalSelectorField({
  required String label,
  required String? value,
  required String hint,
  required VoidCallback onTap,
  required FormFieldValidator<String> validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Styles.b3.copyWith(color: Palette.gray)),
      const SizedBox(height: 6),
      TextFormField(
        controller: TextEditingController(text: value ?? ''),
        readOnly: true,
        onTap: onTap,
        style: Styles.b2,
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: Styles.b2.copyWith(color: Palette.gray),
          suffixIcon: const Icon(Icons.chevron_right, size: 24),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.stroke, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.stroke, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.primaryLime, width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.error, width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.error, width: 1.5)),
        ),
        validator: validator,
      ),
    ],
  );
}

// --- Форма "Коллектив" ---
class _CollectiveForm extends StatelessWidget {
  final TextEditingController collectiveNameController;
  final TextEditingController collectiveCityController;
  final TextEditingController collectiveAgeCategoryController;
  final TextEditingController collectiveCountParticipateController;

  final VoidCallback showAgeCategoryPicker; // Добавляем параметр

  const _CollectiveForm({
    required this.collectiveNameController,
    required this.collectiveCityController,
    required this.collectiveAgeCategoryController,
    required this.collectiveCountParticipateController,
    required this.showAgeCategoryPicker,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_AccountSettingsPageState>();
    final selectedAgeCategory = state?._selectedAgeCategory;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          _buildEditableField(
            label: 'Название коллектива',
            controller: collectiveNameController,
            isRequired: false,
          ),
          const SizedBox(height: 16),
          _buildEditableField(
            label: 'Количество участников коллектива',
            controller: collectiveCountParticipateController,
            isRequired: false,
          ),
          const SizedBox(height: 16),
          _buildModalSelectorField(
            label: 'Возрастная категория',
            value: selectedAgeCategory?.title,
            hint: 'Выберите категорию',
            onTap: showAgeCategoryPicker,
            validator: (_) =>
                selectedAgeCategory == null ? 'Выберите категорию' : null,
          ),
          const SizedBox(height: 16),
          CitySearchField(
            label: "Местоположение коллектива",
            hint: "Город",
            controller: collectiveCityController,
            isRequired: false,
          ),
        ],
      ),
    );
  }
}

// --- Хелперы для полей ---

Widget _buildEditableField({
  required String label,
  required TextEditingController controller,
  String? hint,
  bool isRequired = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Styles.b3.copyWith(color: Palette.gray)),
      const SizedBox(height: 6),
      TextFormField(
        controller: controller,
        style: Styles.b2.copyWith(color: Palette.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Styles.b2.copyWith(color: Palette.gray),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Palette.stroke),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Palette.stroke),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Palette.primaryLime, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Palette.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Palette.error, width: 1.5),
          ),
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Обязательное поле';
                }
                return null;
              }
            : null,
      ),
    ],
  );
}

Widget _buildReadOnlySection(User user) {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: double.infinity,
    decoration: Decor.base,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          user.activity!.title,
          style: Styles.h5.copyWith(color: Palette.gray),
        ),
        const SizedBox(height: 12),
        Text(user.lastname!, style: Styles.h3),
        const SizedBox(height: 4),
        Text(
          Utils.phoneFormatter.maskText(user.phone!),
          style: Styles.b2.copyWith(color: Palette.gray),
        ),
      ],
    ),
  );
}

class DatePickerTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const DatePickerTextField(
      {super.key, required this.label, required this.controller});

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  late DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru');
    _dateFormat = DateFormat('dd.MM.yyyy', 'ru');
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      locale: const Locale('ru'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Palette.primaryLime.toMaterialColor(),
              errorColor: Palette.error,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      widget.controller.text = _dateFormat.format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Styles.b3.copyWith(color: Palette.gray)),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          readOnly: true,
          style: Styles.b2.copyWith(color: Palette.black),
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Выберите дату',
            hintStyle: Styles.b2.copyWith(color: Palette.gray),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset('assets/icons/calendar.svg')),
            ),
            suffixIconConstraints: const BoxConstraints(
              minHeight: 24,
              minWidth: 24,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Palette.stroke, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Palette.stroke, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Palette.primaryLime, width: 1.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Palette.error, width: 1)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Palette.error, width: 1.5)),
          ),
          onTap: () => _selectDate(context),
          validator: (value) =>
              (value == null || value.isEmpty) ? 'Выберите дату' : null,
        ),
      ],
    );
  }
}
