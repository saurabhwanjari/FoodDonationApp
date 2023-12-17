import 'package:donation_app/controllers/supplier_controllers/supplier_side_detail_screen_controller.dart';
import 'package:donation_app/screens/supplier_screens/supplierhomepage.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/donation.dart';

class SuccessfulDonationScreen extends StatelessWidget {
  Donation donation;
  //SupplierSideDetailScreenController supplierSideDetailScreenController =
    //  Get.put(SupplierSideDetailScreenController());
   SuccessfulDonationScreen({Key? key, required this.donation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            child: Image.asset(
              'images/successful.png',
              height: 400,
              width: 400,
              color: Get.theme.colorScheme.primary,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AppText(
              'Thank You For Donating the Food',
              isBold: true,
              size: 24,
            ),
          ),
          AppText(
            'Appreciating Your Kindness',
            isBold: true,
            size: 18,
            textColor: Get.theme.colorScheme.primary,
          ),
          SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppButton(
              text: 'Back',
              onPressed: () {
                Get.off(SupplierHomePage());
              },
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
