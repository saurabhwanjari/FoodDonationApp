import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/controllers/supplier_controllers/supplier_data_controller.dart';
import 'package:donation_app/models/ngo_head.dart';
import 'package:donation_app/services/edit_ngo.dart';
import 'package:donation_app/services/edit_supplier.dart';
import 'package:donation_app/services/firestore_services_ngo.dart';
import 'package:donation_app/services/firestore_services_supplier.dart';
import 'package:donation_app/services/image_upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/firebase_constants.dart';
import '../../models/supplier.dart';
import '../../services/image_capture_services.dart';

class EditSupplierController extends GetxController {
  //
  TextEditingController supplierNameController = TextEditingController();
  TextEditingController supplierAddressController = TextEditingController();
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController restaurantAddressController = TextEditingController();
  TextEditingController supplierDescriptionController = TextEditingController();
  final GlobalKey<FormState> registrationKey = GlobalKey<FormState>();
  SupplierDataController supplierDataController =
      Get.find<SupplierDataController>();

  var imageCaptured = false.obs;
  late Rx<File?> image =
      File(supplierDataController.rxSupplier.value.profilePicture).obs;
  var isLoading = false.obs;
  String? downloadURL;

  ImageSource? imageSource;
  ImageUpload imageUpload = ImageUpload();

  //
  void initializeData() {
    image.value =
        File('${supplierDataController.rxSupplier.value.profilePicture}');
    downloadURL = supplierDataController.rxSupplier.value.profilePicture;
    supplierNameController.text =
        supplierDataController.rxSupplier.value.suppliername;
    supplierAddressController.text =
        supplierDataController.rxSupplier.value.address;
    restaurantNameController.text =
        supplierDataController.rxSupplier.value.restaurantName;
    restaurantAddressController.text =
        supplierDataController.rxSupplier.value.restaurantAddress;
    supplierDescriptionController.text =
        supplierDataController.rxSupplier.value.description;
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
  String? validateSupplierName(String? name) {
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
    supplierNameController.text = name!;
  }

  // validate restaurant name field
  String? validateRestaurantName(String? name) {
    print('inside validate');
    if (name == '') {
      return 'Please enter your restaurant name';
    }

    return null;
  }
  // save restaurant name field

  void saverestaurantName(String? name) {
    restaurantNameController.text = name!;
  }

  // validate supplier address field
  String? validateSupplierAddress(String? name) {
    if (name == '') {
      return 'Please enter your address';
    }

    return null;
  }
  // save supplier address field

  void saveAddress(String? name) {
    supplierAddressController.text = name!;
  }

  // validate restaurant address field
  String? validateRestaurantAddress(String? name) {
    if (name == '') {
      return 'Please enter your restaurant address';
    }

    return null;
  }
  // save restaurant supplier address field

  void saveRestaurantAddress(String? name) {
    restaurantAddressController.text = name!;
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
    supplierDescriptionController.text = des!;
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

      Supplier supplier = Supplier(
        suppliername: supplierNameController.text,
        address: supplierAddressController.text,
        cityName: supplierDataController.supplier.cityName,
        restaurantName: restaurantNameController.text,
        restaurantAddress: restaurantAddressController.text,
        restaurantCity: supplierDataController.supplier.restaurantCity,
        supplierRole: supplierDataController.supplier.supplierRole,
        gender: supplierDataController.supplier.gender,
        mealType: supplierDataController.supplier.mealType,
        deliverFoodToNgo: supplierDataController.supplier.deliverFoodToNgo,
        profilePicture: downloadURL ?? FirebaseConstants.defaultProfilePicture,
        description: supplierDataController.supplier.description,
        liscenseNumber: supplierDataController.supplier.liscenseNumber,
        mobileNumber: user.phoneNumber!,
      );

      //
      EditSupplier editSupplier = EditSupplier();

      bool isRegistered = await editSupplier.editSupplier(supplier);

      //
      if (isRegistered) {
        await user.reload();

        //getting firebase instance to check if user is registered or not
        FirebaseFirestore firebaseFirestore =
            FirestoreServicesSupplier.firebaseFirestore;
        DocumentSnapshot documentSnapshot = await firebaseFirestore
            .collection(FirestoreServicesSupplier.supplierUsersCollection)
            .doc(user.uid)
            .get();

        print(
            'collection name : ${FirestoreServicesSupplier.supplierUsersCollection}');

        await user.reload();

        Supplier supplier = Supplier.fromDoucmentSnapshot(documentSnapshot);

        //Put or save this ngoHead inside the ngoDataController
        SupplierDataController supplierDataController =
            Get.find<SupplierDataController>();
        supplierDataController.rxSupplier.value = supplier;
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
