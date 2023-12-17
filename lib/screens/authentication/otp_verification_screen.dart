import 'package:donation_app/screens/authentication/signup_screen.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donation_app/controllers/authentication/otp_controller.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:donation_app/widgets/need_help_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../common_screens/auth_need_help.dart';

class OTPVerificationScreen extends StatelessWidget {
  //
  OTPVerificationScreen({Key? key}) : super(key: key);

  final OTPController otpController = Get.find<OTPController>();
  //final OTPController otpController = Get.put(OTPController(phoneNumber: ''));

  //
  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      body: Container(
        //
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,

        //
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              const SizedBox(height: 32),
              //
              Image.asset('images/otp.jpg'),

              const SizedBox(height: 32),

              const AppText(
                'Phone Verification',
                textColor: Colors.orangeAccent,
                isBold: true,
                textType: TextType.extraLarge,
              ),

              const SizedBox(height: 8),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  const AppText(
                    'OTP sent to ',
                    isBold: true,
                    size: 15,
                  ),

                  AppText(
                    otpController.phoneNumber,
                    isBold: true,
                  ),

                  const AppText(
                    '. Please Verify',
                    isBold: true,
                    size: 15,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              //
              Column(
                children: [
                  //
                  Obx(
                    () => PinCodeTextField(
                      length: 6,
                      controller: otpController.otpTextController,
                      appContext: context,
                      keyboardType: TextInputType.number,
                      textStyle: TextStyle(
                        fontSize: 24,
                        color: otpController.veficationFailed.value
                            ? Get.theme.colorScheme.error
                            : Get.theme.colorScheme.onBackground,
                      ),
                      //
                      pinTheme: otpController.veficationFailed.value
                          ?
                          // show OTP box in red/error color indicate verification falied
                          PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Get.theme.colorScheme.onPrimary,
                              activeColor: Get.theme.colorScheme.error,
                              selectedColor: Get.theme.colorScheme.error,
                              inactiveColor: Get.theme.colorScheme.error,
                            )
                          // show OTP box in normal colo, indicating verification is in progress
                          : PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Get.theme.colorScheme.onPrimary,
                              activeColor: Get.theme.colorScheme.primary,
                              selectedColor: Get.theme.colorScheme.primary,
                              inactiveColor: Get.theme.colorScheme.primary,
                            ),
                      //
                      cursorColor: Get.theme.colorScheme.primary,
                      //
                      onChanged: otpController.onOTPValueChanged,
                      //
                      onCompleted: (String s) {},
                    ),
                  ),

                  //  const SizedBox(height: 8),

                  Obx(
                    () {
                      //
                      int mins = otpController.remainingTime.value ~/ 60;
                      int secs = otpController.remainingTime.value % 60;

                      String minutes = '0$mins';
                      String seconds = secs >= 10 ? secs.toString() : '0$secs';

                      //

                      return Container(
                        //color: Colors.red,
                        height: 32,
                        child: otpController.timeOut.value
                            ? Align(
                                alignment: Alignment.center,
                                child: AppTextButton(
                                  text: 'Resend OTP Verification Code',
                                  color: Get.theme.colorScheme.primary,
                                  onPressed:
                                      otpController.automaticVerification,
                                ),
                              )
                            : Row(
                                children: [
                                  //
                                  const AppText('Time Remaining : '),
                                  //
                                  AppText(
                                    '$minutes:$seconds',
                                    isBold: true,
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
                ],
              ),

              //
              const SizedBox(height: 16),

              //

              AppButton(
                text: 'Verify & Proceed',
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                onPressed: otpController.manualVerification,
              ),
              //
              SizedBox(height: 8),

              AppTextButton(
                text: 'Change Number',
                color: Get.theme.colorScheme.primary,
                onPressed: () {
                  //
                  // Get.delete<OTPController>();
                  // Get.delete<PhoneAuthController>();

                  //
                  Get.offAll(() => SignupScreen());
                },
              ),
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
