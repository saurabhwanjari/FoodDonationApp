import 'package:donation_app/demo/test.dart';
import 'package:donation_app/screens/authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:donation_app/constants/app_colors.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:get_storage/get_storage.dart';

//
class OnBoardingScreen extends StatelessWidget {
  //
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    //
    final GetStorage getStorage = GetStorage();
    getStorage.write('isAppLoadingFirstTime', false);

    //
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 100, bottom: 30),
      color: Get.theme.colorScheme.background,
      child: IntroductionScreen(
        pages: [
          //
          constructPage(
            title: 'Feed Your City In Minutes',
            descreption:
                'Share your remaining food to the needy ones with just one click and eliminate hunger in our society.',
            image: 'images/donate.jpg',
          ),
          //
          constructPage(
            title: 'Share Food Share Love',
            descreption:
                'Sharing food with another human being and curing their hunger is a nobel act',
            image: 'images/image8.jpg',
          ),

          //
          constructPage(
            title: 'Lend A Hand, Give A Can',
            descreption:
                'You have two hands one to help yourself and second to help the needy ones.',
            image: 'images/i8.jpg',
          ),

          //
        
          // constructPage(
          //   title: 'On Boarding Title4',
          //   descreption:
          //       'Some text that describe the on boarding in meaning full and constructive way so that user can understand it.',
          //   image: 'images/image17.jpg',
          // ),
          
        ],
        onDone: navigateToAuthentication,
        //
        done: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppText(
              'Finish',
              isBold: true,
              size: 18,
              textColor: Get.theme.colorScheme.primary,
            ),
          ],
        ),
        //
        showSkipButton: true,
        //
        skip: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            AppText('Skip'),
          ],
        ),
        //
        onSkip: navigateToAuthentication,
        next: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //
            const AppText('Next '),

            //
            Icon(
              Icons.arrow_forward,
              color: Get.theme.colorScheme.primary,
              size: 22,
            ),
          ],
        ),
        globalBackgroundColor: Get.theme.colorScheme.background,
        dotsDecorator: DotsDecorator(
          color: AppColors.greyColor,
          activeColor: Get.theme.colorScheme.primary,
        ),
      ),
    );
  }

  void navigateToAuthentication() {
    //
    Get.off(SignupScreen());
  }
}

PageViewModel constructPage({
  required String title,
  required String descreption,
  required String image,
}) {
  //
  return PageViewModel(
    //
    titleWidget: AppText(
      title,
      textType: TextType.extraLarge,
      isBold: true,
    ),

    //
    bodyWidget: AppText(
      descreption,
      textAlign: TextAlign.center,
    ),

    //
    image: Image.asset(image),
  );
}
