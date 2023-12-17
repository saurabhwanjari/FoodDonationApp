import 'package:donation_app/widgets/app_group_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:donation_app/widgets/need_help_button.dart';
import 'package:donation_app/widgets/phone_no_input_textfield.dart';
import '../../controllers/authentication/phone_authentication_controller.dart';
import '../common_screens/auth_need_help.dart';

class SignupScreen extends StatelessWidget {
  //
  SignupScreen({Key? key}) : super(key: key);

  //
  final PhoneAuthenticationController phoneAuthController =
      Get.put<PhoneAuthenticationController>(PhoneAuthenticationController(),
          permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        //
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              Image.asset(
                'images/otp.jpg',
                // height: 200,
                // width: 200,
              ),

              //
              const SizedBox(height: 32),

              // Text
              AppText(
                'Phone Verification',
                textType: TextType.extraLarge,
                textColor: Get.theme.colorScheme.primary,
                isBold: true,
              ),
              //
              const SizedBox(height: 16),
              //
              const AppText(
                'Please enter your mobile number to receive OTP',
                size: 15,
                isBold: true,
                textAlign: TextAlign.center,
              ),

              //
              const SizedBox(height: 16),

              //Register as text with supplier or NGO Head
              const Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  '                                         Register As',
                  textType: TextType.small,
                  //textAlign: TextAlign.center,
                ),
              ),

              //
              const SizedBox(height: 12),

              //
              Align(
                alignment: Alignment.center,
                child: AppGroupButtons(
                  items: phoneAuthController.roleList,
                  fontSize: 15,
                  selectedButtonIndex: -1,
                  onSelected: phoneAuthController.onRoleSelected,
                ),
              ),

              //
              const SizedBox(height: 32),

              //

              PhoneNoInputTextfield(
                hintText: 'Phone Number',
                onChange: phoneAuthController.showHideOTPButton,
                textEditingController:
                    phoneAuthController.otpTextFieldController,
              ),

              //
              const SizedBox(height: 32),

              //
              Obx(
                () => AppButton(
                  text: 'Generate OTP',
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  buttonType: AppButtonType.largerButton,
                  isDisabled: !phoneAuthController.showOTPButton.value,
                  onPressed: phoneAuthController.navigateToOTPVerification,
                ),
              ),

              //
            ],
          ),
        ),
      ),

      //
      bottomNavigationBar: AppTextButton(
        text: 'Need Help?',
        color: Get.theme.colorScheme.primary,
        // size: 14,
        onPressed: () {
          Get.to(AuthNeedHelp());
        },
      ),
    );
  }
}
