import 'package:flutter/material.dart';
import 'app_text.dart';

class AppTextButton extends StatelessWidget {
  //
  final String text;
  final Function() onPressed;
  // final double? size;
  final Color? color;
  //
  const AppTextButton({
    required this.text,
    required this.onPressed,
    // this.size,
    this.color,
    Key? key,
  }) : super(key: key);

  //
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(primary: color),
      //
      child: AppText(
        text,
        textColor: color,
      ),
      //
      onPressed: onPressed,
    );
  }
}
