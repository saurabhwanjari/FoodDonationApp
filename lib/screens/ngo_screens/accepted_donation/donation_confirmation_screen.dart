import 'package:donation_app/controllers/ngo_controllers/detail_screen_controller.dart';
import 'package:donation_app/controllers/supplier_controllers/supplier_side_detail_screen_controller.dart';
import 'package:donation_app/screens/ngo_screens/accepted_donation/google_maps_screen.dart';
import 'package:donation_app/screens/ngo_screens/ngohomepage.dart';
import 'package:donation_app/screens/supplier_screens/supplierhomepage.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../models/donation.dart';

class DonationConfirmationScreen extends StatelessWidget {
  Donation donation;
  SupplierSideDetailScreenController supplierSideDetailScreenController =
      Get.put(SupplierSideDetailScreenController());
  DonationConfirmationScreen({Key? key, required this.donation})
      : super(key: key);

  DetailScreenController detailScreenController =
      Get.find<DetailScreenController>();

  Location location = Location();
  var lat, long;

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
              'Thank You For Confirming The Donation',
              textAlign: TextAlign.center,
              isBold: true,
              size: 24,
            ),
          ),
          SizedBox(height: 8),
          AppText(
            'Appreciating Your Kindness',
            isBold: true,
            size: 18,
            textColor: Get.theme.colorScheme.primary,
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: AppText(
              'Enable Permission to Get location of Food Supplier by clicking the below button',
              size: 13,
              textAlign: TextAlign.center,
            ),
          ),
           SizedBox(height: 8),
          InkWell(
            child: AppText(
              'Enable Permission',
              isBold: true,
              textColor: Get.theme.colorScheme.primary,
            ),
            onTap: () async {
              var value = await location.getLocation();
              lat = value.latitude!.toDouble();
              long = value.longitude!.toDouble();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppButton(
              text: 'Get Location',
              onPressed: () async {
                //
                //detailScreenController.onGetLocation(donation);
                var value = await location.getLocation();

                var latd = donation.latitude;
                var longd = donation.longitude;
                print(latd);
                print(longd);

                MapLauncher.showDirections(
                    mapType: MapType.google,
                    //destination: Coords(21.1458, 79.0882),   //Nagpur Co-ordinates
                    destination:
                        Coords(double.parse(latd), double.parse(longd)),
                    origin: Coords(value.latitude!.toDouble(),
                        value.longitude!.toDouble()));
              },
              
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppButton(
              text: 'Select Another Donation',
              onPressed: () async {
                Get.back();
              },
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
