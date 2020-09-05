import 'package:flutter/material.dart';
import 'package:spotjob/styles/custom_colors.dart';

class WelcomeFormButton extends StatelessWidget {
  final String buttonText;
  final Function onTap;

  WelcomeFormButton({this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 35,
          width: 220,
          decoration: BoxDecoration(
            gradient: CustomColors.spotJobDiagonalGradient,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
