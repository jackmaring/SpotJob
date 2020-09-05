import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/services/firestore_api.dart';

class UserCRUD extends ChangeNotifier {
  FirestoreApi _api = FirestoreApi('/users');

  // Future<List<User>> fetchUsers() async {
  //   List<User> users;
  //   var result = await _api.getDataCollection();
  //   users = result.documents.map((doc) => User.fromJson(doc.data)).toList();
  //   return users;
  // }

  Stream<List<User>> getUsers() {
    return _api.streamDataCollection().map((snapshot) => snapshot.documents
        .map((document) => User.fromJson(document.data))
        .toList());
  }

  Stream<QuerySnapshot> fetchUsersAsStream() {
    return _api.streamDataCollection();
  }

  Future<User> getUserById(String id) async {
    var doc = await _api.getDocumentById(id);
    return User.fromJson(doc.data);
  }

  Future removeUser(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateUser(User data) async {
    await _api.updateDocument(data.toJson(), data.id);
    return;
  }

  Future addUser(User data) async {
    await _api
        .addDocument(data.toJson())
        .then((result) => {
              data.id = result.documentID,
              result.setData({'id': data.id}, merge: true)
            })
        .catchError((e) => {print(e.message)});
    return;
  }
}
