import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/sj_notification.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/tabs_pages/tabs_page.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/services/update_methods/job_update_methods.dart';
import 'package:spotjob/services/update_methods/sjnotification_update_methods.dart';
import 'package:spotjob/services/update_methods/user_update_methods.dart';
import 'package:spotjob/utils/top_methods/job_top_methods.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/common/back_arrow_appbar.dart';
import 'package:spotjob/widgets/common/long_white_button.dart';
import 'package:spotjob/widgets/common/search_bar.dart';
import 'package:spotjob/widgets/take_requests_page_widget/take_requests_row.dart';

class TakeRequestsPage extends StatelessWidget {
  static const routeName = '/take-requests';

//   @override
//   _TakeRequestsPageState createState() => _TakeRequestsPageState();
// }

// class _TakeRequestsPageState extends State<TakeRequestsPage> {
//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () {
//       final Job relevantJob = ModalRoute.of(context).settings.arguments;
//       final createJobProvider = Provider.of<CreateJob>(context, listen: false);

//       createJobProvider.loadNumOfPeopleRemaining(relevantJob);

//       createJobProvider.numOfPeopleRemaining = relevantJob.numOfPeople;
//     });
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);
    final Job relevantJob = ModalRoute.of(context).settings.arguments;
    final User currentUserDoc = UserTopMethods.getCurrentUserDoc(context);
    final List<User> takeRequesters =
        JobTopMethods.getAppliedUsersOfJob(context, relevantJob);

    String _searchQuery;

    return currentUserDoc != null
        ? Scaffold(
            appBar: BackArrowAppBar(
              onPressed: () => Navigator.pop(context),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 73),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Take Requests For',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      Text(
                        relevantJob.title.toUpperCase(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      // SizedBox(height: 8),
                      // Text(
                      //   'People remaining: ${createJobProvider.numOfPeopleRemaining}',
                      //   style: Theme.of(context).textTheme.headline6,
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                SearchBar(
                  onChanged: (value) {
                    _searchQuery = value;
                  },
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => TakeRequestsRow(
                      takeRequesters[index],
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: takeRequesters.length,
                  ),
                ),
                createJobProvider.personAccepted != null
                    ? LongWhiteButton(
                        text: 'Confirm',
                        onTap: () {
                          JobUpdateMethods.confirmTakeRequest(
                            context,
                            createJobProvider,
                            relevantJob,
                            currentUserDoc,
                          );
                        },
                      )
                    : Container(height: 50),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
