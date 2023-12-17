import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/controllers/authentication/supplier_location_controller.dart';
import 'package:donation_app/controllers/supplier_controllers/supplier_data_controller.dart';
import 'package:donation_app/demo/test.dart';
import 'package:donation_app/screens/supplier_screens/supplierhomepage.dart';
import 'package:donation_app/services/get_location_services.dart';
import 'package:donation_app/services/register_supplier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donation_app/services/image_upload.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../constants/firebase_constants.dart';
import '../../models/supplier.dart';
import '../../services/firestore_services_supplier.dart';
import '../../services/image_capture_services.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class SupplierRegistrationController extends GetxController {
  //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController restaurantNameController =
      TextEditingController();
  final TextEditingController restaurantAddressController =
      TextEditingController();
  final TextEditingController liscenseController = TextEditingController();
  final ImageCaptureServices imageCaptureServices = ImageCaptureServices();
  final GetLocationServices getLocationServices = GetLocationServices();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> registrationKey = GlobalKey<FormState>();

  //
  var isLoading = false.obs;
  int selectedIndexForMealType = -1;
  int selectedIndexForGenderList = -1;
  int selectedIndexForSupplierRoleList = -1;

  //
  //var showRegisterButton = false.obs;

  //
  String? downloadURL;

  //
  var selectedIndex = 0.obs;

  //
  final List<String> mealTypeList = [
    'Veg Only',
    'Veg & Non-Veg',
  ];

  final List<String> genderList = ['Male', 'Female'];

  final List<String> deliverFoodToNgoList = ['Yes', 'No'];

  final List<String> supplierRoleList = ['Individual', 'Restaurant Owner'];

  final List<String> city = ['Yavatmal'];

  //
  var mealType = ''.obs;
  var gender = ''.obs;
  var deliverFoodToNgo = ''.obs;
  var supplierRole = ''.obs;
  var cities = ''.obs;

  //
  var imageCaptured = false.obs;
  late Rx<File?> image = File('').obs;

  //int selectedButtonIndex = -1;

  ImageSource? imageSource;
  ImageUpload imageUpload = ImageUpload();
  //
  void onGenderSelected(int index, bool isSelected) {
    gender.value = genderList[index];
    selectedIndexForGenderList = genderList.indexOf(gender.value);
    isSelected = true;
  }

  //
  void onMealTypeSelected(int index, bool isSelected) {
    mealType.value = mealTypeList[index];
    selectedIndexForMealType = mealTypeList.indexOf(mealType.value);
    isSelected = true;
  }

  //
  void onDeliverFoodToNgoSelected(int index, bool isSelected) {
    deliverFoodToNgo.value = deliverFoodToNgoList[index];
    selectedIndexForSupplierRoleList =
        deliverFoodToNgoList.indexOf(deliverFoodToNgo.value);
    isSelected = true;
  }

  //
  void onSupplierRoleSelected(int index, bool isSelected) {
    supplierRole.value = supplierRoleList[index];
    selectedIndexForSupplierRoleList = supplierRoleList.indexOf(supplierRole.value);
    isSelected = true;
    selectedIndex.value = index;
  }

  //
  void onCityChanged(String? newCatergory) {
    //
    cities.value = newCatergory!;
  }

  //Validation Logic

  //validate name field
  String? validateName(String? name) {
    print('Inside validate');
    if (name == '') {
      return 'Please Enter Your Name';
    }

    String pattern = r'[0-9]';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(name!)) {
      return 'Name should not have any digit';
    }

    return null;
  }

  //save name field
  void saveName(String? name) {
    nameController.text = name!;
  }

  //validate address field
  String? validateAddress(String? address) {
    print('Inside validate');
    if (address == '') {
      return 'Please Enter Your Address';
    }

    return null;
  }

  //save address field
  void saveAddress(String? address) {
    addressController.text = address!;
  }

  //validate Restaurant Name field
  String? validateRestaurantName(String? rname) {
    print('Inside validate');
    if (rname == '') {
      return 'Please Enter Your Restaurant Name';
    }

    return null;
  }

  //save Restaurant Name field
  void saveRestaurantName(String? rname) {
    restaurantNameController.text = rname!;
  }

  //validate Restaurant address field
  String? validateRestaurantAddress(String? raddress) {
    print('Inside validate');
    if (raddress == '') {
      return 'Please Enter Your Restaurant Name';
    }

    return null;
  }

  //save Restaurant address field
  void saveRestaurantAddress(String? raddress) {
    restaurantAddressController.text = raddress!;
  }

  //validate Description field
  String? validateDescription(String? des) {
    print('Inside validate');
    if (des == '') {
      return 'Please Enter Your Restaurant Address';
    }

    return null;
  }

  //save Description field
  void saveDescription(String? des) {
    descriptionController.text = des!;
  }

  //validate Restaurant's Liscense Number field
  String? validateLiscense(String? lis) {
    print('Inside validate');
    if (lis == '') {
      return 'Please Enter Your Restaurant\'s Liscense Number';
    }

    var patt = RegExp(r'^[0-9]{14}$');

    if (patt.hasMatch(lis!)) {
      return null;
    } else {
      return 'Please enter proper Liscense Number';
    }
  }

  //save Restaurant's Liscense Number field
  void saveLiscense(String? lis) {
    liscenseController.text = lis!;
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
            message: 'Please Select your City',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (supplierRole == '') {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Registration Failed',
            message: 'Please Select your Role',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (mealType == '') {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Registration Failed',
            message: 'Please Select Meal Type',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (registrationKey.currentState!.validate() == false) {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Registration Failed',
            message: 'Please Select All The Fields Carefully!!',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else {
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
            image.value!,
            FirebaseConstants.profilePictures,
          );
        }

        //
        Supplier supplier = Supplier(
          suppliername: nameController.text,
          address: addressController.text,
          cityName: cityNameController.text,
          restaurantName: restaurantNameController.text,
          restaurantAddress: restaurantAddressController.text,
          restaurantCity: cities.value,
          supplierRole: supplierRole.value,
          gender: gender.value,
          mealType: mealType.value,
          deliverFoodToNgo: deliverFoodToNgo.value,
          profilePicture:
              downloadURL ?? FirebaseConstants.defaultProfilePicture,
          //latitude: latitude.value.toString(),
          //longitude: longitude.value.toString(),
          description: descriptionController.text,
          liscenseNumber: liscenseController.text,
          mobileNumber: user.phoneNumber!,
        );

        //
        RegisterSupplier registerSupplier = RegisterSupplier();

        //
        bool isRegistered = await registerSupplier.registerSupplier(supplier);

        //
        if (isRegistered) {
          //
          await user.reload();

          //getting firebase instance to check if user is registered or not
          FirebaseFirestore firebaseFirestoreSupplier =
              FirestoreServicesSupplier.firebaseFirestore;
          DocumentSnapshot documentSnapshotSupplier =
              await firebaseFirestoreSupplier
                  .collection(FirestoreServicesSupplier.supplierUsersCollection)
                  .doc(user.uid)
                  .get();

          //
          Supplier supplier =
              Supplier.fromDoucmentSnapshot(documentSnapshotSupplier);

          // Put or save this supplier inside the UserDataController
          // to use it as globle object in entire app
          Get.put(SupplierDataController(supplier: supplier));

          //
          Get.off(() => SupplierHomePage());
        } else {
          //..
        }

        print('name=${supplier.suppliername}');
        print('address=${supplier.address}');
        print('cityName =${supplier.cityName}');
        print('restaurantName=${supplier.restaurantName}');
        print('restaurantAddress=${supplier.restaurantAddress}');
        print('restaurantCity=${supplier.restaurantCity}');
        print('supplierRole=${supplier.supplierRole}');
        print('gender=${supplier.gender}');
        print('mealType=${supplier.mealType}');
        print('deliverFoodToNgo=${supplier.deliverFoodToNgo}');
        print('profilePicture=${supplier.profilePicture}');
        //print('Latitude=${supplier.latitude}');
        //print('Longitude=${supplier.longitude}');
        print('Description=${supplier.description}');
        print('liscenseNumber=${supplier.liscenseNumber}');

        //
        isLoading.value = false;
      }
    } catch (error) {
      print('error= ${error}');
      
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 3),
          title: 'Registration Failed',
          message: 'Plesae fill all the details carefully!!',
          backgroundColor: Get.theme.colorScheme.onSecondary,
        ),
      );
    }
    //bool isValidate = registrationKey.currentState!.validate();

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

    //...........................................

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

    //   // latitude = RxString(position.latitude.toString());
    //   // longitude = RxString(position.longitude.toString());

    //   latitude.value = currentPosition.latitude.toString();
    //   longitude.value = currentPosition.longitude.toString();
    //   print(latitude.value);
    //   print(longitude.value);

    //   if (permission == LocationPermission.deniedForever) {
    //     // Permissions are denied forever, handle appropriately.
    //     return Future.error(
    //         'Location permissions are permanently denied, we cannot request permissions.');
    //   }
    //}
  }
}
