import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotjob/models/job.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/services/crud_models/user_crud_model.dart';
import 'package:spotjob/services/file_uploader.dart';

class UserUpdateMethods {
  static void createUser(String userUid, String email, String username) {
    UserCRUD userCrud = UserCRUD();
    userCrud.addUser(
      User(
        uid: userUid,
        email: email,
        username: username,
        dateCreated: Timestamp.now(),
      ),
    );
  }

  static Future<User> editUserProfile(CreateUser createUser, User userDoc) async {
    UserCRUD userCrud = UserCRUD();
    String profilePicUrl;

    if (createUser.changedImg) {
      profilePicUrl =
          await uploadUserProfilePic(userDoc, createUser.profileImg);
    }

    User updatedUser = User(
      id: userDoc.id,
      uid: userDoc.uid,
      email: userDoc.email,
      username: userDoc.username,
      profilePic: profilePicUrl != null ? profilePicUrl : userDoc.profilePic,
      name: createUser.name,
      title: createUser.title,
      bio: createUser.bio,
      certifications: createUser.certifications,
      skills: createUser.skills,
      connections: userDoc.connections,
      blockedUsers: userDoc.blockedUsers,
      jobsCompleted: userDoc.jobsCompleted,
      jobsPosted: userDoc.jobsPosted,
      savedJobs: userDoc.savedJobs,
      appliedJobs: userDoc.appliedJobs,
      jobsInProgress: userDoc.jobsInProgress,
      dateCreated: userDoc.dateCreated,
    );

    userCrud.updateUser(updatedUser);

    createUser.resetCreateUser();

    return updatedUser;
  }

  static Future<String> uploadUserProfilePic(User user, File profileImg) async {
    final String collectionName = 'user_profile_pics';
    final String fileName = user.uid;
    String downloadUrl;
    await FileUploader.uploadFile(collectionName, fileName, profileImg).then(
      (result) {
        downloadUrl = result;
      },
    );
    return downloadUrl;
  }

  static void toggleSaveJob(User userDoc, Job jobDoc) {
    UserCRUD userCrud = UserCRUD();
    List<String> savedJobs = userDoc.savedJobs;
    if (!savedJobs.contains(jobDoc.id)) {
      savedJobs.add(jobDoc.id);
    } else if (savedJobs.contains(jobDoc.id)) {
      savedJobs.remove(jobDoc.id);
    } else {
      print('error in toggleSaveJob');
    }
    userCrud.updateUser(
      User(
        id: userDoc.id,
        uid: userDoc.uid,
        email: userDoc.email,
        username: userDoc.username,
        name: userDoc.name,
        profilePic: userDoc.profilePic,
        title: userDoc.title,
        bio: userDoc.bio,
        certifications: userDoc.certifications,
        skills: userDoc.skills,
        connections: userDoc.connections,
        blockedUsers: userDoc.blockedUsers,
        jobsCompleted: userDoc.jobsCompleted,
        jobsPosted: userDoc.jobsPosted,
        savedJobs: savedJobs,
        appliedJobs: userDoc.appliedJobs,
        jobsInProgress: userDoc.jobsInProgress,
        dateCreated: userDoc.dateCreated,
      ),
    );
  }

  static void toggleApplyForJob(User userDoc, Job jobDoc) {
    UserCRUD userCrud = UserCRUD();
    List<String> appliedForJobs = userDoc.appliedJobs;
    if (!appliedForJobs.contains(jobDoc.id)) {
      appliedForJobs.add(jobDoc.id);
    } else if (appliedForJobs.contains(jobDoc.id)) {
      appliedForJobs.remove(jobDoc.id);
    } else {
      print('error in toggleApplyForJob');
    }
    userCrud.updateUser(
      User(
        id: userDoc.id,
        uid: userDoc.uid,
        email: userDoc.email,
        username: userDoc.username,
        profilePic: userDoc.profilePic,
        name: userDoc.name,
        title: userDoc.title,
        bio: userDoc.bio,
        certifications: userDoc.certifications,
        skills: userDoc.skills,
        connections: userDoc.connections,
        blockedUsers: userDoc.blockedUsers,
        jobsCompleted: userDoc.jobsCompleted,
        jobsPosted: userDoc.jobsPosted,
        savedJobs: userDoc.savedJobs,
        appliedJobs: appliedForJobs,
        jobsInProgress: userDoc.jobsInProgress,
        dateCreated: userDoc.dateCreated,
      ),
    );
  }

  static void toggleConnection(User userDoc, User relevantUser) {
    UserCRUD userCrud = UserCRUD();
    List<String> connections = userDoc.connections;
    if (!connections.contains(relevantUser.id)) {
      connections.add(relevantUser.id);
    } else if (connections.contains(relevantUser.id)) {
      connections.remove(relevantUser.id);
    } else {
      print('error in toggleConnection');
    }
    userCrud.updateUser(
      User(
        id: userDoc.id,
        uid: userDoc.uid,
        email: userDoc.email,
        username: userDoc.username,
        profilePic: userDoc.profilePic,
        name: userDoc.name,
        title: userDoc.title,
        bio: userDoc.bio,
        certifications: userDoc.certifications,
        skills: userDoc.skills,
        connections: connections,
        blockedUsers: userDoc.blockedUsers,
        jobsCompleted: userDoc.jobsCompleted,
        jobsPosted: userDoc.jobsPosted,
        savedJobs: userDoc.savedJobs,
        appliedJobs: userDoc.appliedJobs,
        jobsInProgress: userDoc.jobsInProgress,
        dateCreated: userDoc.dateCreated,
      ),
    );
  }

  static void toggleBlockedUser(User userDoc, User relevantUser) {
    UserCRUD userCrud = UserCRUD();
    List<String> blockedUsers = userDoc.blockedUsers;
    if (!blockedUsers.contains(relevantUser.id)) {
      blockedUsers.add(relevantUser.id);
    } else if (blockedUsers.contains(relevantUser.id)) {
      blockedUsers.remove(relevantUser.id);
    } else {
      print('error in toggleBlockedUser');
    }
    userCrud.updateUser(
      User(
        id: userDoc.id,
        uid: userDoc.uid,
        email: userDoc.email,
        username: userDoc.username,
        profilePic: userDoc.profilePic,
        name: userDoc.name,
        title: userDoc.title,
        bio: userDoc.bio,
        certifications: userDoc.certifications,
        skills: userDoc.skills,
        connections: userDoc.connections,
        blockedUsers: blockedUsers,
        jobsCompleted: userDoc.jobsCompleted,
        jobsPosted: userDoc.jobsPosted,
        savedJobs: userDoc.savedJobs,
        appliedJobs: userDoc.appliedJobs,
        jobsInProgress: userDoc.jobsInProgress,
        dateCreated: userDoc.dateCreated,
      ),
    );
  }

  static void toggleJobPosted(User userDoc, Job job) {
    UserCRUD userCrud = UserCRUD();
    List<String> jobsPosted = userDoc.jobsPosted;
    if (!jobsPosted.contains(job.id)) {
      jobsPosted.add(job.id);
    } else if (jobsPosted.contains(job.id)) {
      jobsPosted.remove(job.id);
    } else {
      print('error in toggleJobPosted');
    }
    userCrud.updateUser(
      User(
        id: userDoc.id,
        uid: userDoc.uid,
        email: userDoc.email,
        username: userDoc.username,
        profilePic: userDoc.profilePic,
        name: userDoc.name,
        title: userDoc.title,
        bio: userDoc.bio,
        certifications: userDoc.certifications,
        skills: userDoc.skills,
        connections: userDoc.connections,
        blockedUsers: userDoc.blockedUsers,
        jobsCompleted: userDoc.jobsCompleted,
        jobsPosted: jobsPosted,
        savedJobs: userDoc.savedJobs,
        appliedJobs: userDoc.appliedJobs,
        jobsInProgress: userDoc.jobsInProgress,
        dateCreated: userDoc.dateCreated,
      ),
    );
  }

  static void toggleUserJobInProgress(User userDoc, Job job) {
    UserCRUD userCrud = UserCRUD();
    List<String> userJobsInProgress = userDoc.jobsInProgress;
    if (!userJobsInProgress.contains(job.id)) {
      userJobsInProgress.add(job.id);
    } else if (userJobsInProgress.contains(job.id)) {
      userJobsInProgress.remove(job.id);
    } else {
      print('error in toggleUserJobInProgress');
    }
    userCrud.updateUser(
      User(
        id: userDoc.id,
        uid: userDoc.uid,
        email: userDoc.email,
        username: userDoc.username,
        profilePic: userDoc.profilePic,
        name: userDoc.name,
        title: userDoc.title,
        bio: userDoc.bio,
        certifications: userDoc.certifications,
        skills: userDoc.skills,
        connections: userDoc.connections,
        blockedUsers: userDoc.blockedUsers,
        jobsCompleted: userDoc.jobsCompleted,
        jobsPosted: userDoc.jobsPosted,
        savedJobs: userDoc.savedJobs,
        appliedJobs: userDoc.appliedJobs,
        jobsInProgress: userJobsInProgress,
        dateCreated: userDoc.dateCreated,
      ),
    );
  }

  static void toggleUserJobCompleted(User userDoc, Job job) {
    UserCRUD userCrud = UserCRUD();
    List<String> userJobsCompleted = userDoc.jobsCompleted;
    if (!userJobsCompleted.contains(job.id)) {
      userJobsCompleted.add(job.id);
    } else if (userJobsCompleted.contains(job.id)) {
      userJobsCompleted.remove(job.id);
    } else {
      print('error in toggleUserJobCompleted');
    }
    userCrud.updateUser(
      User(
        id: userDoc.id,
        uid: userDoc.uid,
        email: userDoc.email,
        username: userDoc.username,
        profilePic: userDoc.profilePic,
        name: userDoc.name,
        title: userDoc.title,
        bio: userDoc.bio,
        certifications: userDoc.certifications,
        skills: userDoc.skills,
        connections: userDoc.connections,
        blockedUsers: userDoc.blockedUsers,
        jobsCompleted: userJobsCompleted,
        jobsPosted: userDoc.jobsPosted,
        savedJobs: userDoc.savedJobs,
        appliedJobs: userDoc.appliedJobs,
        jobsInProgress: userDoc.jobsInProgress,
        dateCreated: userDoc.dateCreated,
      ),
    );
  }
}
