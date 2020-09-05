import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  final String text;
  final Function onTap;

  WhiteButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 50,
          width: 130,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).accentColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
