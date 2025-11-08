import 'package:flutter/material.dart';

import '../../../constants.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  required ValueChanged<String> onChanged,
  Function? func,
  TextInputType? keyboardType,
  bool isInvalid = false, // Новый параметр
}) {
  final borderColor = isInvalid ? Palette.error : Palette.stroke;
  final focusedBorderColor = isInvalid ? Palette.error : Palette.primaryLime;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Styles.b3),
      const SizedBox(height: 6),
      TextFormField(
        controller: controller,
        onChanged: (value) {
          func; // Сброс ошибок при вводе
          onChanged(value);
        },
        keyboardType: keyboardType,
        // validator убран
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
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: focusedBorderColor, width: 1),
          ),
        ),
      ),
    ],
  );
}