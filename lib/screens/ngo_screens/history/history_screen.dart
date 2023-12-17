import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:donation_app/widgets/ngo_history_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/firebase_constants.dart';
import '../../../models/donation.dart';
import '../../../services/date_time_format.dart';
import '../../../widgets/ngo_food_infocard.dart';
import 'package:grouped_list/grouped_list.dart';

class HistorySCreen extends StatelessWidget {
  late BuildContext appContext;
  HistorySCreen({Key? key}) : super(key: key);

  
  //Alert Exit Confirm Function
  Future<bool> exitConfirm() async {
    Future<bool> value = Future.value(false);

    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      title: AppText(
        'Are your sure to exit?',
        isBold: true,
        textAlign: TextAlign.center,
        size: 20,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Yes
            Container(
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Get.theme.colorScheme.primary, width: 1),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(appContext);
                  value = Future.value(true);
                },
                child: AppText(
                  "Yes",
                  textType: TextType.normal,
                  isBold: true,
                  textColor: Get.theme.colorScheme.primary,
                ),
              ),
            ),

            //No
            Container(
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Get.theme.colorScheme.primary, width: 1),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(appContext);
                  value = Future.value(false);
                },
                child: AppText(
                  "No",
                  textType: TextType.normal,
                  isBold: true,
                  textColor: Get.theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        )
      ],
    );

    await showDialog(
        context: appContext, builder: (BuildContext context) => alertDialog);

    return value;
  }

  NGODataController ngoDataController = Get.find<NGODataController>();

  @override
  Widget build(BuildContext context) {
    appContext = context;
    
    return WillPopScope(
      onWillPop: exitConfirm,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Get.theme.colorScheme.primary,
            size: 34,
          ),
          title: AppText(
            'History',
            isBold: true,
            textType: TextType.large,
            textColor: Get.theme.colorScheme.primary,
          ),
          elevation: 0,
          backgroundColor: Get.theme.colorScheme.background,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirebaseConstants.donationCollection)
              .where('donationStatus', whereIn: ['Done'])
              .where('ngoId', isEqualTo: ngoDataController.ngoHead.documentId)
              .orderBy('donationCompleteTime', descending: true)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //
            if (!snapshot.hasData) {
              return NoHistory();
            }
    
            if (snapshot.data.docs.length == 0) {
              return NoHistory();
            }
    
            // return ListView.builder(
            //   itemCount: snapshot.data.docs.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     Donation donation =
            //         Donation.fromDocumentSnapshot(snapshot.data.docs[index]);
            //     return NGOHistoryCard(
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
                  DateTimeFormat.getFormatedDate(element['donationCompleteDate']),
    
              //
              groupHeaderBuilder: (element) {
                String donationCompleteDate = DateTimeFormat.getFormatedDate(
                    element['donationCompleteDate']);
    
                //
                String dateToday =
                    DateTimeFormat.getFormatedDate(Timestamp.now());
    
                //
                String heading = donationCompleteDate == dateToday
                    ? 'Today'
                    : donationCompleteDate;
    
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
    
                Donation donation = Donation.fromDocumentSnapshot(singleElement);
                return NGOHistoryCard(
                    donationId: donation.documentId, donation: donation);
              },
            );
          },
        ),
      ),
    );
  }
}

class NoHistory extends StatelessWidget {
  const NoHistory({
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
          'images/history1.png',
          width: 80,
          height: 80,
          color: Get.theme.colorScheme.primary,
        ),

        //
        SizedBox(height: 24),

        //
        AppText(
          'No History Available!',
          isBold: true,
          textType: TextType.large,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
