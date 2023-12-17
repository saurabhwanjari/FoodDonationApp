import 'package:donation_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_text.dart';

//
class AppDropDownButton extends StatelessWidget {
  //
  final List<String> items;
  final Function(String?) onChanged;
  String selectedValue;
  final String hintText;
  final IconData? icon;

  //
  AppDropDownButton({
    required this.items,
    required this.onChanged,
    required this.selectedValue,
    required this.hintText,
    this.icon,
    Key? key,
  }) : super(key: key);

  //

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Get.theme.colorScheme.primary,
        ),
      ),
      padding: EdgeInsets.only(left: 8, right: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          //
          hint: Row(
            children: [
              Icon(
                icon,
                color: Get.theme.colorScheme.onSurface,
              ),
              SizedBox(width: 10),
              AppText(
                hintText,
                textColor: Get.theme.colorScheme.onSurface,
              ),
            ],
          ),
          //
          isExpanded: true,

          //
          value: selectedValue == '' ? null : selectedValue,

          //
          items: [
            for (int i = 0; i < items.length; i++)
              DropdownMenuItem(
                //
                child: AppText(
                  items[i],
                ),

                //
                value: items[i],
              ),
          ],

          //
          onChanged: onChanged,
        ),
      ),
    );
  }
}
