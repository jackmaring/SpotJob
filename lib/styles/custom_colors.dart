import 'package:flutter/material.dart';

class CustomColors {
  static const Color darkBlue = Color(0xff0277BD);
  static const Color lightBlue = Color(0xff26C6DA);
  static final Color darkGray = Color.fromRGBO(56, 55, 51, 1);
  static const Color gray = Color(0xff9e9e9e);
  static const Color lightGray = Color(0xfff3f3f3);
  static const LinearGradient spotJobTopDownGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      darkBlue,
      lightBlue,
    ],
  );
  static const LinearGradient spotJobDiagonalGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      darkBlue,
      lightBlue,
    ],
  );
}
