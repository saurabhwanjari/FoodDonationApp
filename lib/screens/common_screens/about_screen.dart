import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Get.theme.colorScheme.primary,
            size: 34,
          ),
          title: AppText(
            'About',
            textType: TextType.large,
            isBold: true,
            textColor: Get.theme.colorScheme.primary,
          ),
          elevation: 0,
          backgroundColor: Get.theme.colorScheme.background,
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 48),
              AppText(
                'Akshaya Patra',
                size: 32,
                textColor: Get.theme.colorScheme.primary,
                isBold: true,
              ),
              SizedBox(height: 16),
              AppText(
                'Food Never Ends',
                size: 18,
                isBold: true,
              ),
              SizedBox(height: 150),
              Image.asset('images/food.jpg'),
              // SizedBox(height: 16),
              // AppText(
              //   'Version : 1.0',
              //   isBold: true,
              // ),
            ],
          ),
        ));
  }
}
