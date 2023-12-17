import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/constants/app_colors.dart';
import 'package:donation_app/controllers/supplier_controllers/donate_food_controller.dart';
import 'package:donation_app/controllers/supplier_controllers/supplier_data_controller.dart';
import 'package:donation_app/services/date_time_format.dart';
import 'package:donation_app/widgets/alert_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:donation_app/models/donation.dart';
import 'package:donation_app/screens/supplier_screens/donation/add_donation_form.dart';
import 'package:donation_app/widgets/app_text.dart';

import '../constants/firebase_constants.dart';
import '../controllers/supplier_controllers/supplier_side_detail_screen_controller.dart';
import '../screens/supplier_screens/donation/successful_donation_screen.dart';

class SupplierFoodInfoCard extends StatelessWidget {
  final Donation donation;

  //
  SupplierFoodInfoCard({required this.donation, Key? key}) : super(key: key);

  SupplierDataController supplierDataController =
      Get.find<SupplierDataController>();

  final DonateFoodController donateFoodController =
      Get.find<DonateFoodController>();

  SupplierSideDetailScreenController supplierSideDetailScreenController =
      Get.put(SupplierSideDetailScreenController());

  //final List<String> roleList = ['Individual', 'Restaurant Owner'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 8),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          //borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Get.theme.colorScheme.onSecondary,
            width: 0.4,
          ),
        ),
        //color: Get.theme.colorScheme.background,
        //color: AppColors.cardColor,

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          // height: donation.donationStatus == 'Done' ||
          //         donation.donationStatus == 'Expired'
          //     ? 100
          //     : 164,
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //padding: EdgeInsets.only(left: 5),
                child: donation.foodImage == ''
                    ? Image.asset(
                        'images/thali3.png',
                        alignment: Alignment.center,
                        fit: BoxFit.fill,
                        height: 120,
                        width: 100,
                        //color: Get.theme.colorScheme.primary.withOpacity(0.8),
                      )
                    : Image.network(
                        donation.foodImage,
                        height: 80,
                        width: 95,
                        alignment: Alignment.center,
                        fit: BoxFit.fill,
                      ),
              ),
              SizedBox(width: 10),

              //
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 4),
                  //color: Colors.green,
                  width: double.infinity,
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppText(
                              donation.mealNames,
                              isBold: true,
                            ),
                          ),
                          Column(
                            //mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppText(
                                '${DateTimeFormat.getFormatedDate(donation.donationDate)}',
                                size: 14,
                                isBold: true,
                              ),
                              //Time
                              AppText(
                                DateTimeFormat.getFormatedTime(
                                    donation.donationTime),
                                size: 13,
                                //textType: TextType.small,
                              ),
                            ],
                          ),
                        ],
                      ),
                      donation.donationStatus == 'Pending'
                          ? SizedBox(
                              height: 4,
                            )
                          : donation.donationStatus == 'Confirmed'
                              ? SizedBox(
                                  height: 4,
                                )
                              : Container(),

                      //description
                      donation.donationStatus == 'Pending'
                          ? AppText(
                              donation.description,
                              size: 13,
                              isLightShade: true,
                              textAlign: TextAlign.justify,
                            )
                          : donation.donationStatus == 'Confirmed'
                              ? AppText(
                                  donation.description,
                                  size: 13,
                                  isLightShade: true,
                                  textAlign: TextAlign.justify,
                                )
                              : Container(),
                      //Divider(),
                      SizedBox(
                        height: 4,
                      ),

                      //Row
                      donation.donationStatus == 'Pending'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      'images/f1.jpg',
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(height: 6),
                                    AppText(
                                      '${donation.mealType}',
                                      size: 12,
                                    ),
                                  ],
                                ),

                                //
                                //SizedBox(width: 30),
                                //
                                Column(
                                  children: [
                                    Icon(
                                      Icons.people_outline,
                                      size: 16,
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    AppText(
                                      '${donation.mealQuantity.toInt()} Persons',
                                      size: 12,
                                    ),
                                  ],
                                ),

                                Column(
                                  children: [
                                    Icon(
                                      Icons.handshake_outlined,
                                      size: 16,
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    AppText(
                                      '${donation.donationReason}',
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : donation.donationStatus == 'Confirmed'
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          'images/f1.jpg',
                                          height: 20,
                                          width: 20,
                                        ),
                                        SizedBox(height: 6),
                                        AppText(
                                          '${donation.mealType}',
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.people_outline,
                                          size: 16,
                                          color: Get.theme.colorScheme.primary,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        AppText(
                                          '${donation.mealQuantity.toInt()} Persons',
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.handshake_outlined,
                                          size: 16,
                                          color: Get.theme.colorScheme.primary,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        AppText(
                                          '${donation.donationReason}',
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                      SizedBox(height: 8),
                      //Divider(),

                      donation.donationStatus == 'Done' ||
                              donation.donationStatus == 'Expired'
                          ? Divider()
                          : Container(),
                      donation.donationStatus == 'Done' ||
                              donation.donationStatus == 'Expired'
                          ? SizedBox(height: 6)
                          : Container(),

                      donation.donationStatus == 'Pending'
                          ? Row(
                              children: [
                                AppText(
                                  'Donation : ${donation.donationStatus}',
                                  size: 14,
                                  isBold: true,
                                  textColor: Colors.blue.shade800,
                                ),
                                SizedBox(width: 2),
                                Icon(
                                  Icons.pending_outlined,
                                  size: 16,
                                  color: Colors.blue.shade800,
                                ),
                              ],
                            )
                          : donation.donationStatus == 'Done'
                              ? Row(
                                  children: [
                                    AppText(
                                      'Donation ${donation.donationStatus} successfully!',
                                      size: 15,
                                      isBold: true,
                                      textColor: Colors.lightGreen.shade800,
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.check_circle,
                                      size: 16,
                                      color: Colors.lightGreen.shade800,
                                    ),
                                  ],
                                )
                              : donation.donationStatus == 'Confirmed'
                                  ? Row(
                                      children: [
                                        AppText(
                                          '${donation.donationStatus} by ${donation.ngoOrganizationName}',
                                          size: 14,
                                          isBold: true,
                                          textColor: Colors.lightGreen.shade700,
                                        ),
                                        SizedBox(width: 2),
                                        Icon(
                                          Icons.check_circle_outline,
                                          size: 18,
                                          color: Colors.lightGreen.shade700,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        AppText(
                                          'Meal has ${donation.donationStatus}',
                                          size: 15,
                                          isBold: true,
                                          textColor: Colors.red.shade800,
                                        ),
                                        SizedBox(width: 2),
                                        Icon(
                                          Icons.cancel_outlined,
                                          size: 16,
                                          color: Colors.red.shade800,
                                        ),
                                      ],
                                    ),

                      SizedBox(height: 2),

                      //edit button
                      InkWell(
                        child: donation.donationStatus == 'Pending'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AppText(
                                    'Edit Donation ',
                                    textType: TextType.small,
                                    textColor: Get.theme.colorScheme.primary,
                                    isBold: true,
                                  ),
                                ],
                              )
                            : Container(),
                        onTap: () {
                          Get.to(() => AddDonationForm(
                                donation: donation,
                              ));
                        },
                      ),
                      SizedBox(height: 4),

                      //
                      InkWell(
                        child: donation.donationStatus == 'Confirmed'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AppText(
                                    'NGO Picked',
                                    textType: TextType.small,
                                    textColor: Get.theme.colorScheme.primary,
                                    isBold: true,
                                  ),
                                ],
                              )
                            : Container(),
                        onTap: () {
                          //

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialogBox(
                                  title: 'Donation Picked by NGO?',
                                  content:
                                      'Does the donation really picked by NGO?',
                                  yesonPressed: () async {
                                    await supplierSideDetailScreenController
                                        .onNGOPickedDonation(donation);

                                    Get.off(SuccessfulDonationScreen(
                                        donation: donation));
                                  },
                                  noonPressed: () {
                                    Get.back();
                                  },
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
