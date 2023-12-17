import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/constants/firebase_constants.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_food_infocard_controller.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/widgets/ngo_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_home_page_controller.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:get/get.dart';
import 'package:donation_app/widgets/ngo_food_infocard.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../constants/app_colors.dart';
import '../../controllers/donation_controller.dart';
import '../../models/donation.dart';
import '../../services/date_time_format.dart';

class DashboardScreen extends StatelessWidget {
  //
  DashboardScreen({Key? key}) : super(key: key);

  //
  NGODataController ngoDataController = Get.find<NGODataController>();
  late DonationController donationController;

  //
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    Timestamp tsDate = Timestamp.fromDate(date);
    String datetime = DateTimeFormat.getFormatedDate(tsDate);
    print(tsDate);
    print(datetime);
    donationController = Get.put(
      DonationController(),
    );
    //
    return Scaffold(
      //
      drawer: Container(
        width: Get.width * 0.7,
        height: double.infinity,
        color: Get.theme.colorScheme.surface,
        child: NGOAppDrawer(),
      ),
      //
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Get.theme.colorScheme.primary,
          size: 34,
        ),
        title: Container(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //
                  AppText(
                    //'Savita Gavande',
                    ngoDataController.rxNGOHead.value.name,
                    textType: TextType.large,
                  ),
                  //
                  AppText(
                    'NGO, Serving the Nation',
                    textType: TextType.small,
                    isLightShade: true,
                  ),
                ],
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Get.theme.colorScheme.background,
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.donationCollection)
            .where('donationStatus', whereIn: ['Pending', 'Confirmed', 'Done'])
            //.where('ngoId', isEqualTo: ngoDataController.ngoHead.documentId)
            .orderBy('donationTime', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //
          if (!snapshot.hasData) {
            return NoDonation();
          }

          if (snapshot.data.docs.length == 0) {
            return NoDonation();
          }

          bool showDonation = false;

          for (int i = 0; i < snapshot.data.docs.length; i++) {
            Donation donation =
                Donation.fromDocumentSnapshot(snapshot.data.docs[i]);
            if (datetime ==
                DateTimeFormat.getFormatedDate(donation.donationDate)) {
              showDonation = true;
              break;
            }
          }

          return !showDonation
              ? NoDonation()
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    Donation donation = Donation.fromDocumentSnapshot(
                        snapshot.data.docs[index]);

                    if (donation.donationStatus != 'Pending') {
                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(FirebaseConstants.donationCollection)
                              .where('donationStatus',
                                  whereIn: ['Confirmed', 'Done'])
                              .where('ngoId',
                                  isEqualTo:
                                      ngoDataController.ngoHead.documentId)
                              .orderBy('donationTime', descending: true)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }

                            if (snapshot.data.docs.length == 0) {
                              return Container();
                            }
                            print('Inside');

                            if (donation.ngoId ==
                                ngoDataController.ngoHead.documentId) {
                              print('NGO ID = ${donation.ngoId}');
                              print(
                                  'NGO DATA CONTROLLER ID = ${ngoDataController.ngoHead.documentId}');

                              if (datetime ==
                                  DateTimeFormat.getFormatedDate(
                                      donation.donationDate)) {
                                return NGOFoodInfocard(
                                    donationId: donation.documentId,
                                    donation: donation);
                              } else {
                                return Container();
                              }
                            }

                            return Container();
                          });
                    }

                    // chek for meal expiery
                    DateTime donationDate = DateTime.fromMillisecondsSinceEpoch(
                        donation.donationTime.millisecondsSinceEpoch);
                    DateTime dateNow = DateTime.now();

                    int timeDifferenSeconds =
                        dateNow.difference(donationDate).inSeconds;

                    int remainingTime =
                        donation.mealExpiryTime * 60 * 60 - timeDifferenSeconds;

                    // remainingTime<= 0 ndicates food has expired
                    if (!(donation.donationStatus ==
                        'Done')) if (remainingTime <= 0) {
                      try {
                        FirebaseFirestore.instance
                            .collection(FirebaseConstants.donationCollection)
                            .doc(donation.documentId)
                            .update({
                          'donationStatus': DonationStatus.expired,
                        });
                      } catch (error) {
                        print(error);
                      }
                    }

                    return NGOFoodInfocard(
                        donationId: donation.documentId, donation: donation);
                    //return NoDonationBox();
                  });
        },
      ),
    );
  }
}

class NoDonation extends StatelessWidget {
  const NoDonation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //
        Image.asset(
          'images/f2.jpg',
          width: 80,
          height: 80,
        ),

        //
        SizedBox(height: 24),

        //
        AppText(
          'No Donation \n Available Today!',
          isBold: true,
          textType: TextType.large,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
