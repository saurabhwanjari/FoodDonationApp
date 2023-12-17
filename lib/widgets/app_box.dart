import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBox extends StatelessWidget {
  final String text;
  final Widget icon;
  const AppBox({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 100,
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     width: 1.5,
      //     color: Get.theme.colorScheme.primary,
      //   ),
      color: Get.theme.colorScheme.onPrimary,
      //   borderRadius: BorderRadius.all(Radius.circular(14)),
      // ),
      child: Column(children: [
        SizedBox(height: 10),
        Container(
          child: icon,
        ),
        SizedBox(height: 8),
        Expanded(
          child: AppText(
            text,
            textAlign: TextAlign.center,
            size: 14,
            isBold: true,
          ),
        ),
      ]),
    );
  }
}
