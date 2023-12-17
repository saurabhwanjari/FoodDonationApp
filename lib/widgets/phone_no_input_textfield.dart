import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:donation_app/controllers/authentication/OTPController.dart';
import 'app_text.dart';

//
class PhoneNoInputTextfield extends StatelessWidget {
  //
  final TextEditingController textEditingController;
  final String hintText;
  final void Function(String)? onChange;

  //
  const PhoneNoInputTextfield({
    Key? key,
    required this.hintText,
    required this.onChange,
    required this.textEditingController,
  }) : super(key: key);

  //
  @override
  Widget build(BuildContext context) {
    //
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      //
      child: TextField(
        //
        controller: textEditingController,
        onChanged: onChange,

        //
        maxLength: 10,
        style: const TextStyle(
          fontSize: 20,
          letterSpacing: 3,
        ),
        //
        keyboardType: TextInputType.number,
        //
        decoration: InputDecoration(
          hintStyle: const TextStyle(fontSize: 17),
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: const AppText('   +91  ', size: 20),
          contentPadding: const EdgeInsets.all(20),
          counterText: '',
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
        ),
      ),
    );
  }
}