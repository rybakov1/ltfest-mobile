import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ltfest/constants.dart';
import 'package:ltfest/components/lt_appbar.dart';
import 'package:ltfest/features/support/presentation/providers/support_provider.dart';

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

  final _phoneFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final List<String> _reasons = [
    'Техническая ошибка',
    'Вопрос по заказу',
    'Предложение по улучшению',
    'Другое',
  ];

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

  Future<void> _submit() async {
    if (_emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Пожалуйста, заполните обязательные поля')),
      );
      return;
    }

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Сообщение отправлено')),
        );
        context.pop();
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
                    decoration: Decor.base.copyWith(color: Palette.error),
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
                                  "Email*", _emailController, "email@mail.com"),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildTextField("Номер телефона*",
                                  _phoneController, "+79099990011",
                                  formatter: _phoneFormatter),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildLabel("Причина обращения*"),
                        _buildDropdown(),
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
                  SizedBox(height: 250 + MediaQuery.of(context).padding.bottom),
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
      {MaskTextInputFormatter? formatter}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(text, style: Styles.b3.copyWith(color: Palette.gray)),
        ),
        Container(
          height: 43,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Palette.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Palette.stroke),
          ),
          child: TextField(
            controller: controller,
            inputFormatters: formatter != null ? [formatter] : [],
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: Styles.b2
                  .copyWith(color: Palette.gray.withValues(alpha: 0.5)),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            style: Styles.b2,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Palette.stroke),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedReason,
          isExpanded: true,
          hint: Text("Выберите",
              style: Styles.b2
                  .copyWith(color: Palette.gray.withValues(alpha: 0.5))),
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
          items: _reasons.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: Styles.b2),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedReason = newValue;
            });
          },
        ),
      ),
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
                  child: Icon(Icons.add_photo_alternate_outlined,
                      color: Palette.primaryLime),
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
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.delete_outline,
                        size: 20, color: Colors.white),
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
