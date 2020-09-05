import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageFilePicker {
  static Future<File> retrieveImageFileFromLibrary() async {
    imageCache.clear();
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    File img = File(pickedFile.path);
    return img;
  }

  static Future<File> retrieveAndCropImageFileFromLibrary() async {
    imageCache.clear();
    File croppedImageFile;
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    File img = File(pickedFile.path);
    if (img != null) {
      croppedImageFile = await cropImage(img);
    }
    return croppedImageFile;
  }

  static Future<File> retrieveImageFileFromCamera() async {
    imageCache.clear();
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    File img = File(pickedFile.path);
    return img;
  }

  static Future<File> retrieveAndCropImageFileFromCamera() async {
    imageCache.clear();
    File croppedImageFile;
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    File img = File(pickedFile.path);
    if (img != null) {
      croppedImageFile = await cropImage(img);
    }
    return croppedImageFile;
  }

  static Future<File> cropImage(File img) async {
    File croppedImageFile;
    croppedImageFile = await ImageCropper.cropImage(
      sourcePath: img.path,
      aspectRatio: CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 50,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.white,
      ),
    );
    return croppedImageFile;
  }
}
