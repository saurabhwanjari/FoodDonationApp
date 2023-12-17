import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/constants/firebase_constants.dart';
import 'package:donation_app/controllers/donation_controller.dart';
import 'package:donation_app/controllers/ngo_controllers/detail_screen_controller.dart';
import 'package:donation_app/screens/ngo_screens/accepted_donation/donation_confirmation_screen.dart';
import 'package:donation_app/screens/ngo_screens/accepted_donation/google_maps_screen.dart';
import 'package:donation_app/screens/ngo_screens/donation/food_details_screen.dart';
import 'package:donation_app/services/firestore_services_supplier.dart';
import 'package:donation_app/widgets/alert_dialog_box.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../constants/app_colors.dart';
import '../models/donation.dart';
import '../models/supplier.dart';
import '../services/date_time_format.dart';

class AcceptDonationCard extends StatelessWidget {
  final String donationId;
  final Donation donation;

  //
  DetailScreenController detailScreenController =
      Get.put(DetailScreenController());
  AcceptDonationCard(
      {Key? key, required this.donationId, required this.donation})
      : super(key: key);

  late DonationController donationController;

  @override
  Widget build(BuildContext context) {
    //
    donationController = Get.put(DonationController(), tag: donationId);

    //
    //Donation donation = Donation.fromDocumentSnapshot(snapshot.data);

    if (donationController.mealExpired.value == true) {
      try {
        FirebaseFirestore.instance
            .collection(FirebaseConstants.donationCollection)
            .doc(donation.documentId)
            .update({'donationStatus': DonationStatus.expired});
      } catch (error) {
        print(error);
      }
    }
    //Set donation in Controller
    donationController.donation = donation;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 12),
      child: Card(
        elevation: 0.4,
        shape: RoundedRectangleBorder(
          //borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Get.theme.colorScheme.onSecondary,
            width: 0.4,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 6),
          child: ListTile(
            onTap: () {
              Get.to(FoodDetailsScreen(
                donation: donation,
                name: donation.supplierRole == 'Individual'
                    ? donation.supplierName
                    : donation.supplierRestaurantName,
                phoneNumber: donation.supplierMobileNumber,
              ));
            },
            leading: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Get.theme.colorScheme.primary)),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(donation.supplierProfilrPicture),
              ),
            ),

            //
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Donation From',
                          size: 14,
                        ),
                        donation.supplierRole == 'Individual'
                            ? AppText(
                                donation.supplierName,
                                isBold: true,
                                textColor: Get.theme.colorScheme.primary,
                              )
                            : AppText(
                                donation.supplierRestaurantName,
                                isBold: true,
                                textColor: Get.theme.colorScheme.primary,
                              ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppText(
                          DateTimeFormat.getFormatedDate(donation.donationTime),
                          size: 14,
                          isBold: true,
                        ),
                        AppText(
                          DateTimeFormat.getFormatedTime(donation.donationDate),
                          size: 13,
                        ),
                      ],
                    ),
                  ],
                ),

                //SizedBox(height: 16),

                const SizedBox(height: 4),

                //
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  donation.mealNames,
                  isBold: true,
                  size: 14,
                ),
                // Obx(() {
                //   // print('timer ui caleld');
                //   return donationController.mealExpired.value
                //       ? AppText('Meal has expired')
                //       : AppText(
                //           'Meal expires in : ${donationController.hr.value} : ${donationController.mm.value} : ${donationController.ss.value}',
                //           size: 14,
                //         );
                // }),
                Row(
                  children: [
                    AppText(
                      'Donation :',
                      size: 14,
                    ),
                    Row(
                      children: [
                        AppText(
                          '${donation.donationStatus}',
                          textColor: Colors.lightGreen.shade800,
                          isBold: true,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.check_circle_outline,
                          size: 18,
                          color: Colors.lightGreen.shade800,
                        )
                      ],
                    )
                  ],
                ),

                //SizedBox(height: 10),
                Divider(),
                //SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.phone,
                        color: Get.theme.colorScheme.primary, size: 18),
                    SizedBox(width: 6),
                    AppText(
                      donation.supplierMobileNumber,
                      textType: TextType.small,
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(FoodDetailsScreen(
                          donation: donation,
                          name: donation.supplierName,
                          phoneNumber: donation.supplierMobileNumber,
                        ));
                      },
                      child: Container(
                          child: Row(
                              //mainAxisAlignment: MainAxisAlignment.end

                              children: [
                            MaterialButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialogBox(
                                        title: 'Attention!',
                                        content:
                                            'Are you really want to decline the donation?',
                                        yesonPressed: () {
                                          detailScreenController
                                              .onRejectDonation(donation);
                                          Get.back();
                                        },
                                        noonPressed: () {
                                          Get.back();
                                        },
                                      );
                                    });
                              },
                              elevation: 0,
                              child: AppText('Decline'),
                              height: 30,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                side: BorderSide(
                                  color: Get.theme.colorScheme.primary,
                                ),
                              ),
                              color: Colors.white,
                            ),

                            //
                            SizedBox(width: 12),

                            //
                            MaterialButton(
                                onPressed: () {
                                  detailScreenController
                                      .onGetLocation(donation);

                                  ////////////////////////////////////////////
                                  Get.to(DonationConfirmationScreen(
                                    donation: donation,
                                  ));
                                },
                                elevation: 0,
                                child: AppText('Get Location'),
                                height: 30,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    side: BorderSide(
                                        color: Get.theme.colorScheme.primary)),
                                color: Colors.white),
                          ])),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
