import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:group_button/group_button.dart';

import '../constants/app_colors.dart';

class AppGroupButtons extends StatelessWidget {
  //
  final List<String> items;
  final void Function(int, bool) onSelected;
  final double fontSize;
  int selectedButtonIndex = -1;

  //
  AppGroupButtons({
    required this.items,
    required this.onSelected,
    required this.fontSize,
    required this.selectedButtonIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('index = $selectedButtonIndex');
    return GroupButton(
      //
      //
      controller: selectedButtonIndex == -1
          ? GroupButtonController()
          : GroupButtonController()
        ..selectIndex(selectedButtonIndex),
      //
      isRadio: true,
      //
      onSelected: onSelected,
      //
      buttons: items,

      //
      options: GroupButtonOptions(
        //
        unselectedShadow: [],
        //
        groupingType: GroupingType.wrap,
        //
        direction: Axis.horizontal,
        //
        alignment: Alignment.topLeft,

        //
        groupRunAlignment: GroupRunAlignment.start,

        //
        crossGroupAlignment: CrossGroupAlignment.start,
        //
        spacing: 6,
        runSpacing: 4,
        //
        selectedTextStyle: TextStyle(
          fontSize: fontSize,
          color: Get.theme.colorScheme.onPrimary,
        ),
        //
        unselectedTextStyle: TextStyle(
          fontSize: fontSize,
          color: Get.theme.colorScheme.onSurface,
        ),
        //
        selectedColor: Get.theme.colorScheme.primary,
        //
        unselectedColor: Get.theme.colorScheme.background,
        //
        selectedBorderColor: Get.theme.colorScheme.primary,
        //
        unselectedBorderColor: Get.theme.colorScheme.primary,
        //
        borderRadius: BorderRadius.circular(30),
        //
        textPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        //
        mainGroupAlignment: MainGroupAlignment.start,
      ),
    );
  }
}
