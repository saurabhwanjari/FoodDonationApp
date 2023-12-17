import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donation_app/constants/app_colors.dart';

import 'app_text.dart';

enum AppButtonType {
  largerButton,
  smallButton,
  outlinedButton,
}

class AppButton extends StatelessWidget {
  //
  final String text;
  final Function()? onPressed;
  final AppButtonType buttonType;
  final bool isDisabled;
  final TextStyle textStyle;

  //
  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.textStyle,
    this.buttonType = AppButtonType.largerButton,
    this.isDisabled = false,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return MaterialButton(
      color: isDisabled
          ? AppColors.disabledButtonColor
          : Get.theme.colorScheme.primary,

      minWidth: Get.width,
      height: 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //
      child: AppText(
        text,
        isBold: true,
        textType: TextType.large,

        //
        textColor: isDisabled
            ? AppColors.disabledButtonTextColor
            : Get.theme.colorScheme.onPrimary,
      ),
      //
      onPressed: isDisabled
          ? () {
              //
            }
          : onPressed,
    );
  }
}