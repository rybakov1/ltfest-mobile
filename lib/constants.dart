import 'package:flutter/material.dart';

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
}

class Styles {
  static TextStyle h1 = const TextStyle(
      fontFamily: "Mulish", fontWeight: FontWeight.w600, fontSize: 28);
  static TextStyle h2 = const TextStyle(
      fontFamily: "Mulish", fontWeight: FontWeight.w600, fontSize: 23);
  static TextStyle h3 = const TextStyle(
      fontFamily: "Mulish", fontWeight: FontWeight.w700, fontSize: 18);
  static TextStyle h4 = const TextStyle(
      fontFamily: "Mulish", fontWeight: FontWeight.w700, fontSize: 16);
  static TextStyle h5 = const TextStyle(
      fontFamily: "Mulish", fontWeight: FontWeight.w600, fontSize: 14);

  static TextStyle b1 = const TextStyle(
      fontFamily: "Mulish", fontWeight: FontWeight.w400, fontSize: 16);
  static TextStyle b2 = const TextStyle(
      fontFamily: "Mulish", fontWeight: FontWeight.w400, fontSize: 14);
  static TextStyle b3 = const TextStyle(
      fontFamily: "Mulish", fontWeight: FontWeight.w400, fontSize: 12);
  static TextStyle b4 = const TextStyle(
      fontFamily: "Mulish", fontWeight: FontWeight.w400, fontSize: 10);

  static TextStyle button1 = const TextStyle(
      fontFamily: "Mulish", fontWeight: FontWeight.w500, fontSize: 16);
  static TextStyle button2 = const TextStyle(
      fontFamily: "Mulish", fontWeight: FontWeight.w500, fontSize: 14);
}

class Decor {
  static BoxDecoration base = BoxDecoration(
    color: Colors.white,
    border: Border.all(),
    borderRadius: BorderRadius.circular(12),
  );
}
