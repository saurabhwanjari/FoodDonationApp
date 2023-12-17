import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../constants/firebase_constants.dart';

//import 'package:donation_app/constants/firebase_constants.dart';

class ImageUpload {
  //
  //final String profilePictures = 'profilePictures';
  final ImagePicker imagePicker = ImagePicker();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  File? image;

  //
  Future<File?> captureImage(ImageSource imageSource) async {
    try {
      final pickedImage = await imagePicker.pickImage(source: imageSource);

      if (pickedImage != null) {
        image = File(pickedImage.path);
        return image!;
      }
    } catch (error) {
      //
    }

    return Future.value(null);
  }

  //
  Future<String> uploadImageToFirebase(File image, String folderName) async {
    print('image inside uploadImageToFirebase() = ${image.path}');
    try {
      //
      String fileExtension = image.path.toString().split('.').last;

      //
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString() +
          '.' +
          fileExtension;

      //
      Reference storageReference =
          firebaseStorage.ref('$folderName/$uniqueFileName');

      //
      UploadTask uploadTask = storageReference.putFile(image);

      // String downloadImageURL = await storageReference.getDownloadURL();

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      //
      String downloadImageURL = await taskSnapshot.ref.getDownloadURL();
      return downloadImageURL;
    } catch (error) {
      //return FirebaseConstants.defaultProfilePicture;
      return '';
    }
  }
}
