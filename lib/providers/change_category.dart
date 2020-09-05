import 'package:flutter/foundation.dart';

import 'package:spotjob/models/category.dart' as cat;
import 'package:spotjob/models/job.dart';

class ChangeCategory with ChangeNotifier {
  cat.Category _currentCategory;
  String _currentSubcategory;
  String _categoryLabel = 'ALL JOBS';
  String _subcategoryLabel = 'ALL JOBS';

  // PayType _filterPayType = PayType.oneTime;
  double _filterPayRangeLowerValue = 0;
  double _filterPayRangeUpperValue = 200;
  bool _anyPay = false;
  LocationType _filterLocationType = LocationType.location;
  bool _anyLocationType = false;
  List<String> _filterTags = [];
  bool _hasSetCustomFilter = false;

  cat.Category get currentCategory => _currentCategory;
  String get currentSubcategory => _currentSubcategory;
  String get categoryLabel => _categoryLabel;
  String get subcategoryLabel => _subcategoryLabel;

  // PayType get filterPayType => _filterPayType;
  double get filterPayRangeLowerValue => _filterPayRangeLowerValue;
  double get filterPayRangeUpperValue => _filterPayRangeUpperValue;
  bool get anyPay => _anyPay;
  LocationType get filterLocationType => _filterLocationType;
  bool get anyLocationType => _anyLocationType;
  List<String> get filterTags => [..._filterTags];
  bool get hasSetCustomFilter => _hasSetCustomFilter;

  void changeToAllJobs() {
    _categoryLabel = 'ALL JOBS';
    _subcategoryLabel = 'ALL JOBS';
    _currentCategory = null;
    _currentSubcategory = null;
    if (hasSetCustomFilter) {
      resetFilterStats();
    }
    notifyListeners();
    // savePreferences();
  }

  void changeCategory(cat.Category category) {
    _currentCategory = category;
    _categoryLabel = category.name;
    _currentSubcategory = null;
    _subcategoryLabel = 'ALL ${category.name}';
    if (hasSetCustomFilter) {
      resetFilterStats();
    }
    notifyListeners();
    // savePreferences();
  }

  void changeToCustomFilter() {
    _hasSetCustomFilter = true;
    _categoryLabel = 'CUSTOM';
    _subcategoryLabel = 'CUSTOM';
    _currentCategory = null;
    _currentSubcategory = null;
    notifyListeners();
  }

  void changeSubcategory(String subcategory) {
    _currentSubcategory = subcategory;
    _subcategoryLabel = subcategory;
    notifyListeners();
    // savePreferences();
  }

  void changeToAllSubcategories() {
    _currentSubcategory = null;
    _subcategoryLabel = 'ALL ${currentCategory.name}';
    notifyListeners();
    // savePreferences();
  }

  // set filterPayType(PayType value) {
  //   _filterPayType = value;
  //   notifyListeners();
  // }

  set filterPayRangeLowerValue(double value) {
    _filterPayRangeLowerValue = value;
    notifyListeners();
  }

  set filterPayRangeUpperValue(double value) {
    _filterPayRangeUpperValue = value;
    notifyListeners();
  }

  set anyPay(bool value) {
    _anyPay = value;
    notifyListeners();
  }

  void toggleAnyPay() {
    if (anyPay == false) {
      anyPay = true;
      filterPayRangeLowerValue = null;
      filterPayRangeUpperValue = null;
    } else {
      anyPay = false;
      filterPayRangeLowerValue = 0;
      filterPayRangeUpperValue = 200;
    }
    notifyListeners();
  }

  set filterLocationType(LocationType value) {
    _filterLocationType = value;
    notifyListeners();
  }

  set anyLocationType(bool value) {
    _anyLocationType = value;
    notifyListeners();
  }

  void toggleAnyLocationType() {
    if (anyLocationType == false) {
      anyLocationType = true;
      filterLocationType = null;
    } else {
      anyLocationType = false;
      filterLocationType = LocationType.location;
    }
    notifyListeners();
  }

  void addFilterTag(String tag) {
    _filterTags.add(tag);
    notifyListeners();
  }

  void removeFilterTag(String tag) {
    _filterTags.remove(tag);
    notifyListeners();
  }

  void addAllCategories(List<cat.Category> categories) {
    categories.forEach((cat) {
      if (!filterTags.contains(cat.name)) {
        addFilterTag(cat.name);
      }
      cat.subcategories.forEach((subCat) {
        if (!filterTags.contains(subCat)) {
          addFilterTag(subCat);
        }
      });
    });
    notifyListeners();
  }

  void removeAllCategories(List<cat.Category> categories) {
    categories.forEach((cat) {
      if (filterTags.contains(cat.name)) {
        removeFilterTag(cat.name);
      }
      cat.subcategories.forEach((subCat) {
        if (filterTags.contains(subCat)) {
          removeFilterTag(subCat);
        }
      });
    });
    notifyListeners();
  }

  void addCategoryTag(cat.Category category) {
    if (!filterTags.contains(category.name)) {
      addFilterTag(category.name);
    }
    category.subcategories.forEach((subCat) {
      if (!filterTags.contains(subCat)) {
        addFilterTag(subCat);
      }
    });
    notifyListeners();
  }

  void removeCategoryTag(cat.Category category) {
    if (filterTags.contains(category.name)) {
      removeFilterTag(category.name);
    }
    category.subcategories.forEach((subCat) {
      if (filterTags.contains(subCat)) {
        removeFilterTag(subCat);
      }
    });
    notifyListeners();
  }

  void addSubcategoryTag(cat.Category category, String subcategory) {
    if (!filterTags.contains(subcategory)) {
      addFilterTag(subcategory);
    }
    if (category.subcategories.every(
      (subCat) => filterTags.contains(subCat),
    )) {
      addFilterTag(category.name);
    }
    notifyListeners();
  }

  void removeSubcategoryTag(cat.Category category, String subcategory) {
    if (filterTags.contains(subcategory)) {
      removeFilterTag(subcategory);
    }
    if (!category.subcategories.every(
      (sub) => filterTags.contains(sub),
    )) {
      removeFilterTag(category.name);
    }
    notifyListeners();
  }

  set hasSetCustomFilter(bool value) {
    _hasSetCustomFilter = value;
    notifyListeners();
  }

  void resetFilterStats() {
    this._filterPayRangeLowerValue = 0;
    this._filterPayRangeUpperValue = 200;
    this._filterLocationType = LocationType.location;
    this._filterTags = [];
    this._hasSetCustomFilter = false;
    notifyListeners();
  }

  // savePreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('category', json.encode(_currentCategory));
  //   prefs.setString('subcategory', json.encode(_currentSubcategory));
  //   prefs.setString('categoryLabel', json.encode(_categoryLabel));
  //   prefs.setString('subcategoryLabel', json.encode(_subcategoryLabel));
  // }

  // loadPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Category category = Category.fromJson(
  //     json.decode(prefs.getString('category')),
  //   );
  //   String subcategory = prefs.getString('subcategory');
  //   String categoryLabel = prefs.getString('categoryLabel');
  //   String subcategoryLabel = prefs.getString('subcategoryLabel');

  //   if (category != null) _currentCategory = category;
  //   if (subcategory != null) _currentSubcategory = subcategory;
  //   if (categoryLabel != null) _categoryLabel = categoryLabel;
  //   if (subcategoryLabel != null) _subcategoryLabel = subcategoryLabel;
  // }
}
