import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/controllers/supplier_controllers/donate_food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/donation.dart';
import '../../../models/ngo_head.dart';
import '../../../services/date_time_format.dart';
import '../../../services/firestore_services_ngo.dart';
import '../../../widgets/app_text.dart';

class HistoryDetailsScreen extends StatelessWidget {
  final Donation donation;
  //final NGOHead ngoHead;
  HistoryDetailsScreen({
    Key? key,
    required this.donation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Get.theme.colorScheme.primary,
            size: 34,
          ),
          title: AppText(
            'Donation Details',
            textType: TextType.large,
            isBold: true,
            textColor: Get.theme.colorScheme.primary,
          ),
          elevation: 0,
          backgroundColor: Get.theme.colorScheme.background,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        donation.donationStatus == 'Done'
                            ? Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Get.theme.colorScheme.primary,
                                      width: 1,
                                    )),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(donation.ngoProfilePicture),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // border: Border.all(
                                  //   color: Get.theme.colorScheme.primary,
                                  //   width: 1,
                                  // ),
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('images/cross3.jpg'),
                                ),
                              ),
                        SizedBox(width: 16),
                        donation.donationStatus == 'Done'
                            ? AppText(
                                'Donated to ${donation.ngoOrganizationName}',
                                isBold: true,
                              )
                            : AppText(
                                'Meal has Expired',
                                isBold: true,
                              ),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                      'Donation Details',
                      isBold: true,
                    ),
                  ),
                  SizedBox(height: 6),
                  Column(
                    children: [
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
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        donation.foodImage,
                                      ))),
                            ),
                      SizedBox(height: 6),
                      AppText(
                        donation.mealNames,
                        isBold: true,
                        size: 16,
                      ),
                      SizedBox(height: 8),
                      AppText(
                        donation.description,
                        isLightShade: true,
                        textAlign: TextAlign.center,
                        size: 14,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // SizedBox(height: 16),
                  // Row(
                  //   children: [
                  //     Container(
                  //       height: 40,
                  //       width: 150,
                  //       decoration: BoxDecoration(
                  //         color: Colors.grey.shade200,
                  //         borderRadius: BorderRadius.circular(15),
                  //       ),
                  //       child: Align(
                  //         alignment: Alignment.center,
                  //         child: AppText(
                  //           donation.mealCategory,
                  //           isBold: true,
                  //           size: 15,
                  //           //textColor: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 16),
                  //     Container(
                  //       height: 40,
                  //       width: 160,
                  //       decoration: BoxDecoration(
                  //         color: Colors.grey.shade200,
                  //         borderRadius: BorderRadius.circular(15),
                  //       ),
                  //       child: Align(
                  //         alignment: Alignment.center,
                  //         child: AppText(
                  //           donation.mealPackaging,
                  //           isBold: true,
                  //           size: 15,
                  //           //textColor: Colors.white,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   height: 40,
                        //   width: 140,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey.shade200,
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   child: Align(
                        //     alignment: Alignment.center,
                        //     child: AppText(
                        //       ' ${donation.mealQuantity.toInt().toString()} Persons',
                        //       isBold: true,
                        //       size: 15,
                        //       //textColor: Colors.white,
                        //     ),
                        //   ),
                        // ),
                        AppText(
                          'Meal Quantity           : ${donation.mealQuantity.toInt()}',
                          size: 15,
                          isBold: true,
                        ),
                        SizedBox(height: 6),
                        AppText(
                          'Meal Type                 : ${donation.mealType}',
                          size: 15,
                          isBold: true,
                        ),
                        SizedBox(height: 6),
                        AppText(
                          'Meal Category          : ${donation.mealCategory}',
                          size: 15,
                          isBold: true,
                        ),
                        SizedBox(height: 6),
                        AppText(
                          'Meal Packaging       : ${donation.mealPackaging}',
                          size: 15,
                          isBold: true,
                        ),
                        //SizedBox(height: 6),
                        // Container(
                        //   height: 40,
                        //   width: 120,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey.shade200,
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   child: Align(
                        //     alignment: Alignment.center,
                        //     child: AppText(
                        //       donation.mealType,
                        //       isBold: true,
                        //       size: 15,
                        //       //textColor: Colors.white,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: AppText(
                  //     'Donation Location',
                  //     isBold: true,
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  Row(children: [
                    Icon(
                      Icons.location_on,
                      size: 22,
                      color: Get.theme.colorScheme.primary,
                    ),
                    SizedBox(width: 8),
                    AppText(
                      donation.donationAddress,
                      size: 15,
                    )
                  ]),
                  // SizedBox(height: 32),
                  // donation.donationStatus == 'Done'
                  //     ? Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: AppText(
                  //           'Donation Flow',
                  //           isBold: true,
                  //         ),
                  //       )
                  //     : Container(),
                  SizedBox(height: 8),
                  donation.donationStatus == 'Done' ? Divider() : Container(),
                  SizedBox(height: 8),
                  donation.donationStatus == 'Done'
                      ?

                      //
                      Padding(
                          padding: const EdgeInsets.only(left: 32, top: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height: 220,
                                    width: 2,
                                    color: Colors.orange,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.linear_scale_rounded,
                                          color: Get.theme.colorScheme.primary,
                                        ),
                                        Icon(
                                          Icons.linear_scale_rounded,
                                          color: Get.theme.colorScheme.primary,
                                        ),
                                        Icon(
                                          Icons.linear_scale_rounded,
                                          color: Get.theme.colorScheme.primary,
                                        ),
                                      ],
                                    )),
                                SizedBox(width: 32),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppText(
                                      'Food donated on',
                                      isBold: true,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppText(
                                          DateTimeFormat.getFormatedDate(
                                            donation.donationDate,
                                          ),
                                          size: 13,
                                        ),
                                        AppText(
                                          ', ${DateTimeFormat.getFormatedTime(
                                            donation.donationTime,
                                          )}',
                                          size: 13,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 60),
                                    AppText(
                                      'Donation Accepted by',
                                      isBold: true,
                                    ),
                                    AppText(
                                      donation.ngoOrganizationName,
                                      size: 14,
                                    ),
                                    SizedBox(height: 60),
                                    AppText(
                                      'Donation Completed on',
                                      isBold: true,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppText(
                                          DateTimeFormat.getFormatedDate(
                                            donation.donationCompleteDate,
                                          ),
                                          size: 13,
                                        ),
                                        AppText(
                                          ', ${DateTimeFormat.getFormatedTime(
                                            donation.donationCompleteTime,
                                          )}',
                                          size: 13,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 60),
                              ]))
                      : Container(),
                ]))));
  }
}
