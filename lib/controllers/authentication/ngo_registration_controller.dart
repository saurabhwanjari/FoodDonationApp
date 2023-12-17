import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/demo/test.dart';
import 'package:donation_app/screens/supplier_screens/supplierhomepage.dart';
import 'package:donation_app/services/image_capture_services.dart';
import 'package:donation_app/services/register_ngo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:donation_app/services/image_upload.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../constants/firebase_constants.dart';
import '../../models/ngo_head.dart';
import 'package:donation_app/services/image_capture_services.dart';

import '../../screens/ngo_screens/ngohomepage.dart';
import '../../services/firestore_services_ngo.dart';

class NGORegistrationController extends GetxController {
  //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController peopleInOrganizationController =
      TextEditingController();
  final TextEditingController certificationNumberController =
      TextEditingController();
  final TextEditingController campaignController = TextEditingController();
  final TextEditingController eventController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ImageCaptureServices imageCaptureServices = ImageCaptureServices();
  final GlobalKey<FormState> ngoregistrationKey = GlobalKey<FormState>();

  //
  var isLoading = false.obs;
  var showHideregisterButton = false.obs;
  var cities = ''.obs;

  //
  String? downloadURL;

  //

  final List<String> genderList = ['Male', 'Female'];

  //
  final List<String> city = ['Yavatmal'];

  //
  final List<String> getFoodFromSupplierList = ['Yes', 'No'];

  //

  var gender = ''.obs;
  var getFromSupplier = ''.obs;
  int selectedIndexforGender = -1;
  int selectedIndexforgetFoodFromSupplier = -1;

  //
  var imageCaptured = false.obs;
  late Rx<File?> image = File('').obs;

  ImageSource? imageSource;
  ImageUpload imageUpload = ImageUpload();

  //

  //
  void onGenderSelected(int index, bool isSelected) {
    gender.value = genderList[index];
    selectedIndexforGender = genderList.indexOf(gender.value);
    isSelected = true;
  }

  //
  void onCityChanged(String? newCatergory) {
    //
    cities.value = newCatergory!;
  }

  //
  void onGetFoodFromSupplierSelected(int index, bool isSelected) {
    getFromSupplier.value = getFoodFromSupplierList[index];
    selectedIndexforgetFoodFromSupplier =
        getFoodFromSupplierList.indexOf(getFromSupplier.value);
    isSelected = true;
  }

  //Validation

  //validate name field
  String? validateName(String? name) {
    print('Inside validate');
    if (name == '') {
      return 'Please enter your name';
    }

    String pattern = r'[0-9]';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(name!)) {
      return 'Name can not have digit';
    }

    return null;
  }

  //Save name field
  void saveName(String? name) {
    nameController.text = name!;
  }

  //validate organization name field
  String? validateOrganizationName(String? oname) {
    print('Inside validate');
    if (oname == '') {
      return 'Please enter your organization name';
    }

    String pattern = r'[0-9]';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(oname!)) {
      return 'Name can not have digit';
    }

    return null;
  }

  //Save organization name field
  void saveOrganizationName(String? oname) {
    organizationNameController.text = oname!;
  }

  //validate people in organization
  String? validatePeopleInOrganization(String? name) {
    if (name == '') {
      return 'Please enter  people in your organization';
    }

    String pattern = r'[A-Z] | [a-z]';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(name!)) {
      return 'People in Organization should not have any letter';
    }

    String patt = r'[0-9]';
    RegExp reg = RegExp(patt);

    if (!reg.hasMatch(patt)) {
      return 'Please enter  people in your organization';
    }
    return null;
  }
  // save people in organization field

  void savePeopleInOrganization(String? name) {
    peopleInOrganizationController.text = name!;
  }

  //validate ngo Certification Number
  String? validateNgoCertificationNumber(String? name) {
    if (name == '') {
      return 'Please enter your ngo Certification Number';
    }

    var patt = RegExp(r'^[0-9]{16}$');

    if (patt.hasMatch(name!)) {
      return null;
    } else {
      return 'Please enter proper Certification Number';
    }
  }
  // save ngo Certification Number field

  void saveNgoCertificationNumber(String? name) {
    certificationNumberController.text = name!;
  }

  // validate Campaigns field
  String? validateCampaigns(String? name) {
    if (name == '') {
      return 'Please enter Number of Campaigns Done';
    }

    String patt = r'[0-9]';
    RegExp reg = RegExp(patt);

    if (!reg.hasMatch(patt)) {
      return 'Please enter Number of Campaigns Done';
    }

    return null;
  }
  // save Campaigns field

  void saveCampaigns(String? name) {
    campaignController.text = name!;
  }

  // validate events field
  String? validateEvents(String? name) {
    if (name == '') {
      return 'Please enter Number of Events Done';
    }

    String patt = r'[0-9]';
    RegExp reg = RegExp(patt);

    if (!reg.hasMatch(patt)) {
      return 'Please enter Number of Events Done';
    }

    return null;
  }
  // save Events field

  void saveEvents(String? name) {
    eventController.text = name!;
  }

  //validate address field
  String? validateAddress(String? name) {
    print('Inside validate');
    if (name == '') {
      return 'Please enter your name';
    }

    return null;
  }

  //Save address field
  void saveAddress(String? name) {
    addressController.text = name!;
  }

  //validate description field
  String? validateDescription(String? name) {
    print('Inside validate');
    if (name == '') {
      return 'Please enter description';
    }

    return null;
  }

  //Save description field
  void saveDescription(String? name) {
    descriptionController.text = name!;
  }

  //
  Future<void> captureOnClick() async {
    imageSource = await imageCaptureServices.showImageCapturedOptions();
    //
    try {
      if (imageSource != null) {
        image.value = await imageUpload.captureImage(imageSource!);

        if (image.value != null && image.value!.path != '') {
          imageCaptured.value = true;
        } else {
          imageCaptured.value = false;
        }
      }
    } catch (error) {
      print(error);
    }
  }

  //
  Future<void> saveUserData() async {
    try {
      if (gender == '') {
        Get.showSnackbar(
           GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Registration Failed',
            message: 'Please Select Gender',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (cities == '') {
        Get.showSnackbar(
           GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Registration Failed',
            message: 'Please Select Your City',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (ngoregistrationKey.currentState!.validate() == false) {
        Get.showSnackbar(
           GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Registration Failed',
            message: 'Please fill all the details carefully!!',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else {
        //
        isLoading.value = true;

        //
        ngoregistrationKey.currentState!.save();

        User? user = FirebaseAuth.instance.currentUser;

        //
        await user!.reload();

        //
        if (image.value != null && image.value!.path != '') {
          downloadURL = await imageUpload.uploadImageToFirebase(
            image.value!,
            FirebaseConstants.profilePictures,
          );
        }

        //
        NGOHead ngoHead = NGOHead(
          name: nameController.text,
          organizationName: organizationNameController.text,
          peopleInOrganization: peopleInOrganizationController.text,
          ngoCertificationNumber: certificationNumberController.text,
          campaignsDone: campaignController.text,
          eventsDone: eventController.text,
          getFoodFromSupplier: getFromSupplier.value,
          //latitude: latitude.value.toString(),
          //longitude: longitude.value.toString(),
          address: addressController.text,
          cityName: cities.value,
          description: descriptionController.text,
          gender: gender.value,
          mobileNumber: user.phoneNumber!,
          profilePicture:
              downloadURL ?? FirebaseConstants.defaultProfilePicture,
        );

        //
        RegisterNGO registerNGO = RegisterNGO();

        //
        bool isRegistered = await registerNGO.registerNGO(ngoHead);

        if (isRegistered) {
          //
          await user.reload();

          //getting firebase instance to check if user is registered or not
          FirebaseFirestore firebaseFirestoreNGO =
              FirestoreServicesNGO.firebaseFirestore;
          DocumentSnapshot documentSnapshotNGO = await firebaseFirestoreNGO
              .collection(FirestoreServicesNGO.ngoUsersCollection)
              .doc(user.uid)
              .get();

          //
          await user.reload();

          //
          NGOHead ngoHead = NGOHead.fromDoucmentSnapshot(documentSnapshotNGO);

          // Put or save this ngo inside the NGODataController
          // to use it as globle object in entire app
          Get.put(NGODataController(ngoHead: ngoHead));

          //
          Get.off(() => NGOHomePage()); // -----------------> Main Page to load
          //Get.off(TestPage());
        } else {
          //..
        }

        // print('name=${ngoHead.name}');
        // print('organizationName =${ngoHead.organizationName}');
        // print('address =${ngoHead.address}');
        // print('cityName =${ngoHead.cityName}');
        // print('description =${ngoHead.description}');
        // print('gender=${ngoHead.gender}');
        // print('profilePicture=${ngoHead.profilePicture}');

        //
        isLoading.value = false;
      }
    } catch (error) {
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 3),
          title: 'Registration Failed',
          message: 'Please fill all the details carefully!!',
          backgroundColor: Get.theme.colorScheme.onSecondary,
        ),
      );
    }
    //
    //bool isValidate = ngoregistrationKey.currentState!.validate();

    // if (isValidate) {
    //   //
    // } else {
    //   Get.showSnackbar(
    //     GetSnackBar(
    //       duration: Duration(seconds: 3),
    //       title: 'Registration Failed',
    //       message: 'Please fill all the details',
    //       backgroundColor: Get.theme.colorScheme.onSecondary,
    //     ),
    //   );
    // }

    //get current location logic
    // var latitude = 'Getting Latitude..'.obs;
    // var longitude = 'Getting Longitude..'.obs;
    // var address = 'Getting Address..'.obs;
    // late var position = ''.obs;

    // void getLocation() async {
    //   //check location service is eanbled
    //   bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    //   if (!isServiceEnabled) {
    //     print('Device has no location service');
    //     await Geolocator.requestPermission();
    //   }

    //   LocationPermission permission = await Geolocator.checkPermission();

    //   if (permission == LocationPermission.denied ||
    //       permission == LocationPermission.deniedForever) {
    //     await Geolocator.requestPermission();
    //   }

    //   Position currentPosition = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high,
    //   );

    //// latitude = RxString(position.latitude.toString());
    //// longitude = RxString(position.longitude.toString());

    // latitude.value = currentPosition.latitude.toString();
    // longitude.value = currentPosition.longitude.toString();
    // print(latitude.value);
    // print(longitude.value);

    // if (permission == LocationPermission.deniedForever) {
    //   // Permissions are denied forever, handle appropriately.
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }
  }
}
