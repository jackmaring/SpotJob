import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/widgets/profile_page_widgets/job_history.dart';
import 'package:spotjob/widgets/profile_page_widgets/profile_education.dart';
import 'package:spotjob/widgets/profile_page_widgets/profile_skills.dart';

class BottomProfileContainer extends StatelessWidget {
  final User relevantUser;

  BottomProfileContainer(this.relevantUser);

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    final mediaQuery = MediaQuery.of(context);

    return createUserProvider.profileTopContainerHeight != null
        ? Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: mediaQuery.size.height -
                  createUserProvider.profileTopContainerHeight -
                  60,
            ),
            decoration: BoxDecoration(
              gradient: CustomColors.spotJobTopDownGradient,
            ),
            child: Column(
              children: [
                SizedBox(height: 32),
                JobHistory(relevantUser),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileEducation(relevantUser),
                      // Profile Education has bottom padding of 12
                      SizedBox(height: 20),
                      ProfileSkills(relevantUser),
                      SizedBox(height: 64),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
