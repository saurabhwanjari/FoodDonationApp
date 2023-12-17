import 'package:donation_app/models/donation.dart';
import 'package:donation_app/widgets/app_box.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../controllers/ngo_controllers/detail_screen_controller.dart';
import '../../../services/date_time_format.dart';
import '../accepted_donation/donation_confirmation_screen.dart';

class FoodDetailsScreen extends StatelessWidget {
  DetailScreenController detailScreenController =
      Get.put(DetailScreenController());
  Donation donation;
  String phoneNumber;
  String name;
  // String phoneNumber,
  FoodDetailsScreen(
      {required this.donation,
      required this.phoneNumber,
      required this.name,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Get.theme.colorScheme.primary,
          size: 32,
        ),
        title: Container(
          padding: EdgeInsets.only(top: 8),
          child: AppText(
            'Food Donation',
            textType: TextType.large,
            isBold: true,
            textColor: Get.theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        backgroundColor: Get.theme.colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,

            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Align(
                child: AppText(
                  'Donation from ${name}',
                  size: 18,
                  textType: TextType.large,
                  textColor: Get.theme.colorScheme.primary,
                  isBold: true,
                ),
                alignment: Alignment.center,
              ),
              SizedBox(height: 8),
              donation.foodImage == ''
                  ? Container(
                      height: 180,
                      width: 280,
                      decoration: BoxDecoration(
                        // shape: BoxShape.rectangle,
                        // border: Border.all(
                        //   color: Get.theme.colorScheme.primary,
                        //   width: 1,
                        // ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('images/thali3.png'),
                        ),
                      ),
                    )
                  : Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Get.theme.colorScheme.primary,
                            width: 1,
                          ),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                donation.foodImage,
                              ))),
                    ),

              //
              //SizedBox(height: 8),
              Align(
                child: AppText(
                  donation.mealNames,
                  size: 18,
                  textType: TextType.large,
                  textColor: Get.theme.colorScheme.primary,
                  isBold: true,
                ),
                alignment: Alignment.center,
              ),
              SizedBox(height: 8),
              Align(
                child: AppText(
                  donation.description,
                  isBold: true,
                  size: 15,
                  isLightShade: true,
                  textAlign: TextAlign.center,
                ),
                alignment: Alignment.center,
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 1.5,
                color: Get.theme.colorScheme.primary,
              ),
              SizedBox(height: 18),

              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Align(
                  child: AppText(
                    'Food Details',
                    isBold: true,
                    //textColor: Get.theme.colorScheme.primary,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(height: 12),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppBox(
                    text: '${donation.mealQuantity.toInt()} Persons',
                    icon: Icon(
                      Icons.people_alt_outlined,
                      size: 22,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  AppBox(
                      text: '${donation.mealType}',
                      icon: Image.asset(
                        'images/f1.jpg',
                        height: 23,
                        width: 20,
                      )),
                  AppBox(
                    text: '${donation.mealPackaging}',
                    icon: Icon(
                      Icons.breakfast_dining_rounded,
                      size: 21,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              //
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Align(
                  child: AppText(
                    'Meal will be valid till  :  ${donation.mealExpiryTime} Hours',
                    isBold: true,
                    isLightShade: true,
                    //textColor: Get.theme.colorScheme.primary,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),

              //
              SizedBox(height: 16),

              //
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Align(
                  child: AppText(
                    'Donation Reason       :  ${donation.donationReason}',
                    isBold: true,
                    isLightShade: true,
                    //textColor: Get.theme.colorScheme.primary,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),

              //
              SizedBox(height: 16),

              //
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Align(
                  child: AppText(
                    'Donation Date            :  ${DateTimeFormat.getFormatedDate(donation.donationDate)}',
                    isBold: true,
                    isLightShade: true,
                    //textColor: Get.theme.colorScheme.primary,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),

              //
              SizedBox(height: 16),

              //
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Align(
                  child: AppText(
                    'Donation Time            :  ${DateTimeFormat.getFormatedTime(donation.donationTime)}',
                    isBold: true,
                    isLightShade: true,
                    //textColor: Get.theme.colorScheme.primary,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),

              //
              SizedBox(height: 16),

              //
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Align(
                  child: AppText(
                    'Meal Type                    :  ${donation.mealType}',
                    isBold: true,
                    isLightShade: true,
                    //textColor: Get.theme.colorScheme.primary,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),

              //
              SizedBox(height: 16),

              //
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Align(
                  child: AppText(
                    'Donation Status          :  ${donation.donationStatus}',
                    isBold: true,
                    isLightShade: true,
                    //textColor: Get.theme.colorScheme.primary,
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),

              //
              SizedBox(height: 16),

              //Confirm donation button logic
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: AppButton(
                    text: 'Confirm Donation',
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    onPressed: () {
                      detailScreenController.onConfirmDonation(donation);
                      Get.off(DonationConfirmationScreen(
                        donation: donation,
                      ));
                    }),
              ),
              //
              SizedBox(height: 8),

              InkWell(
                onTap: () async {
                  try {
                    UrlLauncher.launch('tel://${donation.supplierMobileNumber}');                 
                  } catch (error) {
                    print(error);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppText(
                          'If in case any problem is there please contact to the respective food supplier - ${phoneNumber}',
                          textType: TextType.small,
                          isLightShade: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
