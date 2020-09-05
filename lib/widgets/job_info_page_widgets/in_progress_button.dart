import 'package:flutter/material.dart';

class InProgressButton extends StatelessWidget {
  final Function onTap;

  InProgressButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).accentColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'IN PROGRESS',
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
