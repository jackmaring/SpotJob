import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/services/crud_models/job_crud_model.dart';
import 'package:spotjob/services/update_methods/user_update_methods.dart';
import 'package:spotjob/utils/top_methods/job_top_methods.dart';

class JobUpdateMethods {
  static void createJob(CreateJob createJob, User currentUser) {
    JobCRUD jobCrud = JobCRUD();
    jobCrud
        .addJob(
      Job(
        uid: currentUser.uid,
        title: createJob.titleText,
        description: createJob.descText,
        // payType: createJob.payType,
        pay: double.tryParse(createJob.price),
        locationType: createJob.locationType,
        address: createJob.address,
        // numOfPeople: int.tryParse(createJob.numOfPeople),
        tags: createJob.tags,
        isAvailable: true,
        isInProgress: false,
        isCompleted: false,
        dateCreated: Timestamp.now(),
      ),
    )
        .then((job) {
      UserUpdateMethods.toggleJobPosted(
        currentUser,
        job,
      );
    });
    createJob.resetCreateJobStats();
  }

  static Future<Job> updateJobInfo(CreateJob createJob, Job job) async {
    JobCRUD jobCrud = JobCRUD();

    Job updatedJob = Job(
      id: job.id,
      uid: job.uid,
      title: createJob.titleText,
      description: createJob.descText,
      // payType: createJob.payType,
      pay: double.tryParse(createJob.price),
      locationType: createJob.locationType,
      address: createJob.address,
      // numOfPeople: int.tryParse(createJob.numOfPeople),
      tags: createJob.tags,
      isAvailable: job.isAvailable,
      isInProgress: job.isInProgress,
      isCompleted: job.isCompleted,
      dateCreated: job.dateCreated,
    );

    await jobCrud.updateJob(updatedJob);

    createJob.resetCreateJobStats();

    return updatedJob;
  }

  static void toggleJobInProgress(Job job) {
    JobCRUD jobCrud = JobCRUD();
    bool inProgress;
    bool isAvailable;
    if (job.isInProgress == true) {
      inProgress = false;
      isAvailable = true;
    } else {
      inProgress = true;
      isAvailable = false;
    }
    jobCrud.updateJob(
      Job(
        id: job.id,
        uid: job.uid,
        title: job.title,
        description: job.description,
        // payType: job.payType,
        pay: job.pay,
        locationType: job.locationType,
        address: job.address,
        // numOfPeople: job.numOfPeople,
        tags: job.tags,
        isAvailable: isAvailable,
        isInProgress: inProgress,
        isCompleted: job.isCompleted,
        dateCreated: job.dateCreated,
      ),
    );
  }

  static void completeJob(Job job) {
    JobCRUD jobCrud = JobCRUD();
    if (job.isCompleted == false) {
      jobCrud.updateJob(
        Job(
          id: job.id,
          uid: job.uid,
          title: job.title,
          description: job.description,
          // payType: job.payType,
          pay: job.pay,
          locationType: job.locationType,
          address: job.address,
          // numOfPeople: job.numOfPeople,
          tags: job.tags,
          isAvailable: false,
          isInProgress: false,
          isCompleted: true,
          dateCreated: job.dateCreated,
        ),
      );
    }
  }

  static void completeJobAndUpdateUsers(
      {BuildContext context, User posterUser, User takerUser, Job job}) {
    final List<User> usersWhoSavedTheJob =
        JobTopMethods.getSavedUsersOfJob(context, job);
    final List<User> usersWhoAppliedForTheJob =
        JobTopMethods.getAppliedUsersOfJob(context, job);

    // removes from user's jobs in progress
    UserUpdateMethods.toggleUserJobInProgress(takerUser, job);

    // adds to user's jobs completed
    UserUpdateMethods.toggleUserJobCompleted(takerUser, job);

    // removes from posted user's jobs in progress
    UserUpdateMethods.toggleUserJobInProgress(posterUser, job);

    // updates job's isCompleted to true
    JobUpdateMethods.completeJob(job);

    // remove instances of the job from all users' saved and applied jobs
    usersWhoSavedTheJob.forEach(
      (user) => UserUpdateMethods.toggleSaveJob(user, job),
    );
    usersWhoAppliedForTheJob.forEach(
      (user) => UserUpdateMethods.toggleApplyForJob(user, job),
    );
  }

  static void cancelJob({User posterUser, User takerUser, Job job}) {
    // removes from user's jobs in progress
    UserUpdateMethods.toggleUserJobInProgress(takerUser, job);
    // removes from posted user's jobs in progress
    UserUpdateMethods.toggleUserJobInProgress(posterUser, job);
    // updates job's isAvailable to true
    JobUpdateMethods.toggleJobInProgress(job);
  }

  static void deleteJob(CreateJob createJob, User currentUser, Job job) {
    JobCRUD jobCrud = JobCRUD();
    jobCrud.removeJob(job.id);
    createJob.resetCreateJobStats();
    UserUpdateMethods.toggleJobPosted(currentUser, job);
  }
}
