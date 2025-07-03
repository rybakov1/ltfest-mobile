import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/user_provider.dart';

class AuthorizationPage extends ConsumerStatefulWidget {
  const AuthorizationPage({super.key});

  @override
  ConsumerState<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends ConsumerState<AuthorizationPage> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool canAuth = false;
  bool isLoading = false;

  // Локальное состояние для управления кнопкой и индикатором загрузки
  bool _isLoading = false;

  // Локальное состояние для включения/выключения кнопки в реальном времени
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    // Слушаем изменения в поле, чтобы включать/выключать кнопку
    _phoneController.addListener(_updateCanSubmit);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_updateCanSubmit);
    _phoneController.dispose();
    super.dispose();
  }

  void _updateCanSubmit() {
    // Проверяем, соответствует ли текст в поле формату полного номера
    final isFullNumber = RegExp(r'^\+7 \(\d{3}\) \d{3}-\d{2}-\d{2}$')
        .hasMatch(_phoneController.text);
    if (isFullNumber != _canSubmit) {
      setState(() {
        _canSubmit = isFullNumber;
      });
    }
  }

  Future<void> _requestOtp() async {
    // Дополнительная проверка, если пользователь очень быстро нажал на кнопку
    if (!_canSubmit || _isLoading) return;

    // Валидируем форму. Если есть ошибки, метод прервется.
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);

    // Убираем все символы, кроме цифр, для отправки в API
    final phone = _phoneController.text.replaceAll(RegExp(r'\D'), '');

    try {
      await ref.read(authNotifierProvider.notifier).requestOtp(phone);

      if (mounted) {
        // Успешно запросили код, переходим на следующую страницу
        context.push(AppRoutes.inputCode, extra: phone);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при отправке кода: ${e.toString()}'),
            backgroundColor: Colors.red,
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 50,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: Decor.base,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Text("Авторизация", style: Styles.h2)),
                          const SizedBox(height: 24),
                          Text("Номер телефона",
                              style: Styles.b3.copyWith(color: Palette.gray)),
                          const SizedBox(height: 6),
                          PhoneInputField(
                            phoneController: _phoneController,
                            onValidationChanged: (isValid) {
                              setState(() {
                                canAuth = isValid;
                              });
                            },
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 46,
                            child: ElevatedButton(
                              onPressed: canAuth && !isLoading ? _requestOtp : null,
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: Palette.background,
                                disabledForegroundColor: Palette.gray,
                                backgroundColor: Palette.primaryLime,
                                foregroundColor: Palette.black,
                                elevation: 0,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide.none,
                                ),
                              ),
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Palette.black)
                                  : Text('Получить код', style: Styles.button1),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: Styles.b4.copyWith(color: Palette.gray),
                                children: [
                                  const TextSpan(
                                      text:
                                          'Нажимая на кнопку "Получить код", я принимаю условия '),
                                  TextSpan(
                                    text: 'пользовательского соглашения',
                                    style: TextStyle(color: Palette.secondary),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(Uri.parse(
                                            'https://example.com/terms-and-conditions'));
                                      },
                                  ),
                                  const TextSpan(text: ' и '),
                                  TextSpan(
                                    text: 'обработки персональных данных',
                                    style: TextStyle(color: Palette.secondary),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(Uri.parse(
                                            'https://example.com/privacy-policy'));
                                      },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneInputField extends StatefulWidget {
  final TextEditingController phoneController;
  final ValueChanged<bool> onValidationChanged;

  const PhoneInputField({
    super.key,
    required this.phoneController,
    required this.onValidationChanged,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  String? _errorText;
  final String _prefix = "+7 ";

  void _validatePhoneNumber(String value) {
    final phoneRegex = RegExp(r'^\+7 \(\d{3}\) \d{3}-\d{2}-\d{2}$');
    if (value.isEmpty || value == _prefix) {
      setState(() {
        _errorText = null;
        widget.onValidationChanged(false);
      });
    } else if (!phoneRegex.hasMatch(value)) {
      setState(() {
        _errorText = 'Неверный формат номера';
        widget.onValidationChanged(false);
      });
    } else {
      setState(() {
        _errorText = null;
        widget.onValidationChanged(true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.phoneController,
          keyboardType: TextInputType.phone,
          style: Styles.b2.copyWith(color: Palette.black),
          inputFormatters: [
            PhoneNumberFormatter(prefix: _prefix),
          ],
          decoration: InputDecoration(
            hintText: _prefix,
            prefix: const SizedBox(width: 16),
            isDense: true,
            suffixIcon: widget.phoneController.text.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/close.svg",
                        colorFilter:
                            ColorFilter.mode(Palette.stroke, BlendMode.srcIn),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.phoneController.clear();
                        });
                      },
                    ),
                  )
                : null,
            constraints: const BoxConstraints(minHeight: 43),
            errorStyle: Styles.b3.copyWith(color: Palette.error),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.stroke, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.stroke, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.primaryLime, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Palette.error, width: 1),
            ),
            errorText: _errorText,
          ),
          onChanged: _validatePhoneNumber,
        ),
      ],
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  final String prefix;

  PhoneNumberFormatter({required this.prefix});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final rawText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    String cleanedText = rawText;

    if (rawText.startsWith('7')) {
      cleanedText = rawText.substring(1);
    }

    final buffer = StringBuffer(prefix);
    int index = 0;

    for (int i = 0; i < cleanedText.length; i++) {
      if (index == 10) break;
      if (index == 0) buffer.write('(');
      if (index == 3) buffer.write(') ');
      if (index == 6) buffer.write('-');
      if (index == 8) buffer.write('-');
      buffer.write(cleanedText[i]);
      index++;
    }

    final formattedText = buffer.toString();
    final newCursorPosition = formattedText.length;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }
}

class LinkButton extends StatelessWidget {
  const LinkButton({super.key, required this.urlLabel, required this.url});

  final String urlLabel;
  final String url;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const Size(0, 0),
      ),
      onPressed: () {
        _launchUrl(url);
      },
      child: Text(
        urlLabel,
        style: Styles.b4.copyWith(color: Palette.secondary),
      ),
    );
  }
}
