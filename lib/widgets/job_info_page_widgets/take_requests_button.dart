import 'package:flutter/material.dart';

import 'package:spotjob/styles/custom_colors.dart';

class TakeRequestsButton extends StatelessWidget {
  final Function onTap;

  TakeRequestsButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            gradient: CustomColors.spotJobDiagonalGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'TAKE REQUESTS',
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
