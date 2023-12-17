import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/constants/firebase_constants.dart';
import 'package:donation_app/controllers/donation_controller.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_food_infocard_controller.dart';
import 'package:donation_app/screens/ngo_screens/donation/food_details_screen.dart';
import 'package:donation_app/services/firestore_services_supplier.dart';
import 'package:donation_app/widgets/alert_dialog_box.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../constants/app_colors.dart';
import '../controllers/ngo_controllers/detail_screen_controller.dart';
import '../models/donation.dart';
import '../models/supplier.dart';
import '../screens/ngo_screens/accepted_donation/donation_confirmation_screen.dart';
import '../services/date_time_format.dart';

class NGOFoodInfocard extends StatelessWidget {
  final String donationId;
  final Donation donation;
  NGOFoodInfocard({Key? key, required this.donationId, required this.donation})
      : super(key: key);

  late DonationController donationController;

  DetailScreenController detailScreenController =
      Get.put(DetailScreenController());

  @override
  Widget build(BuildContext context) {
    donationController = Get.put(DonationController(), tag: donationId);

    //donationController.setDonationData(donation);
    if (!donationController.isTimerstarted) {
      donationController.setDonationData(donation);
    }

    //Set donation in Controller
    donationController.donation = donation;

    //
    print('Future builder rebuild for ${donation.mealNames}');

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
        child: Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 6),
          child: ListTile(
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

                Divider(),

                //
              ],
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  donation.mealNames,
                  isBold: true,
                  size: 15,
                ),
                SizedBox(height: 4),

                //meal expiry time
                Row(
                  children: [
                    donation.donationStatus == 'Pending'
                        ? Obx(() {
                            // print('timer ui caleld');
                            return donationController.mealExpired.value
                                ? AppText('Meal has expired')
                                : AppText(
                                    'Meal expires in : ${donationController.hr.value} : ${donationController.mm.value} : ${donationController.ss.value}',
                                    size: 14,
                                    isBold: true,
                                  );
                          })
                        : Container(),
                  ],
                ),

                Row(
                  children: [
                    donation.donationStatus == 'Done'
                        ? Container()
                        : AppText(
                            'Donation : ',
                            size: 14,
                          ),
                    donation.donationStatus == 'Confirmed'
                        ? Row(
                            children: [
                              AppText(
                                '${donation.donationStatus}',
                                textColor: Colors.lightGreen.shade700,
                                isBold: true,
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.check_circle_outline,
                                size: 18,
                                color: Colors.lightGreen.shade700,
                              )
                            ],
                          )
                        : donation.donationStatus == 'Done'
                            ? Row(
                                children: [
                                  AppText(
                                    'Donation Picked Successfully',
                                    textColor: Colors.lightGreen.shade800,
                                    isBold: true,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color: Colors.lightGreen.shade800,
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  AppText(
                                    '${donation.donationStatus}',
                                    textColor: Colors.blue.shade700,
                                    isBold: true,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.pending_outlined,
                                    size: 18,
                                    color: Colors.blue.shade700,
                                  )
                                ],
                              ),
                  ],
                ),
                //SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                        child: donation.donationStatus == 'Pending'
                            ? Row(children: [
                                AppText(
                                  'Get Details',
                                  isBold: true,
                                  size: 15,
                                  textColor: Get.theme.colorScheme.primary,
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Get.theme.colorScheme.primary,
                                )
                              ])
                            : Container(),
                      ),
                    )
                  ],
                ),
                //SizedBox(height: 2),
                donation.donationStatus == 'Confirmed'
                    ? InkWell(
                        onTap: () async {
                          try {
                            UrlLauncher.launch(
                                'tel://${donation.supplierMobileNumber}');
                          } catch (error) {
                            print(error);
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.phone,
                                color: Get.theme.colorScheme.primary, size: 18),
                            SizedBox(width: 6),
                            AppText(
                              donation.supplierMobileNumber,
                              textType: TextType.small,
                              isBold: true,
                              isLightShade: true,
                            ),
                          ],
                        ),
                      )
                    : Container(),

                donation.donationStatus == 'Confirmed'
                    ? Row(
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
                                  SizedBox(width: 22),

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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          side: BorderSide(
                                              color: Get
                                                  .theme.colorScheme.primary)),
                                      color: Colors.white),
                                ])),
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





///////////////////////////////////////////////////////////////////////////////////////////////
///
// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:donation_app/constants/firebase_constants.dart';
// import 'package:donation_app/controllers/donation_controller.dart';
// import 'package:donation_app/controllers/ngo_controllers/ngo_food_infocard_controller.dart';
// import 'package:donation_app/screens/ngo_screens/donation/food_details_screen.dart';
// import 'package:donation_app/services/firestore_services_supplier.dart';
// import 'package:donation_app/widgets/app_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';

// import '../constants/app_colors.dart';
// import '../models/donation.dart';
// import '../models/supplier.dart';
// import '../services/date_time_format.dart';

// class NGOFoodInfocard extends StatelessWidget {
//   final String donationId;
//   final Donation donation;
//   NGOFoodInfocard({Key? key, required this.donationId, required this.donation})
//       : super(key: key);

//   List<dynamic>? selectedDonationList; //Use it as a list of donation

//   // NGOFoodInfocardController ngoFoodInfocardController =
//   //     Get.put(NGOFoodInfocardController());

//   late DonationController donationController;

//   //Getting food supplier data
//   Future<Supplier> getSupplierData(String supplierId) async {
//     //
//     Supplier supplier;

//     var rawData = await FirebaseFirestore.instance
//         .collection(FirestoreServicesSupplier.supplierUsersCollection)
//         .doc(supplierId)
//         .get();

//     supplier = Supplier.fromDoucmentSnapshot(rawData);

//     return supplier;
//   }

//   @override
//   Widget build(BuildContext context) {
//     donationController = Get.put(DonationController(), tag: donationId);
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(FirebaseConstants.donationCollection)
//             .doc(donationId)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           //
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           //
//           Donation donation = Donation.fromDocumentSnapshot(snapshot.data);

//           if (!donationController.isTimerstarted) {
//             donationController.setDonationData(donation);
//           }

//           //Set donation in Controller
//           donationController.donation = donation;

//           //
          
//                 //
//                 print('Future builder rebuild for ${donation.mealNames}');

//                 return Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10, top: 12),
//                   child: Card(
//                     elevation: 0.4,
//                     shape: RoundedRectangleBorder(
//                       //borderRadius: BorderRadius.circular(5),
//                       side: BorderSide(
//                         color: Get.theme.colorScheme.onSecondary,
//                         width: 0.4,
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 6, bottom: 6),
//                       child: ListTile(
//                         leading: Container(
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                   color: Get.theme.colorScheme.primary)),
//                           child: CircleAvatar(
//                             radius: 30,
//                             backgroundImage:
//                                 NetworkImage(donation.supplierProfilrPicture),
//                           ),
//                         ),

//                         //
//                         title: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             //
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     AppText(
//                                       'Donation From',
//                                       size: 14,
//                                     ),
//                                     donation.supplierRole == 'Individual'
//                                         ? AppText(
//                                             donation.supplierName,
//                                             isBold: true,
//                                             textColor:
//                                                 Get.theme.colorScheme.primary,
//                                           )
//                                         : AppText(
//                                             donation.supplierRestaurantName,
//                                             isBold: true,
//                                             textColor:
//                                                 Get.theme.colorScheme.primary,
//                                           ),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     AppText(
//                                       DateTimeFormat.getFormatedDate(
//                                           donation.donationTime),
//                                       size: 14,
//                                       isBold: true,
//                                     ),
//                                     AppText(
//                                       DateTimeFormat.getFormatedTime(
//                                           donation.donationDate),
//                                       size: 13,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),

//                             //SizedBox(height: 16),

//                             const SizedBox(height: 4),

//                             Divider(),

//                             //
//                           ],
//                         ),

//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             AppText(
//                               donation.mealNames,
//                               isBold: true,
//                               size: 15,
//                             ),
//                             SizedBox(height: 8),

//                             //meal expiry time
//                             Row(
//                               children: [
//                                 Obx(() {
//                                   // print('timer ui caleld');
//                                   return donationController.mealExpired.value
//                                       ? AppText('Meal has expired')
//                                       : AppText(
//                                           'Meal expires in : ${donationController.hr.value} : ${donationController.mm.value} : ${donationController.ss.value}',
//                                           size: 14,
//                                         );
//                                 }),

//                                 // AppText(
//                                 //   '${donation.mealExpiryTime.toInt().toString()} min',
//                                 //   isBold: true,
//                                 //   size: 14,
//                                 // ),

//                                 //
//                               ],
//                             ),

//                             Row(
//                               children: [
//                                 AppText(
//                                   'Donation :',
//                                   size: 14,
//                                 ),
//                                 donation.donationStatus == 'Confirmed'
//                                     ? Row(
//                                         children: [
//                                           AppText(
//                                             '${donation.donationStatus}',
//                                             textColor:
//                                                 Colors.lightGreen.shade800,
//                                             isBold: true,
//                                             size: 14,
//                                           ),
//                                           SizedBox(width: 4),
//                                           Icon(
//                                             Icons.check_circle_outline,
//                                             size: 18,
//                                             color: Colors.lightGreen.shade800,
//                                           )
//                                         ],
//                                       )
//                                     : Row(
//                                         children: [
//                                           AppText(
//                                             '${donation.donationStatus}',
//                                             textColor: Colors.blue.shade700,
//                                             isBold: true,
//                                             size: 14,
//                                           ),
//                                           SizedBox(width: 4),
//                                           Icon(
//                                             Icons.pending_outlined,
//                                             size: 18,
//                                             color: Colors.blue.shade700,
//                                           )
//                                         ],
//                                       ),
//                               ],
//                             ),
//                             //SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Get.to(FoodDetailsScreen(
//                                       donation: donation,
//                                       name: donation.supplierName,
//                                       phoneNumber: donation.supplierMobileNumber,
//                                     ));
//                                   },
//                                   child: Container(
//                                     child: donation.donationStatus == 'Pending'
//                                         ? Row(children: [
//                                             AppText(
//                                               'Get Details',
//                                               isBold: true,
//                                               size: 15,
//                                               textColor:
//                                                   Get.theme.colorScheme.primary,
//                                             ),
//                                             SizedBox(width: 4),
//                                             Icon(
//                                               Icons.arrow_forward,
//                                               size: 16,
//                                               color:
//                                                   Get.theme.colorScheme.primary,
//                                             )
//                                           ])
//                                         : Container(),
//                                   ),
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               });
        
//   }
// }
