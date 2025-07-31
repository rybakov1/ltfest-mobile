import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ltfest/providers/user_provider.dart';
import 'package:ltfest/constants.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/models/activity.dart';
import '../../data/models/direction.dart';
import '../../data/services/api_service.dart';

final directionsProvider =
    FutureProvider.autoDispose<List<Direction>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  try {
    // Добавляем таймаут на 10 секунд
    final directions = await api.getDirections().timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw TimeoutException(
            'Запрос к API directions превысил время ожидания');
      },
    );
    print('Directions loaded: ${directions.length}'); // Отладка
    return directions;
  } catch (e, stackTrace) {
    print('Error in directionsProvider: $e\n$stackTrace'); // Отладка
    rethrow; // Пробрасываем ошибку для обработки в asyncValue.when
  }
});

final activitiesProvider =
    FutureProvider.autoDispose<List<Activity>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  try {
    // Добавляем таймаут на 10 секунд
    final activities = await api.getActivities().timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw TimeoutException(
            'Запрос к API activities превысил время ожидания');
      },
    );
    print('Activities loaded: ${activities.length}'); // Отладка
    return activities;
  } catch (e, stackTrace) {
    print('Error in activitiesProvider: $e\n$stackTrace'); // Отладка
    rethrow; // Пробрасываем ошибку для обработки в asyncValue.when
  }
});

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();

  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _patronymicController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _emailController = TextEditingController();
  final _residenceCityController = TextEditingController(); // Город проживания
  final _collectiveNameController = TextEditingController();
  final _collectiveCityController = TextEditingController(); // Город коллектива

  Direction? _selectedDirection;
  Activity? _selectedActivity;

  var isSecondStep = false;

  bool _isSecondStep = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _patronymicController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _residenceCityController.dispose();
    _collectiveNameController.dispose();
    _collectiveCityController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    final currentFormKey = _isSecondStep ? _formKeyStep2 : _formKeyStep1;

    if (!(currentFormKey.currentState?.validate() ?? false)) {
      return;
    }

    if (_isSecondStep) {
      await _submitRegistration();
    } else {
      setState(() {
        _isSecondStep = true;
      });
    }
  }

  void _goBackToStep1() {
    setState(() => _isSecondStep = false);
  }

  Future<void> _submitRegistration() async {
    setState(() => _isLoading = true);

    final authNotifier = ref.read(authNotifierProvider.notifier);

    try {
      await authNotifier.completeRegistration(
        lastName: _lastNameController.text.trim(),
        firstName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        birthDate: _birthDateController.text,
        residence: _residenceCityController.text.trim(),
        directionId: _selectedDirection!.id,
        activityId: _selectedActivity!.id,
        collectiveName: _collectiveNameController.text.trim(),
        collectiveCity: _collectiveCityController.text.trim(),
      );
      // GoRouter сам обработает переход на главный экран после смены состояния
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка регистрации: ${e.toString()}'),
            backgroundColor: Palette.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.black,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 43,
                      width: 43,
                      decoration: Decor.base.copyWith(color: Palette.primaryLime),
                      child: IconButton(
                        onPressed: () {
                          if (isSecondStep) {
                            setState(() => isSecondStep = false);
                          } else {
                            ref.read(authNotifierProvider.notifier).logout();
                          }
                        },
                        icon: Icon(Icons.arrow_back, color: Palette.white),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Регистрация',
                      textAlign: TextAlign.left,
                      style: Styles.h3.copyWith(color: Palette.white),
                    ),
                    const Spacer(),
                    const SizedBox(width: 43),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: Decor.base,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                          child: Form(
                            key: _formKeyStep1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildStepIndicator(),
                                const SizedBox(height: 32),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(opacity: animation, child: child);
                                  },
                                  child: _isSecondStep
                                      ? _buildSecondStepFields()
                                      : _buildFirstStepFields(),
                                ),
                                const SizedBox(height: 100), // Пространство для прокрутки
                              ],
                            ),
                          ),
                        ),
                      ),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    if (_isSecondStep) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submitRegistration,
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.primaryLime,
                foregroundColor: Palette.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide.none,
                ),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Palette.black)
                  : Text('Зарегистрироваться', style: Styles.button1),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: _isLoading ? null : _goBackToStep1,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Palette.stroke),
                foregroundColor: Palette.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide.none,
                ),
              ),
              child: Text('Назад', style: Styles.button1),
            ),
          ),
        ],
      );
    } else {
      // Одна кнопка на первом шаге
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: _handleContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.primaryLime,
            foregroundColor: Palette.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide.none,
            ),
          ),
          child: Text('Продолжить', style: Styles.button1),
        ),
      );
    }
  }

  Widget _buildStepIndicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _isSecondStep
                  ? 'Расскажите о своем коллективе'
                  : 'Заполните информацию о себе',
              style: Styles.h5.copyWith(color: Palette.gray),
            ),
            Text(_isSecondStep ? 'Шаг 2/2' : 'Шаг 1/2',
                style: Styles.b2.copyWith(color: Palette.gray)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 4,
                decoration: ShapeDecoration(
                  color: Palette.primaryPink,
                  shape: const StadiumBorder(),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 4,
                decoration: ShapeDecoration(
                    color: _isSecondStep ? Palette.primaryPink : Palette.stroke,
                    shape: const StadiumBorder()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFirstStepFields() {
    return Column(
      key: const ValueKey('step1'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextFormField('ФИО*', "Ваше имя", _lastNameController),
        // const SizedBox(height: 16),
        // _buildTextFormField('Имя*', "Иван", _firstNameController),
        // const SizedBox(height: 16),
        // _buildTextFormField('Отчество', "Иванович", _patronymicController,
        //     isRequired: false),
        const SizedBox(height: 16),
        DatePickerTextField(
            label: "Дата рождения*", controller: _birthDateController),
        const SizedBox(height: 16),
        _buildTextFormField("Email*", "Email", _emailController,
            keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 16),
        CitySearchField(
            label: "Город проживания*",
            hint: "Город",
            controller: _residenceCityController,
            isRequired: false),
      ],
    );
  }

  Widget _buildSecondStepFields() {
    return Column(
      key: const ValueKey('step2'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 4. Поля на втором шаге
        // Направление (модальное окно)
        _buildModalSelectorField(
          label: 'Направление*',
          value: _selectedDirection?.title,
          hint: 'Выберите направление',
          onTap: () => _showDirectionPicker(),
          validator: (_) =>
              _selectedDirection == null ? 'Выберите направление' : null,
        ),
        const SizedBox(height: 16),
        // Сфера деятельности (модальное окно)
        _buildModalSelectorField(
          label: 'Сфера деятельности*',
          value: _selectedActivity?.title,
          hint: 'Выберите сферу',
          onTap: () => _showActivityPicker(),
          validator: (_) => _selectedActivity == null ? 'Выберите сферу' : null,
        ),
        const SizedBox(height: 16),
        _buildTextFormField(
            'Название коллектива', "Название", _collectiveNameController,
            isRequired: false),
        const SizedBox(height: 16),
        CitySearchField(
            label: "Город коллектива",
            hint: "Начните вводить город",
            controller: _collectiveCityController,
            isRequired: false),
      ],
    );
  }

  Widget _buildTextFormField(
      String label, String hint, TextEditingController controller,
      {TextInputType? keyboardType, int maxLines = 1, bool isRequired = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Styles.b3.copyWith(color: Palette.gray)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: Styles.b2.copyWith(color: Palette.black),
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: Styles.b2.copyWith(color: Palette.gray),
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
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'Обязательное поле';
            }
            if (label.contains("Email") &&
                (value != null &&
                    value.isNotEmpty &&
                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value))) {
              return 'Неверный формат email';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _showDirectionPicker() {
    _showModalPicker<Direction>(
      context: context,
      title: 'Направление',
      provider: directionsProvider,
      itemBuilder: (direction) => direction.title,
      // Передаем текущее выбранное значение для инициализации
      initialValue: _selectedDirection,
      onConfirm: (direction) {
        // Обновляем состояние страницы, когда пользователь нажимает "Выбрать"
        setState(() => _selectedDirection = direction);
        Navigator.pop(context);
      },
    );
  }

  void _showActivityPicker() {
    _showModalPicker<Activity>(
      context: context,
      title: 'Сфера деятельности',
      provider: activitiesProvider,
      itemBuilder: (activity) => activity.title,
      initialValue: _selectedActivity,
      onConfirm: (activity) {
        setState(() => _selectedActivity = activity);
        Navigator.pop(context);
      },
    );
  }

// --- ОБНОВЛЕННЫЙ ОБЩИЙ ХЕЛПЕР ДЛЯ МОДАЛЬНЫХ ОКОН ---

  void _showModalPicker<T>({
    required BuildContext context,
    required String title,
    required AutoDisposeFutureProvider<List<T>> provider,
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
          return StatefulBuilder(
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
                    // --- Шапка модального окна ---
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 4, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 40),
                          Expanded(
                            child: Text(title,
                                textAlign: TextAlign.center, style: Styles.h4),
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
                        child: ElevatedButton(
                          onPressed: isItemSelected
                              ? () => onConfirm(tempSelectedItem)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Palette.primaryLime,
                            disabledBackgroundColor: Palette.stroke,
                            foregroundColor: Palette.white,
                            disabledForegroundColor: Palette.gray,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text('Выбрать', style: Styles.button1),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
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
          const SizedBox(width: 0.0), // Контролируем расстояние между Radio и текстом
          Expanded(
            child: Text(title, style: Styles.b2),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 300.0, // Ограничиваем высоту шиммера
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          // Отключаем прокрутку внутри шиммера
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
                        // Используем фиксированную ширину вместо MediaQuery
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
}
// --- ВИДЖЕТЫ-ХЕЛПЕРЫ ДЛЯ ПОЛЕЙ ---

// Общий виджет для полей, которые открывают модальное окно
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
        style: Styles.b2.copyWith(color: Palette.gray),
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

// Виджет для поиска города с подсказками
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
    _dateFormat = DateFormat('yyyy-MM-dd', 'ru');
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      locale: const Locale('ru'),
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
            // Icon(Icons.calendar_month, color: Palette.gray),
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

class CitySearch extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const CitySearch(this.label, this.hint,
      {super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Реализовано как простое текстовое поле, как в исходном коде после комментирования TypeAhead
    return _buildTextFormField(label, hint, controller);
  }

  Widget _buildTextFormField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Styles.b3.copyWith(color: Palette.gray)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          style: Styles.b2.copyWith(color: Palette.black),
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: Styles.b2.copyWith(color: Palette.gray),
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
          validator: (value) =>
              (value == null || value.isEmpty) ? 'Обязательное поле' : null,
        ),
      ],
    );
  }
}
