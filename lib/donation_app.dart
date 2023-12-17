import 'package:donation_app/screens/authentication/ngo_registration_screen.dart';
import 'package:donation_app/screens/authentication/signup_screen.dart';
import 'package:donation_app/screens/authentication/supplier_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donation_app/onboarding/onboarding_screen.dart';
import 'package:donation_app/theme/app_theme.dart';
import 'package:get_storage/get_storage.dart';

import 'screens/authentication/otp_verification_screen.dart';

class DonationApp extends StatelessWidget {
  //
  final Widget widget;
  //
  const DonationApp({
    required this.widget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    // final GetStorage getStorage = GetStorage();

    // final bool? isAppLoadingFirstTime =
    //     getStorage.read('isAppLoadingFirstTime');

    //
    return GetMaterialApp(
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      // home: (isAppLoadingFirstTime == null || isAppLoadingFirstTime == true)
      //     ? const OnBoardingScreen()
      //     : const TestPage(),

      //home: const OnBoardingScreen(),
      home: widget,
    );
  }
}
