import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/constants/app_colors.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/models/ngo_head.dart';
import 'package:donation_app/services/edit_ngo.dart';
import 'package:donation_app/services/firestore_services_ngo.dart';
import 'package:donation_app/services/image_upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/firebase_constants.dart';
import '../../services/image_capture_services.dart';

class EditNGOController extends GetxController {
  //
  TextEditingController ngoNameController = TextEditingController();
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController peopleInOrganizationController =
      TextEditingController();
  TextEditingController campaignsController = TextEditingController();
  TextEditingController eventsController = TextEditingController();
  final GlobalKey<FormState> registrationKey = GlobalKey<FormState>();
  NGODataController ngoDataController = Get.find<NGODataController>();

  var imageCaptured = false.obs;
  late Rx<File?> image =
      File(ngoDataController.rxNGOHead.value.profilePicture).obs;
  var isLoading = false.obs;
  String? downloadURL;

  ImageSource? imageSource;
  ImageUpload imageUpload = ImageUpload();

  //
  void initializeData() {
    image.value = File('${ngoDataController.rxNGOHead.value.profilePicture}');
    downloadURL = ngoDataController.rxNGOHead.value.profilePicture;
    ngoNameController.text = ngoDataController.rxNGOHead.value.name;
    organizationNameController.text =
        ngoDataController.rxNGOHead.value.organizationName;
    addressController.text = ngoDataController.rxNGOHead.value.address;
    peopleInOrganizationController.text =
        ngoDataController.rxNGOHead.value.peopleInOrganization;
    campaignsController.text = ngoDataController.rxNGOHead.value.campaignsDone;
    eventsController.text = ngoDataController.rxNGOHead.value.eventsDone;
    image = File('').obs;
  }

  ImageCaptureServices imageCaptureServices = ImageCaptureServices();
  Future<void> captureOnCick() async {
    try {
      imageSource = await imageCaptureServices.showImageCapturedOptions();

      if (imageSource != null) {
        image.value = await imageUpload.captureImage(imageSource!);
        print('image scource:$imageSource');

        if (image.value != null && image.value!.path != '') {
          imageCaptured.value = true;
        } else {
          imageCaptured.value = false;
        }
      }
    } catch (error) {}
  }

  //
  void deleteCaputedImage() {
    imageCaptured.value = false;

    if (image.value != null) {
      image.value = File('');
    }
  }

  //
  // validate name field
  String? validateName(String? name) {
    print('inside validate');
    if (name == '') {
      return 'Please enter your name';
    }

    String pattern = r'[0-9]';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(name!)) {
      return 'Name cannot have digit';
    }

    return null;
  }
  // save name field

  void saveName(String? name) {
    ngoNameController.text = name!;
  }

  // validate organizationName field
  String? validateOrganizationName(String? name) {
    print('inside validate');
    if (name == '') {
      return 'Please enter your name';
    }

    String pattern = r'[0-9]';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(name!)) {
      return 'Organization Name cannot have digit';
    }

    return null;
  }
  // save Organization name field

  void saveorganizationName(String? name) {
    organizationNameController.text = name!;
  }

  // validate address field
  String? validateAddress(String? name) {
    if (name == '') {
      return 'Please enter your address';
    }

    return null;
  }
  // save address field

  void saveAddress(String? name) {
    addressController.text = name!;
  }

  // validate people in organization field
  String? validatePeopleInOrganization(String? name) {
    if (name == '') {
      return 'Please enter your people in organization';
    }

    String pattern = r'[^\d{3}$]';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(name!)) {
      return 'People in organization should not have any letter';
    }

    return null;
  }
  // save people in organization field

  void savePeopleInOrganization(String? name) {
    peopleInOrganizationController.text = name!;
  }

  // validate Campaigns field
  String? validateCampaigns(String? name) {
    if (name == '') {
      return 'Please enter Number of Campaigns Done';
    }

    String pattern = r'[^\d{3}$]';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(name!)) {
      return 'Campaigns done should not have any letter';
    }

    return null;
  }
  // save Campaigns field

  void saveCampaigns(String? name) {
    campaignsController.text = name!;
  }

  // validate events field
  String? validateEvents(String? name) {
    if (name == '') {
      return 'Please enter Number of Events Done';
    }

    String pattern = r'[^\d{3}$]';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(name!)) {
      return 'Events done should not have any letter';
    }

    return null;
  }
  // save Events field

  void saveEvents(String? name) {
    eventsController.text = name!;
  }

  Future<void> updateNGOProfile() async {
    bool isValidate = registrationKey.currentState!.validate();

    if (isValidate) {
      //
      isLoading.value = true;

      //
      registrationKey.currentState!.save();

      //
      User? user = FirebaseAuth.instance.currentUser;

      await user!.reload();

      //
      if (image.value != null && image.value!.path != '') {
        downloadURL = await imageUpload.uploadImageToFirebase(
            image.value!, FirebaseConstants.profilePictures);

        imageCaptured.value = false;
      }

      NGOHead ngoHead = NGOHead(
        name: ngoNameController.text,
        organizationName: organizationNameController.text,
        peopleInOrganization: peopleInOrganizationController.text,
        ngoCertificationNumber:
            ngoDataController.ngoHead.ngoCertificationNumber,
        campaignsDone: campaignsController.text,
        eventsDone: eventsController.text,
        getFoodFromSupplier: ngoDataController.ngoHead.getFoodFromSupplier,
        address: addressController.text,
        cityName: ngoDataController.ngoHead.cityName,
        description: ngoDataController.ngoHead.description,
        gender: ngoDataController.ngoHead.gender,
        profilePicture: downloadURL ?? FirebaseConstants.defaultProfilePicture,
        mobileNumber: user.phoneNumber!,
      );

      //
      EditNGO editNGO = EditNGO();

      bool isRegistered = await editNGO.editNGO(ngoHead);

      //
      if (isRegistered) {
        await user.reload();

        //getting firebase instance to check if user is registered or not
        FirebaseFirestore firebaseFirestore =
            FirestoreServicesNGO.firebaseFirestore;
        DocumentSnapshot documentSnapshot = await firebaseFirestore
            .collection(FirestoreServicesNGO.ngoUsersCollection)
            .doc(user.uid)
            .get();

        print('collection name : ${FirestoreServicesNGO.ngoUsersCollection}');

        await user.reload();

        NGOHead ngoHead = NGOHead.fromDoucmentSnapshot(documentSnapshot);

        //Put or save this ngoHead inside the ngoDataController
        NGODataController ngoDataController = Get.find<NGODataController>();
        ngoDataController.rxNGOHead.value = ngoHead;
        await user.reload();
        isLoading.value = false;
        Get.back();
      }

      isLoading.value = false;
    } else {
      Get.showSnackbar(GetSnackBar(
        duration: Duration(seconds: 3),
        title: 'Can\'' 't edit your data',
        message: 'Please fill all the details carefully!',
        backgroundColor: Get.theme.colorScheme.onSecondary,
      ));
    }
  }
}
