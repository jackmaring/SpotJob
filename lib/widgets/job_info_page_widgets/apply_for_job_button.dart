import 'package:flutter/material.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/job_pages/take_requests_page.dart';
import 'package:spotjob/pages/tabs_pages/tabs_page.dart';
import 'package:spotjob/services/crud_models/user_crud_model.dart';
import 'package:spotjob/services/update_methods/job_update_methods.dart';
import 'package:spotjob/services/update_methods/user_update_methods.dart';
import 'package:spotjob/utils/top_methods/job_top_methods.dart';
import 'package:spotjob/widgets/common/blue_button.dart';
import 'package:spotjob/widgets/common/white_button.dart';
import 'package:spotjob/widgets/job_info_page_widgets/in_progress_button.dart';
import 'package:spotjob/widgets/job_info_page_widgets/take_requests_button.dart';

class ApplyForJobButton extends StatelessWidget {
  final UserCRUD userCrud = UserCRUD();

  final User currentUserDoc;
  final User relevantUser;
  final Job relevantJob;
  final bool isJobOfPostedUser;

  ApplyForJobButton(
    this.currentUserDoc,
    this.relevantUser,
    this.relevantJob,
    this.isJobOfPostedUser,
  );

  @override
  Widget build(BuildContext context) {
    return !relevantJob.isCompleted
        ? isJobOfPostedUser
            ? relevantJob.isInProgress
                ? InProgressButton(
                    onTap: () {
                      final User takerUser = JobTopMethods.getJobTakerInProgress(
                          context, relevantJob);
                      JobUpdateMethods.completeJobAndUpdateUsers(
                        context: context,
                        posterUser: relevantUser,
                        takerUser: takerUser,
                        job: relevantJob,
                      );
                      Navigator.pushNamed(context, TabsPage.routeName);
                    },
                  )
                : TakeRequestsButton(
                    onTap: () => Navigator.pushNamed(
                      context,
                      TakeRequestsPage.routeName,
                      arguments: relevantJob,
                    ),
                  )
            : relevantJob.isInProgress
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlueButton(
                        text: 'FINISH',
                        onTap: () {
                          JobUpdateMethods.completeJobAndUpdateUsers(
                            context: context,
                            posterUser: relevantUser,
                            takerUser: currentUserDoc,
                            job: relevantJob,
                          );
                          // routes back to tabs page
                          Navigator.pushNamed(context, TabsPage.routeName);
                        },
                      ),
                      SizedBox(width: 16),
                      WhiteButton(
                        text: 'CANCEL',
                        onTap: () {
                          JobUpdateMethods.cancelJob(
                            posterUser: relevantUser,
                            takerUser: currentUserDoc,
                            job: relevantJob,
                          );
                          // routes back to tabs page
                          Navigator.pushNamed(context, TabsPage.routeName);
                        },
                      ),
                    ],
                  )
                : currentUserDoc.appliedJobs.contains(relevantJob.id)
                    ? WhiteButton(
                        text: 'UNDO',
                        onTap: () => UserUpdateMethods.toggleApplyForJob(
                          currentUserDoc,
                          relevantJob,
                        ),
                      )
                    : BlueButton(
                        text: 'TAKE ON',
                        onTap: () => UserUpdateMethods.toggleApplyForJob(
                          currentUserDoc,
                          relevantJob,
                        ),
                      )
        : BlueButton(
            text: 'INFO',
            onTap: () {},
          );
  }
}
