import 'package:flutter/material.dart';

class AppColors {
  // extra color needed for app
  static const greyColor = Color(0xFFbfbfbf);
  static const primary = Color(0xFFffffff);
  static const primaryColor = Color(0xFFF8AC24);
  
  
  //static const disabledButtonColor = Color(0xFFF2B685);
  static const disabledButtonColor = Color(0xFFFBCE7D);

  static const disabledButtonTextColor = Color(0xFFF2F2F2);

  static const cardColor = Color(0xFFFDFDFD);
  // // Color Scheme for dark mode
  // static const ColorScheme dark = ColorScheme.dark(
  //   //
  //   primary: Color(0xFFff7037),
  //   //primaryVariant: Color(0xFFff7037),
  //   onPrimary: Color(0xFFffffff),

  //   //Color(0xFF81C784);
  //   secondary: Color(0xFF00b050),
  //   //secondaryVariant: Color(0xFF00b050),
  //   onSecondary: Color(0xFFffffff),

  //   //
  //   background: Color(0xFFffffff),
  //   onBackground: Color(0xFF222222),

  //   //
  //   surface: Color(0XFFcbcbcb),
  //   onSurface: Color(0xFF3e3d3d),

  //   //
  //   error: Color(0XFFda2a2a),
  //   onError: Color(0xFFffffff),
  // );

  //
  // Color Scheme for light mode I made changes here
  static const ColorScheme light = ColorScheme.light(
    //
    //primary: Color(0xFFE46C0A),      //Orange Color
    primary: Color(0xFFF8AC24),    //main color
    //primary: Color(0xFFe87a1a),      
    //primary: Color(0xFFE4870A),      //Yellow Color
    //primaryVariant: Color(0xFFff7037),
    onPrimary: Color(0xFFffffff),

    //
    secondary: Color(0xFFE8E8E8),
    //secondaryVariant: Color(0xFF00b050),
    onSecondary: Color(0xFFA6A6A6),

    //
    background: Color(0xFFffffff),
    onBackground: Color(0xFF262626),

    //
    surface: Color(0XFFF2F2F2),
    onSurface: Color(0xFF595959),

    //
    error: Color(0XFFda2a2a),
    onError: Color(0xFFffffff),
  );
}
//0XFFF6A733