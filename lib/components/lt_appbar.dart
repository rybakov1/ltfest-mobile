import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants.dart';

class LTAppBar extends StatelessWidget {
  final Color? suffixIconColor;
  final String? title;
  final Widget? postfixWidget;

  const LTAppBar({
    super.key,
    this.title,
    this.postfixWidget,
    this.suffixIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: suffixIconColor != null ? 10 : 0,
                sigmaY: suffixIconColor != null ? 10 : 0,
              ),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: suffixIconColor ?? Palette.primaryLime,
                ),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Palette.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: Styles.h4.copyWith(color: Palette.black),
              ),
            ),
          ),
          if (postfixWidget != null) postfixWidget!,
          if (postfixWidget == null) const SizedBox(width: 40)
        ],
      ),
    );
  }
}
