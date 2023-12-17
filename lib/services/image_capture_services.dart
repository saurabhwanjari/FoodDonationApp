import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/app_text.dart';
//import 'package:donation_app/controllers/menus/add_menu_controller.dart';

class ImageCaptureServices {
  //
  Future<ImageSource?> showImageCapturedOptions() async {
    //
    ImageSource? imageSource;

    //
    imageSource = await Get.bottomSheet(
      Container(
        height: 150,
        color: Get.theme.colorScheme.surface,
        padding: const EdgeInsets.all(16),
        //
        child: Column(
          children: [
            //
            AppText(
              'Select Picture',
              size: 18,
              isBold: true,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //
                InkWell(
                  onTap: () {
                    Get.back(result: ImageSource.camera);
                  },
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Get.theme.colorScheme.onSurface,
                      ),
                      SizedBox(height: 12),
                      AppText('Camera'),
                    ],
                  ),
                ),

                //
                InkWell(
                  onTap: () {
                    Get.back(result: ImageSource.gallery);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.photo_camera_back_rounded,
                        size: 30,
                        color: Get.theme.colorScheme.onSurface,
                      ),
                      SizedBox(height: 12),
                      AppText('Gallery'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return imageSource;
  }

  //
  Widget getCameraOption() {
    return InkWell(
      onTap: () {
        Get.back(result: ImageSource.camera);
      },
      child: Icon(
        Icons.camera_alt,
        size: 30,
        color: Get.theme.colorScheme.onSurface,
      ),
    );
  }

  //
  Widget getGalleryOption() {
    //
    return InkWell(
      onTap: () {
        Get.back(result: ImageSource.gallery);
      },
      child: Icon(
        Icons.camera,
        size: 30,
        color: Get.theme.colorScheme.onSurface,
      ),
    );
  }
}
