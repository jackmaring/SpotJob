import 'package:flutter/material.dart';

class LongWhiteButton extends StatelessWidget {
  final String text;
  final Function onTap;

  LongWhiteButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Ink(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
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
      ),
    );
  }
}
