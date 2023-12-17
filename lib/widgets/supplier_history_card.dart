// import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
// import 'package:donation_app/screens/supplier_screens/history/history_details_screen.dart';
// import 'package:donation_app/widgets/app_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../models/donation.dart';
// import '../services/date_time_format.dart';

// class SupplierHistoryCard extends StatelessWidget {
//   final Donation donation;
//   const SupplierHistoryCard({Key? key, required this.donation})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, top: 12),
//       child: Card(
//         elevation: 0.4,
//         shape: RoundedRectangleBorder(
//           //borderRadius: BorderRadius.circular(5),
//           side: BorderSide(
//             color: Get.theme.colorScheme.onSecondary,
//             width: 0.4,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(top: 6, bottom: 6),
//           child: ListTile(
//             onTap: () {
//               //
//               Get.to(HistoryDetailsScreen(donation: donation));
//             },
//             leading: Container(
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Get.theme.colorScheme.primary)),
//               child: CircleAvatar(
//                 radius: 30,
//                 backgroundImage: NetworkImage(donation.ngoProfilePicture),
//               ),
//             ),

//             //
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 //

//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AppText(
//                       'Donated to : ',
//                       size: 14,
//                     ),
//                     AppText(
//                       donation.ngoOrganizationName,
//                       isBold: true,
//                       size: 14,
//                       //textColor: Get.theme.colorScheme.primary,
//                     )
//                   ],
//                 ),

//                 const SizedBox(height: 4),

//                 //
//               ],
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // AppText(
//                 //   donation.ngoDescription,
//                 //   isLightShade: true,
//                 //   size: 14,
//                 // ),
//                 const SizedBox(height: 4),

//                 AppText(
//                   donation.mealName,
//                   isBold: true,
//                   size: 14,
//                 ),

//                 SizedBox(height: 8),

//                 //
//                 //Row

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         Icon(
//                           Icons.people_outline,
//                           size: 16,
//                           color: Get.theme.colorScheme.primary,
//                         ),
//                         SizedBox(
//                           height: 6,
//                         ),
//                         AppText(
//                           '${donation.mealQuantity.toInt()} Persons',
//                           size: 12,
//                         ),
//                       ],
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Icon(Icons.calendar_month,
//                             size: 16, color: Colors.blue),

//                         SizedBox(
//                           height: 6,
//                         ),
//                         AppText(
//                           '${DateTimeFormat.getFormatedDate(donation.donationDate)}',
//                           size: 12,
//                         ),
//                         // SizedBox(
//                         //   height: 16,
//                         // ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Icon(Icons.access_time_outlined,
//                             size: 16, color: Colors.blue.shade800),
//                         SizedBox(height: 6),
//                         AppText(
//                           '${DateTimeFormat.getFormatedTime(donation.donationTime)}',
//                           size: 12,
//                         ),
//                       ],
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Icon(Icons.check, size: 16, color: Colors.green),

//                         SizedBox(
//                           height: 6,
//                         ),
//                         AppText(
//                           donation.donationStatus,
//                           size: 12,
//                         ),
//                         // SizedBox(
//                         //   height: 16,
//                         // ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:donation_app/models/ngo_head.dart';
import 'package:donation_app/services/firestore_services_ngo.dart';
import 'package:donation_app/widgets/supplier_food_infocard.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/constants/firebase_constants.dart';
import 'package:donation_app/controllers/donation_controller.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:get/get.dart';
import '../models/donation.dart';
import '../screens/supplier_screens/history/history_details_screen.dart';
import '../services/date_time_format.dart';

class SupplierHistoryCard extends StatelessWidget {
  final String donationId;
  final Donation donation;
  SupplierHistoryCard(
      {Key? key, required this.donationId, required this.donation})
      : super(key: key);

  late SupplierFoodInfoCard supplierFoodInfoCard;

  late DonationController donationController;

  @override
  Widget build(BuildContext context) {
    supplierFoodInfoCard = Get.put(SupplierFoodInfoCard(donation: donation));
    donationController = Get.put(DonationController(), tag: donationId);

    //Set donation in Controller
    donationController.donation = donation;

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
              Get.to(HistoryDetailsScreen(
                donation: donation,
                // ngoHead: ngoHead,
              ));
            },
            leading: donation.donationStatus == 'Done'
                ? Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Get.theme.colorScheme.primary)),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(donation.ngoProfilePicture),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //border: Border.all(color: Get.theme.colorScheme.primary),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('images/cross3.jpg'),
                    ),
                  ),

            //
            title: donation.donationStatus == 'Done'
                ? AppText(
                    'Food Donated to ${donation.ngoOrganizationName}',
                    //'Food Donated to Yogdan Jan Jagruti Foundation',
                    size: 14,
                    isBold: true,
                  )
                : AppText(
                    'Meal has Expired',
                    //'Food Donated to Yogdan Jan Jagruti Foundation',
                    size: 14,
                    isBold: true,
                  ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),

                AppText(
                  donation.mealNames,
                  // isBold: true,
                  // textColor: Get.theme.colorScheme.primary,
                  size: 15,
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
                          '${DateTimeFormat.getFormatedDate(donation.donationCompleteDate)}',
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
                          '${DateTimeFormat.getFormatedTime(donation.donationCompleteTime)}',
                          size: 12,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        donation.donationStatus == 'Done'
                            ? Icon(Icons.check_circle_outline,
                                size: 16, color: Colors.green)
                            : Icon(Icons.cancel_outlined,
                                size: 16, color: Colors.red),
                        SizedBox(
                          height: 6,
                        ),
                        AppText(
                          donation.donationStatus,
                          size: 12,
                        )
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
  }
}
