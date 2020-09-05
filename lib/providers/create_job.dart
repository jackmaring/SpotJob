import 'package:flutter/foundation.dart';

import 'package:spotjob/models/category.dart' as cat;
import 'package:spotjob/models/job.dart';
import 'package:spotjob/models/user.dart';

class CreateJob with ChangeNotifier {
  double _jobInfoTopContainerHeight;

  String _titleText = '';
  String _descText = '';
  String _price = '0';
  // PayType _payType = PayType.oneTime;
  LocationType _locationType = LocationType.location;
  String _address = '';
  String _numOfPeople = '1';
  List<String> _tags = [];

  Job _updatedJob;

  User _personAccepted;
  // int _numOfPeopleRemaining = 0;
  // List<User> _peopleAccepted = [];

  double get jobInfoTopContainerHeight => _jobInfoTopContainerHeight;

  String get titleText => _titleText;
  String get descText => _descText;
  String get price => _price;
  // PayType get payType => _payType;
  LocationType get locationType => _locationType;
  String get address => _address;
  String get numOfPeople => _numOfPeople;
  List<String> get tags => [..._tags];

  Job get updatedJob => _updatedJob;

  User get personAccepted => _personAccepted;
  // int get numOfPeopleRemaining => _numOfPeopleRemaining;
  // List<User> get peopleAccepted => [..._peopleAccepted];

  set jobInfoTopContainerHeight(double value) {
    _jobInfoTopContainerHeight = value;
    notifyListeners();
  }

  set titleText(String value) {
    _titleText = value;
    notifyListeners();
  }

  set descText(String value) {
    _descText = value;
    notifyListeners();
  }

  set price(String value) {
    _price = value;
    notifyListeners();
  }

  // set payType(PayType value) {
  //   _payType = value;
  //   notifyListeners();
  // }

  set locationType(LocationType value) {
    _locationType = value;
    notifyListeners();
  }

  set address(String value) {
    _address = value;
    notifyListeners();
  }

  set numOfPeople(String value) {
    _numOfPeople = value;
    notifyListeners();
  }

  set tags(List<String> value) {
    _tags = value;
    notifyListeners();
  }

  void addTag(String tag) {
    _tags.add(tag);
    notifyListeners();
  }

  void removeTag(String tag) {
    _tags.remove(tag);
    notifyListeners();
  }

  void addCategoryTag(cat.Category category) {
    if (!tags.contains(category.name)) {
      addTag(category.name);
    }
    final bool onlyTagInTags = !category.subcategories.any(
      (subcategory) => tags.contains(subcategory),
    );
    if (onlyTagInTags) {
      addTag(category.subcategories.last);
    }
    notifyListeners();
  }

  void removeCategoryTag(cat.Category category) {
    if (tags.contains(category.name)) {
      removeTag(category.name);
    }
    category.subcategories.forEach((subCat) {
      if (tags.contains(subCat)) {
        removeTag(subCat);
      }
    });
    notifyListeners();
  }

  void addSubcategoryTag(cat.Category category, String subcategory) {
    if (tags.contains(category.name)) {
      addTag(subcategory);
    } else {
      addTag(category.name);
      addTag(subcategory);
    }
    notifyListeners();
  }

  void removeSubcategoryTag(cat.Category category, String subcategory) {
    if (tags.contains(subcategory)) {
      removeTag(subcategory);
    }
    if (!category.subcategories.any((subcat) => tags.contains(subcat))) {
      addTag(category.subcategories.last);
    }
    notifyListeners();
  }

  set updatedJob(Job value) {
    _updatedJob = value;
    notifyListeners();
  }

  set personAccepted(User value) {
    _personAccepted = value;
    notifyListeners();
  }

  // set numOfPeopleRemaining(int value) {
  //   _numOfPeopleRemaining = value;
  //   notifyListeners();
  // }

  // void togglePeopleAccepted(User acceptedUser) {
  //   if (!_peopleAccepted.contains(acceptedUser) &&
  //       _numOfPeopleRemaining > 0) {
  //     _peopleAccepted.add(acceptedUser);
  //     _numOfPeopleRemaining--;
  //   } else if (_peopleAccepted.contains(acceptedUser)) {
  //     _peopleAccepted.remove(acceptedUser);
  //     _numOfPeopleRemaining++;
  //   }
  //   notifyListeners();
  // }

  // void loadNumOfPeopleRemaining(Job job) {
  //   this._numOfPeopleRemaining = job.numOfPeople;
  // }

  void loadJobData(Job job) {
    this._titleText = job.title;
    this._descText = job.description;
    this._price = job.pay.toString();
    // this._payType = job.payType;
    this._locationType = job.locationType;
    this._address = job.address;
    // this._numOfPeople = job.numOfPeople.toString();
    this._tags = job.tags;
    notifyListeners();
  }

  void resetCreateJobStats() {
    _titleText = '';
    _descText = '';
    _price = '0';
    // _payType = PayType.oneTime;
    _locationType = LocationType.location;
    _address = '';
    // _numOfPeople = '1';
    _personAccepted = null;
    _tags = [];
    notifyListeners();
  }
}
