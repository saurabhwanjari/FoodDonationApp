import 'package:flutter/material.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/constants/firebase_constants.dart';
import 'package:donation_app/controllers/donation_controller.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_food_infocard_controller.dart';
import 'package:donation_app/screens/ngo_screens/donation/food_details_screen.dart';
import 'package:donation_app/services/firestore_services_supplier.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:get/get.dart';
import '../models/donation.dart';
import '../models/supplier.dart';
import '../screens/ngo_screens/history/ngo_history_details_screen.dart';
import '../services/date_time_format.dart';

class NGOHistoryCard extends StatelessWidget {
  final String donationId;
  final Donation donation;
  NGOHistoryCard({Key? key, required this.donationId, required this.donation})
      : super(key: key);

  NGOFoodInfocardController ngoFoodInfocardController =
      Get.put(NGOFoodInfocardController());

  late DonationController donationController;

  //Getting food supplier data
  Future<Supplier> getSupplierData(String supplierId) async {
    //
    Supplier supplier;

    var rawData = await FirebaseFirestore.instance
        .collection(FirestoreServicesSupplier.supplierUsersCollection)
        .doc(supplierId)
        .get();

    supplier = Supplier.fromDoucmentSnapshot(rawData);

    return supplier;
  }

  @override
  Widget build(BuildContext context) {
    donationController = Get.put(DonationController(), tag: donationId);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.donationCollection)
            .doc(donationId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          //
          Donation donation = Donation.fromDocumentSnapshot(snapshot.data);

          //Set donation in Controller
          donationController.donation = donation;

          //
          return FutureBuilder(
              //
              future: getSupplierData(donation.supplierId),

              //
              builder:
                  (BuildContext context, AsyncSnapshot<Supplier> snapshot) {
                if (!snapshot.hasData) {
                  // return Center(
                  //   child: CircularProgressIndicator(),
                  // );
                  return Container();
                }

                //
                Supplier supplier = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2, top: 8),
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
                          //
                          Get.to(
                            NGOHistoryDetailsScreen(
                            donation: donation,
                          ));
                        },
                        leading: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Get.theme.colorScheme.primary)),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(supplier.profilePicture),
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
                                      'Donation Received From',
                                      size: 14,
                                    ),
                                    supplier.supplierRole == 'Individual'
                                        ? AppText(
                                            supplier.suppliername,
                                            isBold: true,
                                            textColor:
                                                Get.theme.colorScheme.primary,
                                          )
                                        : AppText(
                                            supplier.restaurantName,
                                            isBold: true,
                                            textColor:
                                                Get.theme.colorScheme.primary,
                                          ),
                                  ],
                                ),
                              ],
                            ),

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
                            SizedBox(height: 10),

                            //
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.calendar_month,
                                        size: 16, color: Colors.blue),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    AppText(
                                      '${DateTimeFormat.getFormatedDate(donation.donationDate)}',
                                      size: 12,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.access_time_outlined,
                                        size: 16, color: Colors.blue.shade800),
                                    SizedBox(height: 6),
                                    AppText(
                                      '${DateTimeFormat.getFormatedTime(donation.donationTime)}',
                                      size: 12,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.check_circle_outline,
                                        size: 16, color: Colors.lightGreen.shade700),

                                    SizedBox(
                                      height: 6,
                                    ),
                                    AppText(
                                      donation.donationStatus,
                                      size: 12,
                                    ),
                                    // SizedBox(
                                    //   height: 16,
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
