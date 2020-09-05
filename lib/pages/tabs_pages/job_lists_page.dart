import 'package:flutter/material.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/common/big_text.dart';
import 'package:spotjob/widgets/job_lists_page_widgets/collapsible_job_list_tile.dart';

class JobListsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User currentUserDoc = UserTopMethods.getCurrentUserDoc(context);
    final List<Job> savedJobs =
        UserTopMethods.getUserSavedJobs(context, currentUserDoc);
    final List<Job> appliedJobs =
        UserTopMethods.getUserAppliedJobs(context, currentUserDoc);
    final List<Job> jobsInProgress =
        UserTopMethods.getUserJobsInProgress(context, currentUserDoc);
    final List<Job> uncompletedJobsPosted =
        UserTopMethods.getUserUncompletedJobsPosted(context, currentUserDoc);

    return currentUserDoc != null
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BigText('JOB LISTS'),
                CollapsibleJobListTile('Jobs Saved', savedJobs),
                CollapsibleJobListTile('Jobs Applied', appliedJobs),
                CollapsibleJobListTile('Jobs In Progress', jobsInProgress),
                CollapsibleJobListTile('Jobs Posted', uncompletedJobsPosted),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
