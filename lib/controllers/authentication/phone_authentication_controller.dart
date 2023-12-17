import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donation_app/controllers/authentication/otp_controller.dart';
import '../../screens/authentication/otp_verification_screen.dart';

class PhoneAuthenticationController extends GetxController {
  //
  TextEditingController otpTextFieldController = TextEditingController();
  //
  var showOTPButton = false.obs;
  //late String phoneNumber;

  //
  final List<String> roleList = ['Food Supplier', 'NGO Head'];

  //
  String? role;

  //
  void onRoleSelected(int index, bool isSelected) {
    role = roleList[index];
    showHideOTPButton(otpTextFieldController.text);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    otpTextFieldController.dispose();
    print('inside dispose() of PhoneAuthController');
  }

  //
  void showHideOTPButton(String newValue) {
    //
    String pattern = '^[0-9]{10}';
    RegExp regExp = RegExp(pattern);
    //
    if (
        role != null && regExp.hasMatch(newValue)) {
      showOTPButton.value = true;
    } else {
      showOTPButton.value = false;
    }
  }

  void navigateToOTPVerification() {
    // must add to delete the controller
    Get.delete<OTPController>();

    Get.put(
      OTPController(phoneNumber: otpTextFieldController.text),
    );
    

    // //
    Get.off(() => OTPVerificationScreen());
  }
}
