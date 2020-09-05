import 'package:flutter/material.dart';

import 'package:spotjob/styles/custom_colors.dart';

class BackArrowAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function onPressed;

  BackArrowAppBar({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: CustomColors.darkGray,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
