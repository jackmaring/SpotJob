import 'package:flutter/material.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/services/crud_models/user_crud_model.dart';
import 'package:spotjob/services/update_methods/user_update_methods.dart';
import 'package:spotjob/styles/custom_colors.dart';

class SaveStar extends StatelessWidget {
  final UserCRUD userCrud = UserCRUD();

  final User currentUserDoc;
  final Job relevantJob;

  SaveStar(this.currentUserDoc, this.relevantJob);

  @override
  Widget build(BuildContext context) {
    return (currentUserDoc != null && relevantJob != null)
        ? currentUserDoc.savedJobs.contains(relevantJob.id)
            ? GestureDetector(
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) =>
                      CustomColors.spotJobDiagonalGradient.createShader(bounds),
                  child: Icon(
                    Icons.star,
                    size: 30,
                  ),
                ),
                onTap: () => UserUpdateMethods.toggleSaveJob(
                  currentUserDoc,
                  relevantJob,
                ),
              )
            : GestureDetector(
                child: Icon(
                  Icons.star_border,
                  size: 30,
                ),
                onTap: () => UserUpdateMethods.toggleSaveJob(
                  currentUserDoc,
                  relevantJob,
                ),
              )
        : Container();
  }
}
