import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/styles/custom_colors.dart';

class AcceptButton extends StatelessWidget {
  final User takeRequester;

  AcceptButton(this.takeRequester);

  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);

    return createJobProvider.personAccepted == null
        ? Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              child: Ink(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  gradient: CustomColors.spotJobDiagonalGradient,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Accept',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              onTap: () => createJobProvider.personAccepted = takeRequester,
            ),
          )
        : Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              child: Ink(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).accentColor,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Undo',
                    style: TextStyle(
                      fontSize: 16,
                      color: CustomColors.darkGray,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              onTap: () => createJobProvider.personAccepted = null,
            ),
          );
  }
}
