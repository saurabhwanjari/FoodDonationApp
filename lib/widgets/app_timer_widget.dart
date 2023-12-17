import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_text.dart';

class AppTimerWidget extends StatelessWidget {
  //
  final String text;
  final IconData icon;
  final void Function()? onTap;
  //
  const AppTimerWidget(
      {required this.text, required this.icon, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Get.theme.colorScheme.primary, width: 0.6),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Get.theme.colorScheme.primary,
            ),
            const SizedBox(width: 16),
            AppText(
              text,
              textColor: Get.theme.colorScheme.onSurface,
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
