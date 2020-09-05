import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileUploader {
  static Future<String> uploadFile(
      String collectionName, String fileName, File file) async {
    final StorageReference storageRef = FirebaseStorage.instance.ref();

    var snapshot = await storageRef
        .child(collectionName)
        .child(fileName)
        .putFile(file)
        .onComplete;

    var downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl.toString();
  }
}
