import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextfield extends StatelessWidget {
  //
  final String hintText;
  final Widget? prefixIcon;
  final TextEditingController? textEditingController;
  final void Function(String)? onChange;
  final String? Function(String?)? validate;
  final void Function(String?)? onSaved;
  final int maxLines;
  final int minLines;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;

  //
  const AppTextfield({
    required this.hintText,
    this.prefixIcon,
    this.textEditingController,
    this.onChange,
    this.validate,
    this.onSaved,
    this.maxLines = 1,
    this.minLines = 1,
    this.keyboardType,
    this.textCapitalization,
    Key? key,
  }) : super(key: key);

  //
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      controller: textEditingController,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization == null
          ? TextCapitalization.words
          : textCapitalization!,
      onChanged: onChange,
      validator: validate,
      onSaved: onSaved,
      style: TextStyle(
        fontSize: 16,
        color: Get.theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        fillColor: Get.theme.colorScheme.background,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Get.theme.colorScheme.onSurface,
        ),

        //
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.primary,
            width: 1,
          ),
        ),

        //
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.primary,
            width: 1,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.error,
            width: 1,
          ),
        ),

        //
        //
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          borderSide: BorderSide(
            color: Get.theme.colorScheme.error,
            width: 1,
          ),
        ),
      ),
    );
  }
}
