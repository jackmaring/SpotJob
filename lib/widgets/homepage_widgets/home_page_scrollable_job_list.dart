import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/change_category.dart';
import 'package:spotjob/utils/top_methods/job_top_methods.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/common/job_list_tile.dart';

class HomePageScrollableJobList extends StatelessWidget {
  final String query;

  HomePageScrollableJobList(this.query);

  @override
  Widget build(BuildContext context) {
    final changeCategoryProvider = Provider.of<ChangeCategory>(context);
    final List<Job> availableJobs = JobTopMethods.getAvailableJobs(context);
    final List<Job> filteredJobs =
        JobTopMethods.getFilteredJobs(context, changeCategoryProvider);
    final List<Job> customFilteredJobs =
        JobTopMethods.getCustomFilteredJobs(context, changeCategoryProvider);
    List<Job> queriedJobs;

    if (query != null && query != '') {
      queriedJobs = filteredJobs.where((job) {
        User posterUser = UserTopMethods.getUserByUid(context, job.uid);
        bool isInQuery = false;
        if (posterUser != null) {
          if (job.title.contains(query) ||
              posterUser.name.contains(query) ||
              posterUser.username.contains(query)) {
            isInQuery = true;
          } else {
            isInQuery = false;
          }
        }
        return isInQuery;
      }).toList();
    }

    Widget getJobListWidget() {
      if (changeCategoryProvider.hasSetCustomFilter) {
        if (customFilteredJobs.isNotEmpty) {
          return ListView.builder(
            padding: EdgeInsets.only(top: 0),
            itemBuilder: (context, index) {
              Job job = customFilteredJobs[index];
              return JobListTile(
                jobDetails: job,
              );
            },
            itemCount: customFilteredJobs.length,
          );
        } else {
          return Center(
            child: Text(
              'There are no jobs that meet your criteria :(',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        }
      } else {
        if (availableJobs.isNotEmpty) {
          return ListView.builder(
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
          );
        } else {
          return Center(
            child: Text(
              'There are no jobs available :(',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        }
      }
    }

    return availableJobs != null
        ? getJobListWidget()
        // ? changeCategoryProvider.hasSetCustomFilter
        //     ? customFilteredJobs.isNotEmpty
        //         ? ListView.builder(
        //             padding: EdgeInsets.only(top: 0),
        //             itemBuilder: (context, index) {
        //               Job job = customFilteredJobs[index];
        //               return JobListTile(
        //                 jobDetails: job,
        //               );
        //             },
        //             itemCount: customFilteredJobs.length,
        //           )
        //         : Center(
        //             child: Text(
        //               'There are no jobs that meet your criteria :(',
        //               style: Theme.of(context).textTheme.headline5,
        //             ),
        //           )
        //     : availableJobs.isNotEmpty
        //         ? ListView.builder(
        //             padding: EdgeInsets.only(top: 0),
        //             itemBuilder: (context, index) {
        //               Job job = changeCategoryProvider.currentCategory != null
        //                   ? filteredJobs[index]
        //                   : availableJobs[index];
        //               return JobListTile(
        //                 jobDetails: job,
        //               );
        //             },
        //             itemCount: changeCategoryProvider.currentCategory != null
        //                 ? filteredJobs.length
        //                 : availableJobs.length,
        //           )
        //         : Center(
        //             child: Text(
        //               'There are no jobs available :(',
        //               style: Theme.of(context).textTheme.headline5,
        //             ),
        //           )
        : CircularProgressIndicator();
  }
}
