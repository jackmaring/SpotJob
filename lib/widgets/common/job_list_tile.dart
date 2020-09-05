import 'package:flutter/material.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/job_pages/job_info_page.dart';
import 'package:spotjob/pages/profile_pages/profile_page.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';

class JobListTile extends StatelessWidget {
  final Job jobDetails;

  JobListTile({this.jobDetails});

  @override
  Widget build(BuildContext context) {
    User relevantUser = UserTopMethods.getRelevantUser(context, jobDetails);

    return relevantUser != null
        ? Card(
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            shadowColor: CustomColors.lightGray,
            child: GestureDetector(
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        relevantUser.profilePic,
                      ),
                      radius: 25,
                    ),
                    onTap: () => Navigator.pushNamed(
                      context,
                      ProfilePage.routeName,
                      arguments: relevantUser,
                    ),
                  ),
                ),
                title: Text(
                  jobDetails.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text(
                  relevantUser.username,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                trailing: Text(
                  '\$${jobDetails.pay}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              onTap: () => Navigator.pushNamed(
                context,
                JobInfoPage.routeName,
                arguments: jobDetails,
              ),
            ),
          )
        : CircularProgressIndicator();
  }
}
