import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donation_app/constants/app_colors.dart';

class AppSlider extends StatelessWidget {
  //
  final double value;
  final String label;
  final void Function(dynamic)? onChange;
  final double min;
  final double max;
  final Color? activeColor;
  final Color? inactiveColor;
  final double interval;
  final int divisions;

  //
  const AppSlider({
    required this.value,
    required this.label,
    this.onChange,
    required this.min,
    required this.max,
    this.activeColor,
    this.inactiveColor,
    this.interval = 1,
    required this.divisions,
    Key? key,
  }) : super(key: key);

  //
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      label: label,
      divisions: divisions,
      onChanged: onChange,
            
      min: min,
      max: max,
      activeColor: Get.theme.colorScheme.primary,
      inactiveColor: Get.theme.colorScheme.secondary,
    );
  }
}
