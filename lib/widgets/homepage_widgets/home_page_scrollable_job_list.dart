import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/providers/change_category.dart';
import 'package:spotjob/utils/top_methods/job_top_methods.dart';
import 'package:spotjob/widgets/common/job_list_tile.dart';

class HomePageScrollableJobList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final changeCategoryProvider = Provider.of<ChangeCategory>(context);
    final List<Job> availableJobs = JobTopMethods.getAvailableJobs(context);
    final List<Job> filteredJobs =
        JobTopMethods.getFilteredJobs(context, changeCategoryProvider);
    final List<Job> customFilteredJobs =
        JobTopMethods.getCustomFilteredJobs(context, changeCategoryProvider);

    return availableJobs != null
        ? changeCategoryProvider.hasSetCustomFilter
            ? customFilteredJobs.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    itemBuilder: (context, index) {
                      Job job = customFilteredJobs[index];
                      return JobListTile(
                        jobDetails: job,
                      );
                    },
                    itemCount: customFilteredJobs.length,
                  )
                : Center(
                    child: Text(
                      'There are no jobs that meet your criteria :(',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
            : availableJobs.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    itemBuilder: (context, index) {
                      Job job = changeCategoryProvider.currentCategory != null
                          ? filteredJobs[index]
                          : availableJobs[index];
                      return JobListTile(
                        jobDetails: job,
                      );
                    },
                    itemCount: changeCategoryProvider.currentCategory != null
                        ? filteredJobs.length
                        : availableJobs.length,
                  )
                : Center(
                    child: Text(
                      'There are no jobs available :(',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
        : CircularProgressIndicator();
  }
}
