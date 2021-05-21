import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/change_category.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';

class JobTopMethods {
  static List<User> getSavedUsersOfJob(BuildContext context, Job job) {
    final List<User> users = Provider.of<List<User>>(context, listen: false);
    List<User> savedUsersOfJob;

    if (users != null) {
      savedUsersOfJob =
          users.where((user) => user.savedJobs.contains(job.id)).toList();
    }

    return savedUsersOfJob;
  }

  static List<User> getAppliedUsersOfJob(BuildContext context, Job job) {
    final List<User> users = Provider.of<List<User>>(context, listen: false);
    List<User> appliedUsersOfJob;

    if (users != null) {
      appliedUsersOfJob =
          users.where((user) => user.appliedJobs.contains(job.id)).toList();
    }

    return appliedUsersOfJob;
  }

  static User getJobTakerInProgress(BuildContext context, Job job) {
    final currentUser = Provider.of<auth.User>(context, listen: false);
    final List<User> takeRequesters = getAppliedUsersOfJob(context, job);
    User jobTakerInProgress;

    if (takeRequesters != null) {
      jobTakerInProgress = takeRequesters.singleWhere(
        (takeRequester) =>
            takeRequester.jobsInProgress.contains(job.id) &&
            takeRequester.uid != currentUser.uid,
      );
    }

    return jobTakerInProgress;
  }

  static List<Job> getAvailableJobs(BuildContext context) {
    final jobs = Provider.of<List<Job>>(context);
    List<Job> availableJobs;

    if (jobs != null) {
      availableJobs = jobs.where((job) => job.isAvailable == true).toList();
    }

    return availableJobs;
  }

  static bool getIsInTags(List<String> tags, String tag) {
    if (tags.contains(tag)) {
      return true;
    } else {
      return false;
    }
  }

  static List<Job> getFilteredJobs(
      BuildContext context, ChangeCategory changeCategory) {
    final availableJobs = getAvailableJobs(context);
    List<Job> filteredJobs = [];

    if (availableJobs != null) {
      if (changeCategory.currentCategory != null) {
        filteredJobs = availableJobs
            .where((job) =>
                job.tags.contains(changeCategory.currentCategory.name) ||
                changeCategory.currentCategory.subcategories
                    .any((subcategory) => job.tags.contains(subcategory)))
            .toList();
        if (changeCategory.currentSubcategory != null) {
          filteredJobs = filteredJobs
              .where(
                  (job) => job.tags.contains(changeCategory.currentSubcategory))
              .toList();
        }
      }
      // if (query != null) {
      //   print('in query statement');
      //   filteredJobs = filteredJobs.where((job) {
      //     User posterUser = UserTopMethods.getUserByUid(context, job.uid);
      //     bool isInQuery = false;
      //     print('asdfasdf');
      //     if (posterUser != null) {
      //       if (job.title.contains(query) ||
      //           posterUser.name.contains(query) ||
      //           posterUser.username.contains(query)) {
      //         print('is true');
      //         isInQuery = true;
      //       } else {
      //         print('is false');
      //         isInQuery = false;
      //       }
      //     }
      //     return isInQuery;
      //   }).toList();
      // }
    }

    return filteredJobs;
  }

  static List<Job> getCustomFilteredJobs(
      BuildContext context, ChangeCategory changeCategory) {
    final availableJobs = getAvailableJobs(context);
    List<Job> customFilteredJobs = [];

    if (availableJobs != null) {
      if (changeCategory.hasSetCustomFilter) {
        if (changeCategory.filterTags.isNotEmpty) {
          customFilteredJobs = availableJobs
              .where((job) => job.tags.any(
                    (tag) => changeCategory.filterTags.contains(tag),
                  ))
              .toList();
          if (changeCategory.filterPayRangeLowerValue != null &&
              changeCategory.filterPayRangeUpperValue != null) {
            customFilteredJobs = customFilteredJobs
                .where((job) =>
                    job.pay >= changeCategory.filterPayRangeLowerValue &&
                    job.pay <= changeCategory.filterPayRangeUpperValue)
                .toList();
          }
          if (changeCategory.filterLocationType != null) {
            customFilteredJobs = customFilteredJobs
                .where((job) =>
                    job.locationType == changeCategory.filterLocationType)
                .toList();
          }
        }
        // if (query != null && query.isNotEmpty) {
        //   customFilteredJobs = customFilteredJobs.where((job) {
        //     User posterUser = UserTopMethods.getUserByUid(context, job.uid);
        //     return job.title.contains(query) ||
        //         posterUser.name.contains(query) ||
        //         posterUser.username.contains(query);
        //   });
        // }
      }
    }

    return customFilteredJobs;
  }
}
