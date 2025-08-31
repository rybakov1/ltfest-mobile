import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/providers/auth_state.dart';
import 'package:ltfest/providers/user_provider.dart';
import 'package:shimmer/shimmer.dart';

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

class AccountSettingsPage extends ConsumerStatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  ConsumerState<AccountSettingsPage> createState() =>
      _AccountSettingsPageState();
}

class _AccountSettingsPageState extends ConsumerState<AccountSettingsPage> {
  int _selectedIndex = 0;
  bool _isLoading = false;
  Direction? _selectedDirection;

  // Контроллеры для всех полей
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _educationController = TextEditingController();
  final _masterFioController = TextEditingController();
  final _collectiveNameController = TextEditingController();
  final _collectiveDirectionController = TextEditingController();
  final _collectiveCityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    // Получаем текущего пользователя и заполняем поля
    final authState = ref.read(authNotifierProvider);
    if (authState.value is Authenticated) {
      final user = (authState.value as Authenticated).user;

      _emailController.text = user.email!;
      _cityController.text = user.residence!;
      _educationController.text = user.educationPlace ?? '';
      _masterFioController.text = user.masterName ?? '';
      _collectiveNameController.text = user.collectiveName ?? '';
      _collectiveDirectionController.text = user.direction?.title ?? '';
      _collectiveCityController.text = user.collectiveCity ?? '';
      _collectiveDirectionController.text = user.direction?.title ?? '';
      _selectedDirection = user.direction;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _cityController.dispose();
    _educationController.dispose();
    _masterFioController.dispose();
    _collectiveNameController.dispose();
    _collectiveDirectionController.dispose();
    _collectiveCityController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _saveSettings() async {
    setState(() => _isLoading = true);
    // TODO: Здесь будет логика сохранения данных.
    // Вы будете вызывать метод из вашего authNotifier, например:
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final authState = ref.read(authNotifierProvider);
    if (authState.value is Authenticated) {
      final user = (authState.value as Authenticated).user;

      await authNotifier.updateProfileInfo(
          lastName: user.lastname!,
          firstName: user.firstname!,
          email: _emailController.text.trim(),
          birthDate: user.birthdate.toString(),
          residence: _cityController.text.trim(),
          directionId: _selectedDirection!.id,
          activityId: user.activity?.id ?? 0,
          collectiveName: _collectiveNameController.text.trim(),
          collectiveCity: _collectiveCityController.text.trim(),
          educationPlace: _educationController.text.trim(),
          masterName: _masterFioController.text.trim());
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final user = (authState.value is Authenticated)
        ? (authState.value as Authenticated).user
        : null;

    return Scaffold(
      backgroundColor: Palette.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 24 + MediaQuery.of(context).padding.top,
                      bottom: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Настройки аккаунта",
                          style: Styles.h3.copyWith(color: Palette.white),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 43,
                          width: 43,
                          decoration:
                              Decor.base.copyWith(color: Palette.primaryLime),
                          child: IconButton(
                            onPressed: () => context.pop(),
                            icon: Icon(Icons.arrow_back, color: Palette.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: Decor.base,
                  margin: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, top: 22, bottom: 26),
                        child: _CustomSegmentedControl(
                          selectedIndex: _selectedIndex,
                          onTap: _onTabTapped,
                        ),
                      ),
                      // const SizedBox(height: 24),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Column(
                          children: [
                            Visibility(
                              visible: _selectedIndex == 0,
                              maintainState: true,
                              child: _AboutMeForm(
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
                                collectiveDirectionController:
                                    _collectiveDirectionController,
                                collectiveCityController:
                                    _collectiveCityController,
                                showDirectionPicker: _showDirectionPicker,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],
                  ),
                ),
                _buildReadOnlySection(user),
                SizedBox(
                  height: 97 + MediaQuery.of(context).padding.bottom,
                ), // TODO: WTF WITH HEIGHT?
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
                top: 24,
                left: 20,
                right: 20,
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12)),
                  color: Colors.white),
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
      height: 40,
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
                ? Styles.button2.copyWith(color: Palette.white)
                : Styles.button2.copyWith(color: Palette.gray),
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
  final TextEditingController cityController;
  final TextEditingController educationController;
  final TextEditingController masterFioController;

  const _AboutMeForm({
    required this.emailController,
    required this.cityController,
    required this.educationController,
    required this.masterFioController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
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

// --- Форма "Коллектив" ---
class _CollectiveForm extends StatelessWidget {
  final TextEditingController collectiveNameController;
  final TextEditingController collectiveDirectionController;
  final TextEditingController collectiveCityController;
  final VoidCallback showDirectionPicker; // Добавляем параметр

  const _CollectiveForm({
    required this.collectiveNameController,
    required this.collectiveDirectionController,
    required this.collectiveCityController,
    required this.showDirectionPicker,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_AccountSettingsPageState>();
    final selectedDirection = state?._selectedDirection;

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
          _buildModalSelectorField(
            label: 'Направление*',
            value: selectedDirection?.title,
            hint: 'Выберите направление',
            onTap: showDirectionPicker,
            validator: (_) =>
                selectedDirection == null ? 'Выберите направление' : null,
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

Widget _buildReadOnlySection(dynamic user) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: Decor.base,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Основная информация',
            style: Styles.h5.copyWith(color: Palette.gray)),
        const SizedBox(height: 16),
        _buildReadOnlyField(
            'ФИО', '${user?.lastname ?? ''}'.trim()), //${user?.firstname ?? ''}
         Divider(color: Palette.stroke),
        _buildReadOnlyField('Номер телефона', formatPhoneNumber(user?.phone)),
        Divider(color: Palette.stroke),
        _buildReadOnlyField('Дата рождения',
            DateFormat('dd.MM.yyyy', 'ru').format(user?.birthdate)),
        Divider(color: Palette.stroke),
        _buildReadOnlyField('Сфера деятельности',
            user?.activity?.title.toString() ?? 'Не указана'),
      ],
    ),
  );
}

String formatPhoneNumber(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Не указан';
  }

  return Utils.phoneFormatter.maskText(phone);
}

Widget _buildReadOnlyField(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Styles.b3.copyWith(color: Palette.gray)),
        Text(value, style: Styles.b2.copyWith(color: Palette.black)),
      ],
    ),
  );
}
