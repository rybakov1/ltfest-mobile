import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/providers/auth_state.dart';
import 'package:ltfest/providers/user_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AccountSettingsPage extends ConsumerStatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  ConsumerState<AccountSettingsPage> createState() =>
      _AccountSettingsPageState();
}

class _AccountSettingsPageState extends ConsumerState<AccountSettingsPage> {
  int _selectedIndex = 0;
  bool _isLoading = false;

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
      _educationController.text = '';
      _masterFioController.text = '';
      _collectiveNameController.text = user.collectiveName ?? '';
      _collectiveDirectionController.text = user.activityid.toString();
      _collectiveCityController.text = user.collectiveCity ?? '';
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
    // await ref.read(authNotifierProvider.notifier).updateProfile(
    //   email: _emailController.text,
    //   residence: _cityController.text,
    //   ... и так далее
    // );
    await Future.delayed(const Duration(seconds: 1)); // Имитация запроса

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
                            icon: Icon(Icons.arrow_back, color: Palette.black),
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
                SizedBox(height: 78 + MediaQuery.of(context).padding.bottom),
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
                  top: 16,
                  left: 16,
                  right: 16),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveSettings,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.primaryLime,
                      foregroundColor: Palette.black,
                      disabledBackgroundColor:
                          Palette.primaryLime.withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child:
                                CircularProgressIndicator(color: Palette.black))
                        : Text('Сохранить', style: Styles.button1),
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
        borderRadius: BorderRadius.circular(12),
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
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: isSelected
                ? Styles.button2.copyWith(color: Palette.black)
                : Styles.button2.copyWith(color: Palette.gray),
          ),
        ),
      ),
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
          _buildEditableField(
              label: 'Город проживания',
              controller: cityController,
              isTappable: true),
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

// --- Форма "Коллектив" ---
class _CollectiveForm extends StatelessWidget {
  final TextEditingController collectiveNameController;
  final TextEditingController collectiveDirectionController;
  final TextEditingController collectiveCityController;

  const _CollectiveForm({
    required this.collectiveNameController,
    required this.collectiveDirectionController,
    required this.collectiveCityController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          _buildEditableField(
              label: 'Название коллектива',
              controller: collectiveNameController),
          const SizedBox(height: 16),
          _buildEditableField(
              label: 'Направление',
              controller: collectiveDirectionController,
              isTappable: true),
          const SizedBox(height: 16),
          _buildEditableField(
              label: 'Местоположение коллектива',
              controller: collectiveCityController,
              isTappable: true),
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
  bool isTappable = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Styles.b3.copyWith(color: Palette.gray)),
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        readOnly: isTappable,
        style: Styles.b2,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.stroke)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.stroke)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.primaryLime, width: 1.5)),
          suffixIcon: isTappable
              ? Icon(Icons.arrow_forward_ios, size: 16, color: Palette.gray)
              : null,
        ),
        onTap: isTappable
            ? () {
                // TODO: Добавить логику для выбора (город, направление и т.д.)
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
        const Divider(),
        _buildReadOnlyField('Номер телефона', formatPhoneNumber(user?.phone)),
        const Divider(),
        _buildReadOnlyField('Дата рождения',
            DateFormat('dd.MM.yyyy', 'ru').format(user?.birthdate)),
        const Divider(),
        _buildReadOnlyField(
            'Сфера деятельности', user?.activityid.toString() ?? 'Не указана'),
      ],
    ),
  );
}

final _phoneFormatter = MaskTextInputFormatter(
  mask: '+# (###) ###-##-##',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

String formatPhoneNumber(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Не указан';
  }

  return _phoneFormatter.maskText(phone);
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
