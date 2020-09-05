import 'package:flutter/material.dart';
import 'package:spotjob/styles/custom_colors.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final Function onTap;

  BlueButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 50,
          width: 130,
          decoration: BoxDecoration(
            gradient: CustomColors.spotJobDiagonalGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
