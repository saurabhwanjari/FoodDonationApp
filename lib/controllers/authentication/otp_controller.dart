import 'dart:async';
import 'package:donation_app/controllers/authentication/phone_authentication_controller.dart';
import 'package:donation_app/screens/authentication/supplier_registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/authentication/ngo_registration_screen.dart';

class OTPController extends GetxController {
  //
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? verificationId;
  String phoneNumber;
  var timeOut = false.obs;
  var veficationFailed = false.obs;
  final TextEditingController otpTextController = TextEditingController();
  var remainingTime = 120.obs;

  //
  OTPController({required this.phoneNumber});

  //
  PhoneAuthenticationController phoneController =
      Get.find<PhoneAuthenticationController>();
  //PhoneAuthenticationController();

  //
  @override
  void onInit() {
    super.onInit();

    //
    try {
      automaticVerification();
    } catch (error) {
      //
      Get.showSnackbar(
        GetSnackBar(
          title: 'Phone Verification Failed',
          message: error.toString(),
        ),
      );
    }
  }

  //
  @override
  void onClose() {
    super.onClose();
  }

  //
  void timeOutTimer() {
    remainingTime.value = 120;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      //
      remainingTime.value = remainingTime.value - 1;

      if (remainingTime.value == 0) {
        timeOut.value = true;
        timer.cancel();
      }
    });
  }

  //
  void onOTPValueChanged(String opt) {
    //
    if (opt.isEmpty) {
      veficationFailed.value = true;
    } else if (opt.length == 6) {
      veficationFailed.value = false;
    }
  }

  //
  void automaticVerification() async {
    //
    timeOut.value = false;

    timeOutTimer();

    //
    firebaseAuth.verifyPhoneNumber(
      //
      phoneNumber: '+91$phoneNumber',
      //
      timeout: const Duration(seconds: 120),

      //
      verificationCompleted: onVerificationCompleted,
      //
      verificationFailed: onVerificationFailed,
      //
      codeSent: onCodeSend,

      //
      codeAutoRetrievalTimeout: onAutoRetrievalTimeout,
    );
  }

  //
  void onVerificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    //
    otpTextController.text = phoneAuthCredential.smsCode!;

    //
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(phoneAuthCredential);

    User? user = userCredential.user;

    //....
    if (user != null) {
      //
      print('Verification done automatically');

      if (phoneController.role == 'Food Supplier') {
        //Goes to the registration page of food supplier
        Get.off(SupplierRegistrationScreen());
        //Get.off(TestPage());
      } else if (phoneController.role == 'NGO Head') {
        //Goes to the registration page of NGO
        Get.off(NGORegistrationScreen());
        //Get.off(TestPage());
      } else {
        print('Error');
      }
      //Get.off(SupplierRegistrationScreen());
    } else {
      //
      veficationFailed.value = true;
    }
  }

  //
  void onVerificationFailed(FirebaseAuthException firebaseAuthException) async {
    //
    veficationFailed.value = true;
  }

  //
  void onCodeSend(String verificationId, int? auto) {
    this.verificationId = verificationId;
  }

  //
  void onAutoRetrievalTimeout(String verificationId) {
    timeOut.value = true;
  }

  //
  void manualVerification() async {
    try {
      //
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: otpTextController.text);

      //
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
      //
      User? user = userCredential.user;

      if (user != null) {
        // s
        // move on
        print('verification done maually');
        //
        if (phoneController.role == 'Food Supplier') {
          //Goes to the registration page of food supplier
          Get.off(SupplierRegistrationScreen());
          //Get.off(TestPage());
        } else {
          //Goes to the registration page of NGO
          Get.off(NGORegistrationScreen());
          //Get.off(TestPage());
        }
      } else {
        //
        veficationFailed.value = true;
        Get.showSnackbar(const GetSnackBar(
          title: 'Verification Failed',
          message: 'Please enter correct OTP',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        ));
      }
    } catch (error) {
      veficationFailed.value = true;
    }
  }
}
