import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/lt_appbar.dart';
import '../../constants.dart';
import '../../data/services/api_service.dart';
import '../../providers/auth_state.dart';
import '../../providers/user_provider.dart';

class DeleteAccountPage extends ConsumerStatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  ConsumerState<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends ConsumerState<DeleteAccountPage> {
  final _formKey = GlobalKey<FormState>(); // Ключ для формы
  final _fioController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _reasonController = TextEditingController();

  bool _isLoading = false; // Состояние загрузки

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    final authState = ref.read(authNotifierProvider);
    if (authState.value is Authenticated) {
      final user = (authState.value as Authenticated).user;
      _fioController.text = user.lastname ?? '';
      _emailController.text = user.email ?? '';
      _phoneController.text = user.phone ?? '';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fioController.dispose();
    _phoneController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _deleteAccount() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final authState = ref.read(authNotifierProvider);
    if (authState.value is! Authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ошибка авторизации')),
      );
      return;
    }
    final user = (authState.value as Authenticated).user;

    setState(() => _isLoading = true);

    try {
      await ref.read(apiServiceProvider).createAccountDeletionRequest(
            userId: user.id,
            reason: _reasonController.text,
          );

      if (!mounted) return;

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('Запрос отправлен'),
          content: const Text(
            'Ваш запрос на удаление аккаунта принят в обработку. '
            'Менеджер свяжется с вами или удалит данные в течение 30 дней. '
            'Сейчас будет выполнен выход из аккаунта.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('ОК'),
            ),
          ],
        ),
      );

      // 5. Логаут и редирект
      await ref.read(authNotifierProvider.notifier).logout();
      if (mounted) {
        // Или context.go('/auth'), зависит от твоего роутера
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка: ${e.toString()}'),
          backgroundColor: Palette.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                // Обернули в Form
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LTAppBar(title: "Удаление аккаунта"),
                    const SizedBox(height: 2),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      decoration: Decor.base,
                      child: Column(
                        children: [
                          Text(
                              "Вы собираетесь подать запрос на полное удаление вашего аккаунта...",
                              style: Styles.b2),
                          const SizedBox(height: 24),
                          // Поля делаем readOnly, так как юзер просто подтверждает свои данные
                          _buildEditableField(
                              label: 'Ваше Имя',
                              controller: _fioController,
                              readOnly: true),
                          const SizedBox(height: 16),
                          _buildEditableField(
                              label: 'Email',
                              controller: _emailController,
                              readOnly: true),
                          const SizedBox(height: 16),
                          _buildEditableField(
                              label: 'Номер телефона',
                              controller: _phoneController,
                              readOnly: true),
                          const SizedBox(height: 16),
                          _buildEditableField(
                            label: 'Напишите причину удаления*',
                            controller: _reasonController,
                            isRequired: true, // Причина обязательна
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 100 + MediaQuery.of(context).padding.bottom),
                  ],
                ),
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
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : LTButtons.elevatedButton(
                          backgroundColor: Palette.error,
                          onPressed: _deleteAccount, // Привязали метод
                          child: Text(
                            'Удалить аккаунт',
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

// Немного обновим виджет поля для поддержки readOnly и maxLines
Widget _buildEditableField({
  required String label,
  required TextEditingController controller,
  String? hint,
  bool isRequired = false,
  bool readOnly = false,
  int maxLines = 1,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Styles.b3.copyWith(color: Palette.gray)),
      const SizedBox(height: 6),
      TextFormField(
        controller: controller,
        readOnly: readOnly,
        maxLines: maxLines,
        style:
            Styles.b2.copyWith(color: readOnly ? Palette.gray : Palette.black),
        decoration: InputDecoration(
          hintText: hint,
          filled: readOnly,
          fillColor:
              readOnly ? Colors.grey.withValues(alpha: 0.1) : Colors.transparent,
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
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Обязательное поле';
                }
                return null;
              }
            : null,
      ),
    ],
  );
}
