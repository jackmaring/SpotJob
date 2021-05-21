import 'package:cloud_firestore/cloud_firestore.dart';

enum EducationType {
  diploma,
  certificate,
}

class Certification {
  String degree;
  String institution;
  EducationType educationType;

  Certification({
    this.degree,
    this.institution,
    this.educationType,
  });

  Certification.fromJson(Map<String, dynamic> data)
      : this(
          degree: data['degree'],
          institution: data['institution'],
          educationType: _stringToEducationType(
            data['educationType'],
          ),
        );

  Map<String, dynamic> toJson() => {
        'degree': degree,
        'institution': institution,
        'educationType': _educationTypeToString(educationType),
      };

  static EducationType _stringToEducationType(String educationType) {
    if (educationType == 'Diploma') {
      return EducationType.diploma;
    } else {
      return EducationType.certificate;
    }
  }

  static String _educationTypeToString(EducationType educationType) {
    if (educationType == EducationType.diploma) {
      return 'Diploma';
    } else {
      return 'Certificate';
    }
  }
}

class User {
  String id;
  String uid;
  String email;
  String username;
  String profilePic;
  String name;
  String title;
  String bio;
  List<Certification> certifications;
  List<String> skills;
  List<String> connections;
  List<String> blockedUsers;
  List<String> jobsCompleted;
  List<String> jobsPosted;
  // I wanna make saved and applied jobs be on the job model in the future
  List<String> savedJobs;
  List<String> appliedJobs;
  List<String> jobsInProgress;
  String token;
  Timestamp dateCreated;

  User({
    this.id,
    this.uid,
    this.email,
    this.username,
    this.profilePic,
    this.name,
    this.title,
    this.bio,
    this.certifications,
    this.skills,
    this.connections,
    this.blockedUsers,
    this.jobsCompleted,
    this.jobsPosted,
    this.savedJobs,
    this.appliedJobs,
    this.jobsInProgress,
    this.token,
    this.dateCreated,
  });

  User.fromJson(Map<String, dynamic> data)
      : this(
          id: data['id'],
          uid: data['uid'],
          email: data['email'],
          username: data['username'],
          profilePic: data['profilePic'],
          name: data['name'],
          title: data['title'],
          bio: data['bio'],
          certifications: data['certifications'] != null
              ? data['certifications']
                  .map((cert) => Certification.fromJson(cert))
                  .cast<Certification>()
                  .toList()
              : [],
          skills: data['skills'].cast<String>(),
          connections: data['connections'].cast<String>(),
          blockedUsers: data['blockedUsers'].cast<String>(),
          jobsCompleted: data['jobsCompleted'].cast<String>(),
          jobsPosted: data['jobsPosted'].cast<String>(),
          savedJobs: data['savedJobs'].cast<String>(),
          appliedJobs: data['appliedJobs'].cast<String>(),
          jobsInProgress: data['jobsInProgress'].cast<String>(),
          token: data['token'],
          dateCreated: data['dateCreated'],
        );

  Map<String, dynamic> toJson() => {
        'id': id ?? '',
        'uid': uid ?? '',
        'email': email ?? '',
        'username': username ?? '',
        'profilePic': profilePic ?? '',
        'name': name ?? '',
        'title': title ?? '',
        'bio': bio ?? '',
        'certifications': certifications != null
            ? certifications.map((cert) => cert.toJson()).toList()
            : [],
        'skills': skills ?? [],
        'connections': connections ?? [],
        'blockedUsers': blockedUsers ?? [],
        'jobsCompleted': jobsCompleted ?? [],
        'jobsPosted': jobsPosted ?? [],
        'savedJobs': savedJobs ?? [],
        'appliedJobs': appliedJobs ?? [],
        'jobsInProgress': jobsInProgress ?? [],
        'token': token ?? '',
        'dateCreated': dateCreated,
      };
}
