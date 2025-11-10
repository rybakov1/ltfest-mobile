import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

extension ColorsExt on Color {
  MaterialColor toMaterialColor() {
    final int r = (this.r * 255.0).round() & 0xff;
    final int g = (this.g * 255.0).round() & 0xff;
    final int b = (this.b * 255.0).round() & 0xff;
    final int a = (this.a * 255.0).round() & 0xff;

    final int primaryValue = (a << 24) | (r << 16) | (g << 8) | b;
    final Map<int, Color> shades = <int, Color>{};

    final List<double> strengths = [0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];

    for (int i = 0; i < strengths.length; i++) {
      final double strength = strengths[i];
      final double ds = 0.5 - strength;

      final int shadeR = (r + ((ds < 0 ? r : (255 - r)) * ds).round()).round() & 0xff;
      final int shadeG = (g + ((ds < 0 ? g : (255 - g)) * ds).round()).round() & 0xff;
      final int shadeB = (b + ((ds < 0 ? b : (255 - b)) * ds).round()).round() & 0xff;

      final int shadeIndex = ((strength * 1000).round() / 100 * 100).round();
      shades[shadeIndex] = Color.fromARGB(a, shadeR, shadeG, shadeB);
    }

    shades[500] = this;
    return MaterialColor(primaryValue, shades);
  }
}

class Utils {
  static final phoneFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static String formatMoney(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'ru_RU',
      symbol: '₽',
      decimalDigits: 0,
    );
    return formatter.format(amount).replaceAll(',', ' ');
  }
}

class Palette {
  static Color black = const Color.fromRGBO(29, 29, 32, 1);
  static Color gray = const Color.fromRGBO(99, 101, 107, 1);
  static Color stroke = const Color.fromRGBO(222, 222, 224, 1);
  static Color background = const Color.fromRGBO(248, 248, 248, 1);
  static Color white = Colors.white;
  static Color primaryLime = const Color(0xFFBAD712);
  static Color primaryYellow = const Color(0xFFE2FF39);
  static Color primaryPink = const Color(0xFFFC3674);
  static Color secondary = const Color.fromRGBO(255, 133, 98, 1);
  static Color primary2Gradient = const Color.fromRGBO(255, 146, 178, 1);
  static Color error = const Color(0xFFEC3437);
  static Color success = const Color(0xFF48A74C);
  static Color shimmerBase = const Color(0xFFF0F2F5);
  static Color shimmerHighlight = const Color(0xFFE7EAED);
  static Color grayTimer = const Color.fromRGBO(157, 157, 157, 1);
  static Color secondaryGray = const Color(0xFFE2E6F1);
}

class Styles {
  static TextStyle h1 = TextStyle(
    fontFamily: "Mulish",
    fontWeight: FontWeight.w600,
    fontSize: 28,
    color: Palette.black,
  );

  static TextStyle h2 = TextStyle(
    fontFamily: "Mulish",
    fontWeight: FontWeight.w600,
    fontSize: 23,
    color: Palette.black,
  );

  static TextStyle h3 = TextStyle(
    fontFamily: "Mulish",
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: Palette.black,
  );

  static TextStyle h4 = TextStyle(
    fontFamily: "Mulish",
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Palette.black,
  );

  static TextStyle h5 = TextStyle(
    fontFamily: "Mulish",
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: Palette.black,
  ); // from 14

  static TextStyle h6 = TextStyle(
    fontFamily: "Unbounded",
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: Palette.black,
  ); // from 14

  static TextStyle b1 = TextStyle(
    fontFamily: "Mulish",
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: Palette.black,
  );

  static TextStyle b2 = TextStyle(
    fontFamily: "Mulish",
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: Palette.black,
  ); // from 14

  static TextStyle b3 = TextStyle(
    fontFamily: "Mulish",
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Palette.black,
  );

  static TextStyle b4 = TextStyle(
    fontFamily: "Mulish",
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: Palette.black,
  );

  static TextStyle button1 = const TextStyle(
    fontFamily: "Mulish",
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static TextStyle button2 = TextStyle(
    fontFamily: "Mulish",
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Palette.black,
  );
}

class Decor {
  static BoxDecoration base = BoxDecoration(
    color: Palette.white,
    borderRadius: BorderRadius.circular(12),
  );
}

class LTButtons {
  static Widget elevatedButton({
    required VoidCallback? onPressed,
    required Widget child,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    Color? foregroundColor,
    Color? disabledForegroundColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    Size? minimumSize,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Palette.primaryLime,
        disabledBackgroundColor: disabledBackgroundColor ?? Palette.background,
        foregroundColor: foregroundColor ?? Palette.white,
        disabledForegroundColor: disabledForegroundColor ?? Palette.gray,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: minimumSize ?? const Size(double.infinity, 44),
      ),
      child: child,
    );
  }

  static Widget secondaryButton({
    required VoidCallback? onPressed,
    required Widget child,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    Color? foregroundColor,
    Color? disabledForegroundColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    Size? minimumSize,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Palette.secondary,
        disabledBackgroundColor: disabledBackgroundColor ?? Palette.gray,
        foregroundColor: foregroundColor ?? Palette.black,
        disabledForegroundColor: disabledForegroundColor ?? Palette.stroke,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: minimumSize ?? const Size(100, 48),
      ),
      child: child,
    );
  }

  static Widget outlinedButton({
    required VoidCallback? onPressed,
    required Widget child,
    Color? backgroundColor,
    Color? disabledBackgroundColor,
    Color? foregroundColor,
    Color? disabledForegroundColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    Size? minimumSize,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? Palette.white,
        disabledBackgroundColor: disabledBackgroundColor ?? Palette.background,
        foregroundColor: foregroundColor ?? Palette.black,
        disabledForegroundColor: disabledForegroundColor ?? Palette.gray,
        elevation: 0,
        side: BorderSide(color: disabledBackgroundColor ?? Palette.stroke),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: minimumSize ?? const Size(double.infinity, 42),
      ),
      child: child,
    );
  }
}
