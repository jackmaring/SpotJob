import 'package:cloud_firestore/cloud_firestore.dart';

// enum PayType {
//   oneTime,
//   perHour,
// }

enum LocationType {
  remote,
  location,
}

class Job {
  String id;
  String uid;
  String title;
  String description;
  // PayType payType;
  double pay;
  LocationType locationType;
  String address;
  int numOfPeople;
  List<String> tags;
  bool isAvailable;
  bool isInProgress;
  bool isCompleted;
  Timestamp dateCreated;

  Job({
    this.id,
    this.uid,
    this.title,
    // this.payType,
    this.pay,
    this.locationType,
    this.description,
    this.address,
    this.numOfPeople,
    this.tags,
    this.isAvailable,
    this.isInProgress,
    this.isCompleted,
    this.dateCreated,
  });

  Job.fromJson(Map<String, dynamic> data)
      : this(
          id: data['id'],
          uid: data['uid'],
          title: data['title'],
          description: data['description'],
          // payType: _stringToPayType(data['payType']),
          pay: data['pay'],
          locationType: _stringToLocationType(data['locationType']),
          address: data['address'],
          numOfPeople: data['numOfPeople'],
          tags: data['tags'].cast<String>(),
          isAvailable: data['isAvailable'],
          isInProgress: data['isInProgress'],
          isCompleted: data['isCompleted'],
          dateCreated: data['dateCreated'],
        );

  Map<String, dynamic> toJson() => {
        'id': id ?? '',
        'uid': uid ?? '',
        'title': title ?? '',
        // 'payType': _payTypeToString(payType) ?? '',
        'pay': pay ?? 0,
        'locationType': _locationTypeToString(locationType) ?? '',
        'description': description ?? '',
        'address': address ?? '',
        'numOfPeople': numOfPeople ?? 0,
        'tags': tags ?? [],
        'isAvailable': isAvailable ?? false,
        'isInProgress': isInProgress ?? false,
        'isCompleted': isCompleted ?? false,
        'dateCreated': dateCreated,
      };

  // static PayType _stringToPayType(String payType) {
  //   if (payType == 'Per Hour') {
  //     return PayType.perHour;
  //   } else {
  //     return PayType.oneTime;
  //   }
  // }

  // static String _payTypeToString(PayType payType) {
  //   if (payType == PayType.perHour) {
  //     return 'Per Hour';
  //   } else {
  //     return 'One Time';
  //   }
  // }

  static LocationType _stringToLocationType(String locationType) {
    if (locationType == 'Remote') {
      return LocationType.remote;
    } else {
      return LocationType.location;
    }
  }

  static String _locationTypeToString(LocationType locationType) {
    if (locationType == LocationType.remote) {
      return 'Remote';
    } else {
      return 'Location';
    }
  }
}