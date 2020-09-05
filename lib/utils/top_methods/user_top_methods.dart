import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';

class UserTopMethods {
  static User getCurrentUserDoc(BuildContext context) {
    final currentUser = Provider.of<FirebaseUser>(context);
    final List<User> users = Provider.of<List<User>>(context);
    User currentUserDoc;

    if (users != null && currentUser != null) {
      currentUserDoc = users.singleWhere((user) => user.uid == currentUser.uid);
    }

    return currentUserDoc;
  }

  static User getRelevantUser(BuildContext context, Job job) {
    final List<User> users = Provider.of<List<User>>(context);
    User relevantUser;

    if (users != null && job != null) {
      relevantUser = users.singleWhere((user) => user.uid == job.uid);
    }

    return relevantUser;
  }

  static User getUserById(BuildContext context, String userId) {
    final List<User> users = Provider.of<List<User>>(context);
    User foundUser;

    if (users != null) {
      foundUser = users.singleWhere((u) => u.id == userId);
    }

    return foundUser;
  }

  static bool isCurrentUser(
      BuildContext context, User currentUserDoc, User relevantUser) {
    bool isCurrentUser;

    if (currentUserDoc != null && relevantUser != null) {
      isCurrentUser = currentUserDoc.uid == relevantUser.uid ? true : false;
    }

    return isCurrentUser;
  }

  static List<User> getUserConnections(BuildContext context, User user) {
    final List<User> users = Provider.of<List<User>>(context);
    List<User> userConnections;

    if (users != null) {
      userConnections =
          users.where((u) => user.connections.contains(u.id)).toList();
    }

    return userConnections;
  }

  static List<Job> getUserSavedJobs(BuildContext context, User user) {
    final List<Job> jobs = Provider.of<List<Job>>(context);
    List<Job> savedJobs;

    if (user != null && jobs != null) {
      savedJobs = jobs.where((job) => user.savedJobs.contains(job.id)).toList();
    }

    return savedJobs;
  }

  static List<Job> getUserAppliedJobs(BuildContext context, User user) {
    final List<Job> jobs = Provider.of<List<Job>>(context);
    List<Job> appliedJobs;

    if (user != null && jobs != null) {
      appliedJobs =
          jobs.where((job) => user.appliedJobs.contains(job.id)).toList();
    }

    return appliedJobs;
  }

  static List<Job> getUserJobsInProgress(BuildContext context, User user) {
    final List<Job> jobs = Provider.of<List<Job>>(context);
    List<Job> jobsInProgress;

    if (user != null && jobs != null) {
      jobsInProgress =
          jobs.where((job) => user.jobsInProgress.contains(job.id)).toList();
    }

    return jobsInProgress;
  }

  static List<Job> getUserJobsCompleted(BuildContext context, User user) {
    final List<Job> jobs = Provider.of<List<Job>>(context);
    List<Job> jobsCompleted;

    if (user != null && jobs != null) {
      jobsCompleted =
          jobs.where((job) => user.jobsCompleted.contains(job.id)).toList();
    }

    return jobsCompleted;
  }

  static List<Job> getUserJobsPosted(BuildContext context, User user) {
    final List<Job> jobs = Provider.of<List<Job>>(context);
    List<Job> jobsPosted;

    if (user != null && jobs != null) {
      jobsPosted =
          jobs.where((job) => user.jobsPosted.contains(job.id)).toList();
    }

    return jobsPosted;
  }

  static List<Job> getUserUncompletedJobsPosted(
      BuildContext context, User user) {
    final List<Job> jobsPosted = getUserJobsPosted(context, user);
    List<Job> uncompletedJobsPosted;

    if (jobsPosted != null) {
      uncompletedJobsPosted = jobsPosted
          .where((job) => job.isAvailable || job.isInProgress)
          .toList();
    }

    return uncompletedJobsPosted;
  }

  static List<Job> getUserCompletedJobsPosted(BuildContext context, User user) {
    final List<Job> jobsPosted = getUserJobsPosted(context, user);
    List<Job> completedJobsPosted;

    if (jobsPosted != null) {
      completedJobsPosted = jobsPosted.where((job) => job.isCompleted).toList();
    }

    return completedJobsPosted;
  }
}