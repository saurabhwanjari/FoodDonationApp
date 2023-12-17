import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/controllers/supplier_controllers/supplier_data_controller.dart';
import 'package:donation_app/screens/common_screens/supplier_help_screen.dart';
import 'package:donation_app/screens/common_screens/terms_conditions.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/common_screens/about_screen.dart';

class SupplierAppDrawer extends StatelessWidget {
  SupplierAppDrawer({Key? key}) : super(key: key);

  SupplierDataController supplierDataController =
      Get.find<SupplierDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        //
        UserAccountsDrawerHeader(
          accountName: AppText(
            supplierDataController.rxSupplier.value.suppliername,
            //textColor: Get.theme.colorScheme.background,
            isBold: true,
            size: 17,
          ),
          accountEmail: AppText(
            '( Helping The Needy )',
            //isBold: true,
            size: 14,
          ),
          decoration: BoxDecoration(
            color: Color(0xFFFAC76A),
            //border: Border.all(color: Colors.white)
          ),
          currentAccountPicture: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Get.theme.colorScheme.primary,
                  width: 2,
                )),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                supplierDataController.rxSupplier.value.profilePicture,
              ),
            ),
          ),
        ),

        //Help
        ListTile(
          leading: Icon(
            Icons.help_outline,
            color: Get.theme.colorScheme.primary,
          ),
          title: AppText(
            'Help',
            size: 15,
          ),
          onTap: () {
            Get.to(SupplierHelpScreen());
          },
        ),

        //Terms & Conditions
        ListTile(
          leading: Icon(
            Icons.description_outlined,
            color: Get.theme.colorScheme.primary,
          ),
          title: AppText(
            'Terms & Conditions',
            size: 15,
          ),
          onTap: () {
            Get.to(TermsConditions());
          },
        ),

        //About us
        ListTile(
          leading: Icon(
            Icons.info_outline,
            color: Get.theme.colorScheme.primary,
          ),
          title: AppText(
            'About',
            size: 15,
          ),
          onTap: () {
            Get.to(AboutScreen());
          },
        ),
      ],
    ));
  }
}
