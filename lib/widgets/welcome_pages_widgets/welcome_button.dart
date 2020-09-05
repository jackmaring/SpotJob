import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  final BoxDecoration decoration;
  final Text text;
  final Function onTap;

  WelcomeButton({this.decoration, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 50,
          width: 160,
          decoration: decoration,
          child: Center(
            child: text,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
