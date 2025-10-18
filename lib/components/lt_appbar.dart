import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';

class LtAppbar extends StatelessWidget {
  const LtAppbar(
      {super.key, required this.title, this.postfixIcon, this.suffixIconColor});

  final Color? suffixIconColor;
  final String title;
  final Widget? postfixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: Styles.h4.copyWith(color: Palette.black),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 43,
              width: 43,
              decoration: Decor.base
                  .copyWith(color: suffixIconColor ?? Palette.primaryLime),
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back, color: Palette.white),
              ),
            ),
          ),
          if (postfixIcon != null)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 43,
                width: 43,
                decoration: Decor.base.copyWith(color: Palette.primaryLime),
                child: postfixIcon,
              ),
            ),
        ],
      ),
    );
  }
}
