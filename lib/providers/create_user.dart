import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:spotjob/models/user.dart';

class CreateUser with ChangeNotifier {
  double _profileTopContainerHeight;

  String _profilePicUrl = '';
  File _profileImg;
  bool _changedImg = false;
  String _name = '';
  String _title = '';
  String _bio = '';
  String _degree = '';
  String _institution = '';
  EducationType _educationType = EducationType.diploma;
  List<Certification> _certifications = [];
  String _skill = '';
  List<String> _skills = [];

  User _updatedUser;

  double get profileTopContainerHeight => _profileTopContainerHeight;

  String get profilePicUrl => _profilePicUrl;
  File get profileImg => _profileImg;
  bool get changedImg => _changedImg;
  String get name => _name;
  String get title => _title;
  String get bio => _bio;
  String get degree => _degree;
  String get institution => _institution;
  EducationType get educationType => _educationType;
  List<Certification> get certifications => _certifications;
  String get skill => _skill;
  List<String> get skills => [..._skills];

  User get updatedUser => _updatedUser;

  set profileTopContainerHeight(double value) {
    _profileTopContainerHeight = value;
    notifyListeners();
  }

  set profilePicUrl(String value) {
    _profilePicUrl = value;
    notifyListeners();
  }

  set profileImg(File value) {
    _changedImg = true;
    if (profilePicUrl == '') {
      profilePicUrl = 'changed';
    }
    _profileImg = value;

    notifyListeners();
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  set bio(String value) {
    _bio = value;
    notifyListeners();
  }

  set degree(String value) {
    _degree = value;
    notifyListeners();
  }

  set institution(String value) {
    _institution = value;
    notifyListeners();
  }

  set educationType(EducationType value) {
    _educationType = value;
    notifyListeners();
  }

  set certifications(List<Certification> certs) {
    _certifications = certs;
    notifyListeners();
  }

  void addCertification(Certification newCertification) {
    if (!_certifications.contains(newCertification)) {
      _certifications.add(newCertification);
      _resetCertification();
    }
    notifyListeners();
  }

  void removeCertification(Certification certification) {
    _certifications.remove(certification);
    notifyListeners();
  }

  void _resetCertification() {
    this.degree = '';
    this.institution = '';
    this.educationType = EducationType.diploma;
    notifyListeners();
  }

  set skills(List<String> skills) {
    _skills = skills;
    notifyListeners();
  }

  set skill(String value) {
    _skill = value;
    notifyListeners();
  }

  void addSkill(String skill) {
    if (!_skills.contains(skill)) {
      _skills.add(skill);
    }
    notifyListeners();
  }

  void removeSkill(String skill) {
    _skills.remove(skill);
    notifyListeners();
  }

  set updatedUser(User value) {
    _updatedUser = value;
    notifyListeners();
  }

  void loadUserData(User user) {
    this._profilePicUrl = user.profilePic;
    this._name = user.name;
    this._title = user.title;
    this._bio = user.bio;
    this._certifications = user.certifications;
    this._skills = user.skills;
    notifyListeners();
  }

  void resetCreateUser() {
    this._profilePicUrl = '';
    this._profileImg = null;
    this._changedImg = false;
    this._name = '';
    this._title = '';
    this._bio = '';
    this._degree = '';
    this._institution = '';
    this._educationType = EducationType.diploma;
    this._certifications = [];
    this._skill = '';
    this._skills = [];
    this._updatedUser = null;
    notifyListeners();
  }
}
