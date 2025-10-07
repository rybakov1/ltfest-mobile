import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/router/app_routes.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

import '../../providers/auth_state.dart';
import '../../providers/user_provider.dart';

class InputCodePage extends ConsumerStatefulWidget {
  const InputCodePage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  ConsumerState<InputCodePage> createState() => _InputCodePageState();
}

class _InputCodePageState extends ConsumerState<InputCodePage> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  int _timerSeconds = 120;
  Timer? _timer;
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pinFocusNode.requestFocus();
    });
    _pinController.addListener(() {
      if (_hasError && _pinController.text.isNotEmpty) {
        setState(() {
          _hasError = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  Future<void> _resendOtp() async {
    if (_isLoading || _timerSeconds > 0) return;

    setState(() => _isLoading = true);
    _pinController.clear();
    _pinFocusNode.requestFocus();

    try {
      // 3. Исправленная логика: просто запрашиваем код
      await ref
          .read(authNotifierProvider.notifier)
          .requestOtp(widget.phoneNumber);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Новый код был отправлен на ваш номер.'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _timerSeconds = 120; // Сбрасываем таймер
          _startTimer();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Не удалось отправить код: ${e.toString()}")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getFormattedTime() {
    final minutes = (_timerSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_timerSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _verifyOtp() async {
    if (_isLoading) return;

    final code = _pinController.text.trim();
    if (code.length < 6) {
      setState(() {
        _hasError = true; // короткий код
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false; // очищаем ошибку перед попыткой
    });

    await ref
        .read(authNotifierProvider.notifier)
        .verifyOtpAndLogin(widget.phoneNumber, code);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // ВАЖНО: проверяем результат проверки кода
    final authState = ref.read(authNotifierProvider).value;
    if (authState is Unauthenticated) {
      setState(() {
        _hasError = true; // неверный код → показываем текст под Pinput
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthState>>(authNotifierProvider, (previous, next) {
      final authState = next.value;
      if (authState is NeedsRegistration) {
        context.push(AppRoutes.registration);
      } else if (authState is Authenticated) {
        context.go(AppRoutes.home);
      }
    });

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 56,
      textStyle: Styles.h2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: Palette.primaryLime, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: Palette.error, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 20, bottom: 20),
                child: Container(
                  height: 43,
                  width: 43,
                  decoration: Decor.base.copyWith(color: Palette.primaryLime),
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.arrow_back, color: Palette.white),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: Decor.base,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text('Введите код из СМС', style: Styles.h3)),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          'Отправили код на номер ${Utils.phoneFormatter.maskText(widget.phoneNumber)}',
                          style: Styles.b2.copyWith(color: Palette.gray),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Pinput(
                          controller: _pinController,
                          focusNode: _pinFocusNode,
                          length: 6,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          errorPinTheme: errorPinTheme,
                          showCursor: true,
                          forceErrorState: _hasError,
                          onCompleted: (pin) => _verifyOtp(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            "Неверный код",
                            style: Styles.b3.copyWith(color: Palette.error),
                          ),
                        ),
                      const SizedBox(height: 32),
                      if (_timerSeconds > 0)
                        Center(
                          child: Text(
                            'Отправить код ещё раз через ${_getFormattedTime()}',
                            style: Styles.button2
                                .copyWith(color: Palette.grayTimer),
                          ),
                        )
                      else
                        Center(
                          child: TextButton(
                            onPressed: _isLoading ? null : _resendOtp,
                            child: Text(
                              'Отправить код еще раз',
                              style: Styles.button2
                                  .copyWith(color: Palette.secondary),
                            ),
                          ),
                        ),
                      const Spacer(),
                      LTButtons.elevatedButton(
                        onPressed: _isLoading ? null : _verifyOtp,
                        child: _isLoading
                            ? CircularProgressIndicator(color: Palette.black)
                            : Text('Продолжить', style: Styles.button1),
                      ),
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
}
