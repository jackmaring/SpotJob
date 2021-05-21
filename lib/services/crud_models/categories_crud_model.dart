import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spotjob/models/category.dart';
import 'package:spotjob/services/firestore_api.dart';

class CategoryCRUD {
  FirestoreApi _api = FirestoreApi('/categories');

  List<Category> categories;

  Future<List<Category>> fetchCategories() async {
    var result = await _api.getDataCollection();
    categories =
        result.docs.map((doc) => Category.fromJson(doc.data())).toList();
    return categories;
  }

  Stream<List<Category>> getCategories() {
    return _api.streamDataCollection().map((snapshot) =>
        snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList());
  }

  Stream<QuerySnapshot> fetchCategoriesAsStream() {
    return _api.streamDataCollection();
  }

  Future<Category> getCategoryById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Category.fromJson(doc.data());
  }

  Future removeCategory(String id) async {
    await _api.removeDocument(id);
    return;
  }

  // Future updateCategory(Category data, String id) async {
  //   await _api.updateDocument(data.toJson(), id);
  //   return;
  // }

  // Future addCategory(Category data) async {
  //   await _api
  //       .addDocument(data.toJson())
  //       .then((result) => {
  //             data.id = result.documentID,
  //             result.setData({'id': data.id}, merge: true)
  //           })
  //       .catchError((e) => {print(e.message)});
  //   return;
  // }
}
