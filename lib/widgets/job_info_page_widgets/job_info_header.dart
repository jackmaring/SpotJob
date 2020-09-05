import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/job_pages/edit_job_info_page.dart';
import 'package:spotjob/pages/profile_pages/profile_page.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/widgets/job_info_page_widgets/save_star.dart';

class JobInfoHeader extends StatelessWidget {
  final Job relevantJob;
  final User relevantUser;
  final User currentUserDoc;
  final bool isJobOfPostedUser;
  final Job updatedJob;

  JobInfoHeader(
    this.relevantJob,
    this.relevantUser,
    this.currentUserDoc,
    this.isJobOfPostedUser,
    this.updatedJob,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, right: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        relevantUser.profilePic,
                      ),
                      radius: 37.5,
                    ),
                    onTap: () => Navigator.pushNamed(
                      context,
                      ProfilePage.routeName,
                      arguments: relevantUser,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SPOTJOB FROM',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        child: Text(
                          relevantUser.username,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        onTap: () => Navigator.pushNamed(
                          context,
                          ProfilePage.routeName,
                          arguments: relevantUser,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              isJobOfPostedUser
                  ? GestureDetector(
                      child: Icon(
                        FontAwesomeIcons.edit,
                        color: CustomColors.darkGray,
                        size: 25,
                      ),
                      onTap: () => Navigator.pushNamed(
                        context,
                        EditJobInfoPage.routeName,
                        arguments:
                            updatedJob != null ? updatedJob : relevantJob,
                      ),
                    )
                  : SaveStar(currentUserDoc, relevantJob),
            ],
          ),
        ),
        SizedBox(height: 24),
        Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
