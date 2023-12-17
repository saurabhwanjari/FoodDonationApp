import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/controllers/supplier_controllers/supplier_data_controller.dart';
import 'package:donation_app/models/ngo_head.dart';
import 'package:donation_app/screens/supplier_screens/no_thanks.dart';
import 'package:donation_app/services/add_new_donation_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:donation_app/constants/firebase_constants.dart';
import 'package:donation_app/models/donation.dart';
import 'package:donation_app/services/add_new_donation_services.dart';

import '../../demo/test.dart';
import '../../screens/supplier_screens/donation/google_map_screen.dart';
import '../../services/image_capture_services.dart';
import '../../services/image_upload.dart';

class DonateFoodController extends GetxService {
  //

  var isLoading = false.obs;
  var ampm = ''.obs;
  String hour1 = '';
  String minute1 = '';
  var mealExpiryTime = ''.obs;
  //
  var imageCaptured = false.obs;
  late Rx<File?> image = File('').obs;
  var mealPreparationTime = ''.obs;

  //
  final ImageCaptureServices imageCaptureServices = ImageCaptureServices();
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController donationAddressController =
      TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final GlobalKey<FormState> donateFoodregistrationKey = GlobalKey<FormState>();

  SupplierDataController supplierDataController =
      Get.find<SupplierDataController>();
  //
  ImageSource? imageSource;
  ImageUpload imageUpload = ImageUpload();

  List<String> donationCity = ['Yavatmal'];
  //
  var currentTime = TimeOfDay.now().obs;
  var timeText = 'Select Time'.obs;

  late String dateTime;

  //
  void eraseData() {
    mealNameController.text = '';
    descriptionController.text = '';
    donationAddressController.text = '';
    imageSource = null;
    imageCaptured = false.obs;
    image = File('').obs;
    mealPreparationTime = ''.obs;
    donationCity = ['Yavatmal'];
    mealCategory = ''.obs;
    mealType = ''.obs;
    mealPackages = ''.obs;
    donationReason = ''.obs;
    mealQuantity = 10.0.obs;
    mealExpiry = 0.obs;
    donationCities = ''.obs;
    selectedButtonIndex1 = -1;
    selectedButtonIndex2 = -1;
    selectedButtonIndex3 = -1;
    selectedButtonIndex4 = -1;
    selectedButtonIndex5 = -1;
    latitude = 'Getting Latitude..'.obs;
    longitude = 'Getting Longitude..'.obs;
  }

  //
  var mealCategory = ''.obs;
  var mealType = ''.obs;
  var mealPackages = ''.obs;
  var donationReason = ''.obs;
  var mealQuantity = 10.0.obs;
  var mealExpiry = 0.obs;
  var donationCities = ''.obs;
  var getLocations = ''.obs;

  int selectedButtonIndex1 = -1;
  int selectedButtonIndex2 = -1;
  int selectedButtonIndex3 = -1;
  int selectedButtonIndex4 = -1;
  int selectedButtonIndex5 = -1;

  //
  Future<void> captureOnCick() async {
    try {
      imageSource = await imageCaptureServices.showImageCapturedOptions();

      if (imageSource != null) {
        image.value = await imageUpload.captureImage(imageSource!);

        if (image.value != null && image.value!.path != '') {
          imageCaptured.value = true;
        } else {
          imageCaptured.value = false;
        }
      } else {
        //
      }
    } catch (error) {
      //
    }
  }

  //slider functions
  void onMealQuantityChanged(dynamic newValue) {
    //
    if (newValue <= 10) {
      mealQuantity.value = 10;
    } else {
      mealQuantity.value = newValue!;
    }
    //mealQuantity.value = newValue!;

    //print(mealQuantity.value);
  }

  void onMealExpiryChanged(dynamic newValue) {
    //

    // if (newValue <= 1) {
    //  mealExpiry.value = 1;
    // } else {
    //   mealExpiry.value = newValue!;
    // }
    mealExpiry.value = newValue!.toInt();
    print(mealExpiry.value);
  }

  //group button functions
  void onMealPackagingChanged(int index, bool selected) {
    mealPackages.value = mealPackaging[index];
    selectedButtonIndex4 = mealPackaging.indexOf(mealPackages.value);
    selected = true;
  }

  //
  void onMealTypeChanged(int index, bool selected) {
    mealType.value = mealTypes[index];
    selectedButtonIndex2 = mealTypes.indexOf(mealType.value);
    selected = true;
  }

  //
  void onMealCategoryChanged(int index, bool selected) {
    //
    mealCategory.value = mealCategories[index];
    selectedButtonIndex3 = mealCategories.indexOf(mealCategory.value);
    selected = true;
  }

  //
  void onDonationReasonChanged(int index, bool selected) {
    //
    donationReason.value = donationReasons[index];
    selectedButtonIndex1 = donationReasons.indexOf(donationReason.value);
    selected = true;
  }

  void onGetLocationChanged(int index, bool selected) async {
    getLocations.value = getLocationsList[index];
    await getLocation();
    Get.to(GoogleMapScreen());

    selectedButtonIndex5 = getLocations.indexOf(getLocations.value);
    selected = true;
  }

  //
  void onDonationCityChanged(String? newCatergory) {
    //
    donationCities.value = newCatergory!;
  }

  //Validation

  //validate food name field
  String? validateFoodName(String? name) {
    print('Inside validate');
    if (name == '') {
      return 'Please enter Meal name';
    }

    String pattern = r'[0-9]';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(name!)) {
      return 'Meal name can not have digit';
    }

    return null;
  }

  //Save food name field
  void saveFoodName(String? name) {
    mealNameController.text = name!;
  }

  //validate food description field
  String? validateFoodDescription(String? name) {
    print('Inside validate');
    if (name == '') {
      return 'Please enter food description';
    }

    return null;
  }

  //Save fooddescription field
  void saveFoodDescription(String? name) {
    descriptionController.text = name!;
  }

  //validate donation address field
  String? validateDonationAddress(String? name) {
    print('Inside validate');
    if (name == '') {
      return 'Please enter donation address';
    }

    return null;
  }

  //Save donation address field
  void saveDonationAddress(String? name) {
    donationAddressController.text = name!;
  }

  void deleteCaputedImage() {
    imageCaptured.value = false;

    if (image.value != null) {
      image.value = File('');
    }
  }

  void addNewDonation({required bool isEdit, Donation? oldFoodData}) async {
    try {
      if (mealType == '') {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Donation Failed',
            message: 'Please select meal type',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (mealCategory == '') {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Donation Failed',
            message: 'Please select meal category',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (mealPackages == '') {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Donation Failed',
            message: 'Please select meal packaging type',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (donationReason == '') {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Donation Failed',
            message: 'Please select donation reason',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (mealExpiry == 0) {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Donation Failed',
            message: 'Please select meal expiry time',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (donationCities == '') {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Donation Failed',
            message: 'Please select donation city',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (getLocations == '') {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Donation Failed',
            message: 'Please select donation location',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else if (donateFoodregistrationKey.currentState!.validate() == false) {
        Get.showSnackbar(
          GetSnackBar(
            duration: Duration(seconds: 3),
            title: 'Donation Failed',
            message: 'Please fill all the donation data carefully!!',
            backgroundColor: Get.theme.colorScheme.onSecondary,
          ),
        );
      } else {
        isLoading.value = true;

        String filePath = '';

        if (imageCaptured.value) {
          filePath = await imageUpload.uploadImageToFirebase(
              image.value!, FirebaseConstants.foodPictures);
        } else {
          if (oldFoodData != null) {
            filePath = oldFoodData.foodImage;
          }
        }

        User? user = FirebaseAuth.instance.currentUser;

        user!.reload();

        String supplierId = user.uid;
        String ngoId = '';

        //
        Donation donation = Donation(
          mealNames: mealNameController.text,
          description: descriptionController.text,
          mealType: mealType.value,
          mealCategory: mealCategory.value,
          mealPackaging: mealPackages.value,
          donationCityName: donationCities.value,
          foodImage: filePath,
          donationReason: donationReason.value,
          donationAddress: donationAddressController.text,
          mealQuantity: mealQuantity.value,
          mealExpiryTime: mealExpiry.value.toInt(),
          latitude: latitude.value.toString(),
          longitude: longitude.value.toString(),

          ngoOrganizationName: '',
          ngoDescription: '',
          ngoProfilePicture: '',
          supplierName: supplierDataController.supplier.suppliername,
          supplierProfilrPicture:
              supplierDataController.supplier.profilePicture,
          supplierRole: supplierDataController.supplier.supplierRole,
          supplierMobileNumber: supplierDataController.supplier.mobileNumber,
          supplierRestaurantName:
              supplierDataController.supplier.restaurantName,
          //donationCompleteTime: '',
          //donationCompleteDate: '',
          //mealPreparationTime: mealPreparationTime.value,
          supplierId: supplierId,
          ngoId: ngoId,
        );

        //
        if (oldFoodData != null) {
          donation.documentId = oldFoodData.documentId;
          donation.donationDate = oldFoodData.donationDate;
          donation.donationTime = oldFoodData.donationTime;
        }

        //
        AddNewDonationServices addNewMenuServices = AddNewDonationServices();
        //
        if (isEdit) {
          await addNewMenuServices.updateDonationToFirestore(donation);
        } else {
          await addNewMenuServices.addMenuToFirestore(donation);
        }

        Get.back();

        isLoading.value = false;
      }
    } catch (error) {
      Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 3),
          title: 'Donation Failed',
          message: 'Please fill all the details carefully!!',
          backgroundColor: Get.theme.colorScheme.onSecondary,
        ),
      );
    }
    //
    //bool isValidate = donateFoodregistrationKey.currentState!.validate();

    print('isEdit $isEdit');

    // if (isValidate) {
    // } else {
    //   Get.showSnackbar(
    //     GetSnackBar(
    //       duration: Duration(seconds: 3),
    //       title: 'Donation Failed',
    //       message: 'Please fill all the details',
    //       backgroundColor: Get.theme.colorScheme.onSecondary,
    //     ),
    //   );
    // }
  }

  void initFoodData(Donation donation) {
    mealNameController.text = donation.mealNames;
    descriptionController.text = donation.description;
    donationAddressController.text = donation.donationAddress;
    donationCities.value = donation.donationCityName;
    latitude.value = donation.latitude;
    longitude.value = donation.longitude;
    //donationReason.value = donation.donationReason;
    //mealPackages.value = donation.mealPackaging;
    mealQuantity.value = donation.mealQuantity;
    mealExpiry.value = donation.mealExpiryTime;

    //
    // selectedButtonIndex1= donationReason.indexOf(donation.donationReason);
    selectedButtonIndex1 = donationReasons.indexOf(donation.donationReason);

    donationReason.value = donation.donationReason;

    selectedButtonIndex2 = mealTypes.indexOf(donation.mealType);
    mealType.value = donation.mealType;

    selectedButtonIndex3 = mealCategories.indexOf(donation.mealCategory);
    mealCategory.value = donation.mealCategory;

    selectedButtonIndex4 = mealPackaging.indexOf(donation.mealPackaging);
    mealPackages.value = donation.mealPackaging;

    selectedButtonIndex5 = getLocations.indexOf(donation.latitude);
    getLocations.value = donation.latitude;

    print('selectedButtonIndex1=$selectedButtonIndex1');
  }

  void deleteDonation(Donation donation) async {
    AddNewDonationServices addNewDonationServices = AddNewDonationServices();

    addNewDonationServices.deleteDonationFromFirestore(donation);
    Get.back();
  }

  //Getting current location logic
  var latitude = 'Getting Latitude..'.obs;
  var longitude = 'Getting Longitude..'.obs;
  late var position = ''.obs;

  Future<void> getLocation() async {
    //check location service is eanbled
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      print('Device has no location service');
      await Geolocator.requestPermission();
    }
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      bool finalServiceStatus = await Geolocator.isLocationServiceEnabled();

      print('finalServiceStatus = ${finalServiceStatus}');

      if (!finalServiceStatus) {
        Get.to(() => NoThanks());
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        LocationPermission finalPermission =
            await Geolocator.requestPermission();
      }

      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // latitude = RxString(position.latitude.toString());
      // longitude = RxString(position.longitude.toString());

      latitude.value = currentPosition.latitude.toString();
      longitude.value = currentPosition.longitude.toString();
      print(latitude.value);
      print(longitude.value);

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    } catch (error) {
      print(error);
    }
  }

  // void showMealExpiryTimer(BuildContext context, String time) async {
  //   try {
  //     mealExpiryTime.value = time;
  //     //
  //     TimeOfDay? t = await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay.now(),
  //     );
  //     if (t != null) {
  //       int h = t.hour;
  //       int m = t.minute;

  //       h >= 12 ? ampm.value = 'PM' : ampm.value = 'AM';

  //       if (h < 10) {
  //         hour1 = '0$h';
  //       } else {
  //         hour1 = '$h';
  //       }

  //       if (m < 10) {
  //         minute1 = '0$m';
  //       } else {
  //         minute1 = '$m';
  //       }

  //       if (h == 0 && m == 0) {
  //         hour1 = '12';
  //         minute1 = '00';
  //       }

  //       if (h > 12) {
  //         h = h - 12;
  //         if (h < 10) {
  //           hour1 = '0$h';
  //         }
  //       }

  //       mealExpiryTime.value = '$hour1 : $minute1 $ampm';
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  Future<void> selectTime(BuildContext context) async {
    try {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(selectedTime!,
          alwaysUse24HourFormat: false);

      if (formattedTime != null) {
        timeText.value = formattedTime;
        timeController.text = timeText.value;
      }
      dateTime = selectedTime.toString().substring(10, 15);
    } catch (error) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 3),
          title: 'Meal Expiry Time',
          message: 'Please select meal expiry time',
        ),
      );
    }
  }
}
