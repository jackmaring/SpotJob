import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreApi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  FirestoreApi(this.path) {
    ref = _db.collection(path);
  }

  CollectionReference getCollectionRef() {
    return ref;
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionByDateCreated() {
    return ref.orderBy('dateCreated').snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<DocumentSnapshot> getDocumentByAccountId(String accountId) async {
    QuerySnapshot query =
        await ref.where("accountId", isEqualTo: accountId).get();
    List<DocumentSnapshot> documents = query.docs;
    return documents[0];
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future addDocumentWithId(String id, Map data) async {
    await ref.doc(id).set(data);
    return;
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }
}
