import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ltfest/components/modal.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/features/support/presentation/providers/support_provider.dart';
import 'package:ltfest/providers/user_provider.dart';
import 'package:ltfest/router/app_routes.dart';

const List<String> _supportReasons = [
  'Нашёл(а) ошибку в приложении',
  'Ошибка при оплате',
  'Предложение по улучшению',
  'Другое',
];

final supportReasonsProvider = FutureProvider<List<String>>((ref) async {
  return _supportReasons;
});

class SupportPage extends ConsumerStatefulWidget {
  const SupportPage({super.key});

  @override
  ConsumerState<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends ConsumerState<SupportPage> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _commentController = TextEditingController();

  String? _selectedReason;
  final List<String> _selectedFiles = [];
  bool _showRequiredErrors = false;

  final _phoneFormatter = MaskTextInputFormatter(
    mask: '+7(###)###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    if (user != null) {
      _emailController.text = user.email ?? '';
      _phoneController.text = _formatPhoneForDisplay(user.phone ?? '');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_selectedFiles.length >= 3) return;

    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _selectedFiles.add(image.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  String _formatPhoneForDisplay(String raw) {
    final alreadyFormatted =
        RegExp(r'^\+7 \(\d{3}\) \d{3}-\d{2}-\d{2}$').hasMatch(raw);
    if (alreadyFormatted) return raw;

    var digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('7') && digits.length == 11) {
      digits = digits.substring(1);
    }

    if (digits.length != 10) return raw;
    return _phoneFormatter.maskText(digits);
  }

  Future<void> _submit() async {
    setState(() => _showRequiredErrors = true);

    final hasErrors = _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _selectedReason == null;
    if (hasErrors) return;

    await ref.read(supportProvider.notifier).submit(
          email: _emailController.text,
          phone: _phoneController.text,
          reason: _selectedReason!,
          message: _commentController.text,
          filePaths: _selectedFiles,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(supportProvider);

    ref.listen(supportProvider, (previous, next) {
      if (next is AsyncData && previous is AsyncLoading) {
        context.go(AppRoutes.supportSuccess);
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: ${next.error}')),
        );
      }
    });

    return Scaffold(
      backgroundColor: Palette.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const LTAppBar(title: "Написать в поддержку"),
                  Container(
                    decoration: Decor.base,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                "Email*",
                                _emailController,
                                "email@mail.com",
                                enabled: false,
                                errorText: _showRequiredErrors &&
                                        _emailController.text.isEmpty
                                    ? 'Обязательное поле'
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildTextField("Номер телефона*",
                                  _phoneController, "+79099990011",
                                  formatter: _phoneFormatter,
                                  enabled: false,
                                  errorText: _showRequiredErrors &&
                                          _phoneController.text.isEmpty
                                      ? 'Обязательное поле'
                                      : null),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildLabel("Причина обращения*"),
                        _buildReasonModalPicker(
                          errorText:
                              _showRequiredErrors && _selectedReason == null
                                  ? 'Обязательное поле'
                                  : null,
                        ),
                        const SizedBox(height: 16),
                        _buildLabel("Комментарий"),
                        _buildCommentField(),
                        const SizedBox(height: 24),
                        _buildLabel(
                            "Добавьте вложение (Скриншот или запись экрана)"),
                        const SizedBox(height: 8),
                        _buildAttachments(),
                      ],
                    ),
                  ),
                  SizedBox(height: 50 + MediaQuery.of(context).padding.bottom),
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
                    onPressed: state.isLoading ? null : _submit,
                    child: state.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Отправить",
                            style: Styles.b1.copyWith(color: Palette.white),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: Styles.b3.copyWith(color: Palette.gray)),
    );
  }

  Widget _buildTextField(
      String text, TextEditingController controller, String hint,
      {MaskTextInputFormatter? formatter,
      bool enabled = true,
      String? errorText}) {
    final borderColor = errorText != null ? Palette.error : Palette.stroke;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            text,
            style: Styles.b3.copyWith(color: Palette.gray),
          ),
        ),
        Container(
          height: 46,
          width: double.infinity,
          decoration: BoxDecoration(
            color: enabled ? Palette.white : Palette.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: TextField(
            enabled: enabled,
            readOnly: !enabled,
            controller: controller,
            inputFormatters: formatter != null ? [formatter] : [],
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: Styles.b2.copyWith(color: Palette.gray),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            style: Styles.b2
                .copyWith(color: enabled ? Palette.black : Palette.gray),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText,
            style: Styles.b3.copyWith(color: Palette.error),
          ),
        ],
      ],
    );
  }

  void _showReasonModalPicker() {
    showModalPicker<String>(
      context: context,
      title: 'Причина обращения',
      provider: supportReasonsProvider,
      isNoNeedSize: true,
      itemBuilder: (reason) => reason,
      initialValue: _selectedReason,
      onConfirm: (reason) {
        if (reason == null) return;
        setState(() => _selectedReason = reason);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildReasonModalPicker({String? errorText}) {
    final displayText = _selectedReason ?? 'Выберите';
    final displayColor = _selectedReason == null ? Palette.gray : Palette.black;
    final borderColor = errorText != null ? Palette.error : Palette.stroke;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _showReasonModalPicker,
          child: Container(
            height: 43,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    displayText,
                    style: Styles.b2.copyWith(color: displayColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText,
            style: Styles.b3.copyWith(color: Palette.error),
          ),
        ],
      ],
    );
  }

  Widget _buildCommentField() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Palette.stroke),
      ),
      child: TextField(
        controller: _commentController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Ваш комментарий",
          hintStyle:
              Styles.b2.copyWith(color: Palette.gray.withValues(alpha: 0.5)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        style: Styles.b2,
      ),
    );
  }

  Widget _buildAttachments() {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedFiles.length < 3
            ? _selectedFiles.length + 1
            : _selectedFiles.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == _selectedFiles.length && _selectedFiles.length < 3) {
            return GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: MediaQuery.of(context).size.width / 3 - 16,
                height: 200,
                decoration: BoxDecoration(
                  color: Palette.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Palette.gray.withValues(alpha: 0.3),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/add_a_photo.svg",
                    colorFilter:
                        ColorFilter.mode(Palette.primaryLime, BlendMode.srcIn),
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            );
          }

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3 - 16,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: FileImage(File(_selectedFiles[index])),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => _removeImage(index),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0x8E8A8A80).withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/bin_trash.svg",
                          colorFilter:
                              ColorFilter.mode(Palette.white, BlendMode.srcIn),
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
