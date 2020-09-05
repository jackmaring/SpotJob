import 'package:flutter/material.dart';
import 'package:spotjob/styles/custom_colors.dart';

class WelcomeInputDecoration {
  static InputDecoration welcomeInputDecoration({
    IconData iconData,
    Function onIconTap,
    String hintText,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.only(left: 16),
      suffixIcon: GestureDetector(
        child: Icon(
          iconData,
          size: 20,
          color: CustomColors.gray,
        ),
        onTap: onIconTap,
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: CustomColors.gray,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          width: 1,
          color: CustomColors.gray,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          width: 2,
          color: CustomColors.gray,
        ),
      ),
    );
  }
}
