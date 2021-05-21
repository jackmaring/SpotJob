import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/job_info_page_widgets/apply_for_job_button.dart';
import 'package:spotjob/widgets/job_info_page_widgets/job_info_header.dart';

class TopJobInfo extends StatelessWidget {
  final Job relevantJob;

  TopJobInfo(this.relevantJob);

  @override
  Widget build(BuildContext context) {
    final User currentUserDoc = UserTopMethods.getCurrentUserDoc(context);
    final User relevantUser = UserTopMethods.getRelevantUser(context, relevantJob);
    final bool isJobOfPostedUser =
        UserTopMethods.isCurrentUser(context, currentUserDoc, relevantUser);

    final createJobProvider = Provider.of<CreateJob>(context);
    final Job updatedJob = createJobProvider.updatedJob;

    print(relevantJob.title);
    print(relevantJob.pay);

    return (currentUserDoc != null && relevantUser != null)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JobInfoHeader(
                  relevantJob,
                  relevantUser,
                  currentUserDoc,
                  isJobOfPostedUser,
                  updatedJob,
                ),
                SizedBox(height: 32),
                Text(
                  DateFormat('M / d / yy').format(
                    relevantJob.dateCreated.toDate(),
                  ),
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16),
                Text(
                  // relevantJob.payType == PayType.oneTime
                  //     ?
                  updatedJob != null
                      ? '${updatedJob.title} - \$${updatedJob.pay}'
                      : '${relevantJob.title} - \$${relevantJob.pay}',
                  // : updatedJob != null
                  //     ? '${updatedJob.title} - \$${updatedJob.pay}/hr'
                  //     : '${relevantJob.title} - \$${relevantJob.pay}/hr',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 16),
                Text(
                  updatedJob != null
                      ? updatedJob.description
                      : relevantJob.description,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 32),
                Align(
                  alignment: Alignment.center,
                  child: ApplyForJobButton(
                    currentUserDoc,
                    relevantUser,
                    relevantJob,
                    isJobOfPostedUser,
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          )
        : Container();
  }
}
