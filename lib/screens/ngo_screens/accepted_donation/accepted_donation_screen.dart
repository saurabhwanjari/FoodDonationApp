import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../constants/firebase_constants.dart';
import '../../../controllers/ngo_controllers/ngo_data_controller.dart';
import '../../../models/donation.dart';
import '../../../services/date_time_format.dart';
import '../../../widgets/accept_donation_card.dart';
import '../../../widgets/ngo_food_infocard.dart';

class AcceptedDonationScreen extends StatelessWidget {
  AcceptedDonationScreen({Key? key}) : super(key: key);
  NGODataController ngoDataController = Get.find<NGODataController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Get.theme.colorScheme.primary,
            size: 34,
          ),
          title: AppText(
            'Accepted Donation',
            textType: TextType.large,
            textColor: Get.theme.colorScheme.primary,
            isBold: true,
          ),
          elevation: 0,
          backgroundColor: Get.theme.colorScheme.background,
        ),

        //
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(FirebaseConstants.donationCollection)
                .where('donationStatus', whereIn: ['Confirmed'])
                .where('ngoId', isEqualTo: ngoDataController.ngoHead.documentId)
                .orderBy('donationTime', descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //
              if (!snapshot.hasData) {
                return NoAcceptedDonation();
              }

              if (snapshot.data.docs.length == 0) {
                return NoAcceptedDonation();
              }

              // return ListView.builder(
              //   itemCount: snapshot.data.docs.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     Donation donation =
              //         Donation.fromDocumentSnapshot(snapshot.data.docs[index]);
              //     return AcceptDonationCard(
              //         donationId: donation.documentId, donation: donation);
              //   },
              // );

              return GroupedListView<dynamic, String>(
                // compare date so that today will occure at top
                //
                groupComparator: (String d1, String d2) {
                  List<String> date1Data = d1.split('-');
                  List<String> date2Data = d2.split('-');

                  DateTime date1 = DateTime(int.parse(date1Data[2]),
                      int.parse(date1Data[1]), int.parse(date1Data[0]));

                  DateTime date2 = DateTime(int.parse(date2Data[2]),
                      int.parse(date2Data[1]), int.parse(date2Data[0]));

                  return date2.compareTo(date1);
                },

                //
                elements: snapshot.data.docs,

                //
                groupBy: (element) =>
                    DateTimeFormat.getFormatedDate(element['donationDate']),

                //
                groupHeaderBuilder: (element) {
                  String donationDate =
                      DateTimeFormat.getFormatedDate(element['donationDate']);

                  //
                  String dateToday =
                      DateTimeFormat.getFormatedDate(Timestamp.now());

                  //
                  String heading =
                      donationDate == dateToday ? 'Today' : donationDate;

                  //
                  return Container(
                    padding: EdgeInsets.only(left: 16, top: 8),
                    child: AppText(
                      heading,
                      textType: TextType.small,
                      isBold: true,
                    ),
                  );
                },

                //
                indexedItemBuilder:
                    (BuildContext context, dynamic singleElement, int index) {
                  // Donation donation =
                  //     Donation.fromDocumentSnapshot(snapshot.data.docs[index]);
                  // return NGOHistoryCard(
                  //     donationId: donation.documentId, donation: donation);

                  Donation donation =
                      Donation.fromDocumentSnapshot(singleElement);
                  return AcceptDonationCard(
                      donationId: donation.documentId, donation: donation);
                },
              );
            }));
  }
}

class NoAcceptedDonation extends StatelessWidget {
  const NoAcceptedDonation({
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
          'images/not_accepted.png',
          width: 100,
          height: 100,
          color: Get.theme.colorScheme.primary,
        ),

        //
        SizedBox(height: 16),

        //
        AppText(
          'No Donation Accepted Today!',
          isBold: true,
          textType: TextType.large,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
