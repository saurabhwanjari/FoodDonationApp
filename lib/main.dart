import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/controllers/supplier_controllers/supplier_data_controller.dart';
import 'package:donation_app/demo/test.dart';
import 'package:donation_app/models/ngo_head.dart';
import 'package:donation_app/onboarding/onboarding_screen.dart';
import 'package:donation_app/screens/authentication/ngo_registration_screen.dart';
import 'package:donation_app/screens/authentication/signup_screen.dart';
import 'package:donation_app/screens/authentication/supplier_registration_screen.dart';
import 'package:donation_app/screens/ngo_screens/ngohomepage.dart';
import 'package:donation_app/screens/supplier_screens/supplierhomepage.dart';
import 'package:donation_app/services/firestore_services_ngo.dart';
import 'package:donation_app/services/firestore_services_supplier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:donation_app/constants/app_colors.dart';
import 'package:donation_app/models/supplier.dart';
import 'controllers/ngo_controllers/ngo_data_controller.dart';
import 'donation_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
    ),
  );
  Widget widget = await screenToLoad();

  runApp(DonationApp(widget: widget));
}

Future<Widget> screenToLoad() async {
  Widget widget = const OnBoardingScreen();

  String appStatus = 'loadingFirstTime';

  final GetStorage getStorage = GetStorage();

  final bool? isAppLoadingFirstTime = getStorage.read('isAppLoadingFirstTime');

  if (isAppLoadingFirstTime == false) {
    User? user = FirebaseAuth.instance.currentUser;
   // await user!.reload();

    if (user == null) {
      appStatus = 'notPhoneVerified';
    }
    else {
      await user.reload();

      //
      FirebaseFirestore firebaseFirestoreSupplier =
          FirestoreServicesSupplier.firebaseFirestore;
      DocumentSnapshot documentSnapshotSupplier =
          await firebaseFirestoreSupplier
              .collection(FirestoreServicesSupplier.supplierUsersCollection)
              .doc(user.uid)
              .get();

      if (documentSnapshotSupplier.exists) {
        //
        Supplier supplier =
            Supplier.fromDoucmentSnapshot(documentSnapshotSupplier);

        //
        Get.put(SupplierDataController(supplier: supplier));
      }
      //

      if (documentSnapshotSupplier.exists) {
        appStatus = 'supplierRegistered';
      } //
      if (!documentSnapshotSupplier.exists) {
        appStatus = 'supplierNotRegistered';
      }
      await user.reload();

      //
      FirebaseFirestore firebaseFirestoreNGO =
          FirestoreServicesNGO.firebaseFirestore;
      DocumentSnapshot documentSnapshotNGO = await firebaseFirestoreNGO
          .collection(FirestoreServicesNGO.ngoUsersCollection)
          .doc(user.uid)
          .get();

      if (documentSnapshotNGO.exists) {
        //
        NGOHead ngoHead = NGOHead.fromDoucmentSnapshot(documentSnapshotNGO);

        //
        Get.put(NGODataController(ngoHead: ngoHead));

        if (documentSnapshotNGO.exists) {
          appStatus = 'NGORegistered';
        } //
        if (!documentSnapshotNGO.exists) {
          appStatus = 'NGONotRegistered';
        }
      }
    }
  }

  if (appStatus == 'loadingFirstTime') {
    widget = const OnBoardingScreen();
  }

  if (appStatus == 'notPhoneVerified') {
    widget = SignupScreen();             // ----------------------> Main Page to be placed here
    //widget = SupplierRegistrationScreen();
  }

  if (appStatus == 'supplierRegistered') {
    widget = SupplierHomePage();     
  }

  if (appStatus == 'NGORegistered') {
    widget = NGOHomePage();
  }

  if (appStatus == 'supplierNotRegistered') {
    widget = SupplierRegistrationScreen();
  }

  if (appStatus == 'NGONotRegistered') {
    widget = NGORegistrationScreen();
  }

  return widget;
}


// void main() async {
//   //

//   //
//   await GetStorage.init();
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   //
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       // navigation bar color
//       // systemNavigationBarColor: Colors.blue,

//       // status bar color
//       statusBarColor: AppColors.primary,
//     ),
//   );

//   //
//   Widget widget = await screenToLoad();
//   //
//   runApp(DonationApp(widget: widget));
// }

// Future<Widget> screenToLoad() async {
//   //
//   //
//   // final List<String> roleList = ['Food Supplier', 'NGO Head'];

//   //
//   //String? role;
//   //
//   Widget widget = const OnBoardingScreen();

//   //
//   String appStatus = 'loadingFirstTime';

//   //
//   final GetStorage getStorage = GetStorage();
//   //
//   final bool? isAppLoadingFirstTime = getStorage.read('isAppLoadingFirstTime');

//   //
//   if (isAppLoadingFirstTime == false) {
//     //
//     User? user = FirebaseAuth.instance.currentUser;
//     //
//     if (user == null) {
//       appStatus = 'notPhoneVerified';
//     } //
//     else {
//       //

//       await user.reload();

//       //
//       FirebaseFirestore firebaseFirestoreSupplier =
//           FirestoreServicesSupplier.firebaseFirestore;
//       DocumentSnapshot documentSnapshotSupplier =
//           await firebaseFirestoreSupplier
//               .collection(FirestoreServicesSupplier.supplierUsersCollection)
//               .doc(user.uid)
//               .get();

//       if (documentSnapshotSupplier.exists) {
//         //
//         Supplier supplier =
//             Supplier.fromDoucmentSnapshot(documentSnapshotSupplier);

//         //
//         Get.put(SupplierDataController(supplier: supplier));
//       }

//       //
//       FirebaseFirestore firebaseFirestoreNGO =
//           FirestoreServicesNGO.firebaseFirestore;
//       DocumentSnapshot documentSnapshotNGO = await firebaseFirestoreNGO
//           .collection(FirestoreServicesNGO.ngoUsersCollection)
//           .doc(user.uid)
//           .get();

//       if (documentSnapshotNGO.exists) {
//         //
//         NGOHead ngoHead = NGOHead.fromDoucmentSnapshot(documentSnapshotNGO);

//         //
//         Get.put(NGODataController(ngoHead: ngoHead));
//       }
//       //
//       // if (documentSnapshotSupplier.exists) {
//       //   appStatus = 'supplierRegistered';
//       // } //
//       // else {
//       //   if (!documentSnapshotNGO.exists) {
//       //     appStatus = 'supplierNotRegistered';
//       //   }
//       // }

//       // if (documentSnapshotNGO.exists && !documentSnapshotSupplier.exists) {
//       //   appStatus = 'NGORegistered';
//       // } //
//       // else {
//       //   if (!documentSnapshotNGO.exists) {
//       //     appStatus = 'NGONotRegistered';
//       //   }
//       // }
//       if (documentSnapshotSupplier.exists) {
//         appStatus = 'supplierRegistered';
//       }

//       if (documentSnapshotNGO.exists) {
//         appStatus = 'NGORegistered';
//       }

//       if (!documentSnapshotSupplier.exists) {
//         appStatus = 'supplierNotRegistered';
//       }

//       if (!documentSnapshotNGO.exists) {
//         appStatus = 'NGONotRegistered';
//       }
//     }
//   } //
//   else {
//     appStatus = 'loadingFirstTime';
//   }
 
//   /////
//   if(appStatus=='loadingFirstTime'){
//       widget = const OnBoardingScreen();
//   }

//    if(appStatus=='notPhoneVerified'){
//       widget = SignupScreen();
//   }

//    if(appStatus=='supplierRegistered'){
//       widget = SupplierHomePage();
//   }

//    if(appStatus=='NGORegistered'){
//        widget = NGOHomePage();
//   }

//    if(appStatus=='supplierNotRegistered'){
//      widget =
//          SupplierRegistrationScreen();
//   }

//    if(appStatus=='NGONotRegistered'){
//        widget = NGORegistrationScreen();
//   }

//   // switch (appStatus) {
//   //   //
//   //   case 'loadingFirstTime':
//   //     widget = const OnBoardingScreen();
//   //     break;

//   //   //
//   //   case 'notPhoneVerified':
//   //     widget = SignupScreen();
//   //     break;

//   //   //
//   //   case 'supplierRegistered':
//   //     widget = SupplierHomePage();
//   //     break;

//   //   //
//   //   case 'NGORegistered':
//   //     widget = NGOHomePage();
//   //     break;

//   //   //
//   //   case 'supplierNotRegistered':
//   //     widget =
//   //         SupplierRegistrationScreen(); //------------------------>main page....Problem
//   //     //It opens NGORegistrationScreen
//   //     break;

//   //   //
//   //   case 'NGONotRegistered':
//   //     //widget = NGORegistrationScreen(); //--------------->main page ....works fine if NGO not registered then it opens NGORegistrationScreen
//   //     //widget = SupplierRegistrationScreen();
//   //     widget = NGORegistrationScreen();
//   //     break;
//   // }

//   return widget;
// }