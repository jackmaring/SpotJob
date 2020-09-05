import 'package:flutter/material.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/profile_pages/jobs_completed_page.dart';
import 'package:spotjob/pages/profile_pages/jobs_posted_page.dart';

class JobHistory extends StatelessWidget {
  final User relevantUser;

  JobHistory(this.relevantUser);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'JOB HISTORY',
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.white),
        ),
        SizedBox(height: 16),
        GestureDetector(
          child: Container(
            height: 55,
            width: 210,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Jobs Completed: ${relevantUser.jobsCompleted.length}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ),
          onTap: () => Navigator.pushNamed(
            context,
            JobsCompletedPage.routeName,
            arguments: relevantUser,
          ),
        ),
        SizedBox(height: 4),
        GestureDetector(
          child: Container(
            height: 55,
            width: 210,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Jobs Posted: ${relevantUser.jobsPosted.length}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ),
          onTap: () => Navigator.pushNamed(
            context,
            JobsPostedPage.routeName,
            arguments: relevantUser,
          ),
        ),
      ],
    );
  }
}
