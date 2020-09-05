import 'package:flutter/material.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/common/back_arrow_appbar.dart';
import 'package:spotjob/widgets/common/job_list_tile.dart';
import 'package:spotjob/widgets/common/search_bar.dart';

class JobsPostedPage extends StatelessWidget {
  static const routeName = '/jobs-posted';

  @override
  Widget build(BuildContext context) {
    final User relevantUser = ModalRoute.of(context).settings.arguments;
    final List<Job> jobsPosted =
        UserTopMethods.getUserJobsPosted(context, relevantUser);

    String _searchQuery;

    return relevantUser != null
        ? Scaffold(
            appBar: BackArrowAppBar(
              onPressed: () => Navigator.pop(context),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${relevantUser.username}\'s',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'JOBS POSTED',
                        style: Theme.of(context).textTheme.headline4,
                      ),
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
                  child: ListView.builder(
                    itemBuilder: (context, index) => JobListTile(
                      jobDetails: jobsPosted[index],
                    ),
                    itemCount: jobsPosted.length,
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
