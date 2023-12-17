// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:donation_app/theme/app_theme.dart';

// enum TextType {
//   small,
//   normal,
//   large,
//   extraLarge,
// }

// class AppText extends StatelessWidget {
//   //
//   final String data;
//   final double? size;
//   final bool isBold;
//   final bool isLightShade;
//   final TextType textType;
//   final String? fontFamily;
//   final TextAlign textAlign;
//   final Color? textColor;

//   //
//   const AppText(
//     this.data, bool isBold, {
//     Key? key,
//     this.size,
//     this.isBold = false,
//     this.isLightShade = false,
//     this.textType = TextType.normal,
//     this.fontFamily,
//     this.textAlign = TextAlign.left,
//     this.textColor,
//   }) : super(key: key);

//   //
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       //
//       data,
//       //
//       textAlign: textAlign,
//       //
//       style: TextStyle(
//         fontSize: size ?? getGetFontSize(textType),
//         //
//         fontFamily: fontFamily ?? AppTheme.fontFamily,
//         //
//         fontWeight: isBold ? FontWeight.bold : FontWeight.normal,

//         //
//         color: textColor ??
//             (isLightShade == true
//                 ? Get.theme.colorScheme.onSurface
//                 : Get.theme.colorScheme.onBackground),
//       ),
//     );
//   }
// }

// double getGetFontSize(TextType textType) {
//   //
//   switch (textType) {
//     //
//     case TextType.small:
//       return 13;
//     //
//     case TextType.normal:
//       return 16;
//     //
//     case TextType.large:
//       return 22;
//     //
//     case TextType.extraLarge:
//       return 26;
//     //
//     default:
//       return 16;
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donation_app/theme/app_theme.dart';

enum TextType {
  small,
  normal,
  large,
  extraLarge,
}

class AppText extends StatelessWidget {
  //
  final String data;
  final double? size;
  final bool isBold;
  final bool isLightShade;
  final TextType textType;
  final String? fontFamily;
  final TextAlign textAlign;
  final Color? textColor;

  //
  const AppText(
    this.data, {
    Key? key,
    this.size,
    this.isBold = false,
    this.isLightShade = false,
    this.textType = TextType.normal,
    this.fontFamily,
    this.textAlign = TextAlign.left,
    this.textColor,
  }) : super(key: key);

  //
  @override
  Widget build(BuildContext context) {
    return Text(
      //
      data,
      //
      textAlign: textAlign,
      //
      style: TextStyle(
        fontSize: size ?? getGetFontSize(textType),
        //
        fontFamily: fontFamily ?? AppTheme.fontFamily,
        //
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,

        //
        color: textColor ??
            (isLightShade == true
                ? Get.theme.colorScheme.onSurface
                : Get.theme.colorScheme.onBackground),
      ),
    );
  }
}

double getGetFontSize(TextType textType) {
  //
  switch (textType) {
    //
    case TextType.small:
      return 14;
    //
    case TextType.normal:
      return 16;
    //
    case TextType.large:
      return 20;
    //
    case TextType.extraLarge:
      return 28;
    //
    default:
      return 16;
  }
}
