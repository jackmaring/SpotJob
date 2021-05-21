import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spotjob/models/sj_notification.dart';
import 'package:spotjob/services/firestore_api.dart';

class SJNotificationCRUD {
  FirestoreApi _api = FirestoreApi('/notifications');

  Future<List<SJNotification>> fetchSJNotifications() async {
    var result = await _api.getDataCollection();
    List<SJNotification> sjnotifications =
        result.docs.map((doc) => SJNotification.fromJson(doc.data())).toList();
    return sjnotifications;
  }

  Stream<List<SJNotification>> getSJNotifications() {
    return _api.streamDataCollectionByDateCreated().map((snapshot) => snapshot
        .docs
        .map((document) => SJNotification.fromJson(document.data()))
        .toList());
  }

  Stream<QuerySnapshot> fetchSJNotificationsStream() {
    return _api.streamDataCollection();
  }

  Future<SJNotification> getNotificationById(String id) async {
    var doc = await _api.getDocumentById(id);
    return SJNotification.fromJson(doc.data());
  }

  Future removeSJNotification(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateSJNotification(SJNotification data) async {
    await _api.updateDocument(data.toJson(), data.id);
    return;
  }

  Future<SJNotification> addSJNotification(SJNotification data) async {
    await _api
        .addDocument(data.toJson())
        .then((result) => {
              data.id = result.id,
              result.set({'id': data.id}, SetOptions(merge: true))
            })
        .catchError((e) => {print(e.message)});
    return data;
  }
}
