import 'package:flutter/material.dart';

import 'package:spotjob/pages/job_pages/new_job_page.dart';
import 'package:spotjob/styles/custom_colors.dart';

class GradientFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          gradient: CustomColors.spotJobTopDownGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: ([
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1.8,
              spreadRadius: 0.5,
              offset: Offset(0.0, 3.0),
            ),
          ]),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(NewJobPage.routeName);
      },
    );
  }
}
