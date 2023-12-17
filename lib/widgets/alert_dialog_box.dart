import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_text.dart';

class AlertDialogBox extends StatelessWidget {
  final String title;
  final String content;
  final Function()? yesonPressed;
  final Function()? noonPressed;

  const AlertDialogBox({
    Key? key,
    required this.title,
    required this.content,
    required this.yesonPressed,
    required this.noonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Get.theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            AppText(
              title,
              textType: TextType.large,
              isBold: true,
              textColor: Get.theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            AppText(
              content,
              //textType: TextType.large,
              size: 18,
              isBold: true,
              textAlign: TextAlign.center,
              //textColor: Get.theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            const Divider(
              height: 1,
            ),
            const SizedBox(height: 8),
            Container(
              color: Get.theme.colorScheme.surface,
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Yes
                  Container(
                    width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Get.theme.colorScheme.primary, width: 1),
                    ),
                    child: TextButton(
                      onPressed: yesonPressed,
                      child: AppText(
                        "Yes",
                        textType: TextType.normal,
                        isBold: true,
                        textColor: Get.theme.colorScheme.primary,
                      ),
                    ),
                  ),

                  //No
                  Container(
                    width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Get.theme.colorScheme.primary, width: 1),
                    ),
                    child: TextButton(
                      onPressed: noonPressed,
                      child: AppText(
                        "No",
                        textType: TextType.normal,
                        isBold: true,
                        textColor: Get.theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
