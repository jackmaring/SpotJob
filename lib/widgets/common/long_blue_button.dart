import 'package:flutter/material.dart';

class LongBlueButton extends StatelessWidget {
  final String text;
  final Function onTap;

  LongBlueButton({this.text, this.onTap});

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
              color: Theme.of(context).primaryColor,
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
      ),
    );
  }
}
