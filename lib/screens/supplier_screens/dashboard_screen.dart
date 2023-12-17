import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/constants/firebase_constants.dart';
import 'package:donation_app/controllers/supplier_controllers/supplier_data_controller.dart';
import 'package:donation_app/models/donation.dart';
import 'package:donation_app/screens/supplier_screens/donation/add_donation_form.dart';
import 'package:donation_app/widgets/supplier_app_drawer.dart';
import 'package:donation_app/widgets/supplier_food_infocard.dart';
import 'package:flutter/material.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:get/get.dart';

import '../../controllers/supplier_controllers/donate_food_controller.dart';
import '../../services/date_time_format.dart';

class DashboardScreen extends StatelessWidget {
  //
  DashboardScreen({Key? key}) : super(key: key);
  SupplierDataController supplierDataController =
      Get.find<SupplierDataController>();

  final DonateFoodController donateFoodController =
      Get.put(DonateFoodController());

  //
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    Timestamp tsDate = Timestamp.fromDate(date);
    String datetime = DateTimeFormat.getFormatedDate(tsDate);
    print(tsDate);
    print(datetime);

    //
    return Scaffold(
      //
      drawer: Container(
        width: Get.width * 0.7,
        height: double.infinity,
        color: Get.theme.colorScheme.surface,
        child: SupplierAppDrawer(),
      ),

      //
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Get.theme.colorScheme.primary,
          size: 34,
        ),
        title: Container(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //
              AppText(
                '${supplierDataController.rxSupplier.value.suppliername}',
                //'Savita',
                textType: TextType.large,
              ),
              //
              AppText(
                'Food Supplier',
                textType: TextType.small,
                isLightShade: true,
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Get.theme.colorScheme.background,
      ),

      //
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.donationCollection)
            .where('supplierId',
                isEqualTo: supplierDataController.supplier.documentId)
            .where('donationStatus',
                whereIn: ['Pending', 'Confirmed', 'Done', 'Expired'])
            .orderBy('donationTime', descending: true)
            .snapshots(),

        //
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          //            print('showing donation ${asyncSnapshot.data.docs.length}');
          if (!asyncSnapshot.hasData) {
            //if no donation is available
            return NoDonationBox();
          }
          if (asyncSnapshot.data.docs.length == 0) {
            //print('showing donation');
            return NoDonationBox();
          }

          bool showDonation = false;

          for (int i = 0; i < asyncSnapshot.data.docs.length; i++) {
            Donation donation =
                Donation.fromDocumentSnapshot(asyncSnapshot.data.docs[i]);
            if (datetime ==
                DateTimeFormat.getFormatedDate(donation.donationDate)) {
              showDonation = true;
              break;
            }
          }

          return !showDonation
              ? NoDonationBox()
              : ListView.builder(
                  //
                  itemCount: asyncSnapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    Donation donation = Donation.fromDocumentSnapshot(
                        asyncSnapshot.data.docs[index]);
                    if (datetime ==
                        DateTimeFormat.getFormatedDate(donation.donationDate)) {
                      return SupplierFoodInfoCard(donation: donation);
                    } else {
                      print('Length = ${asyncSnapshot.data.docs.length}');
                      return Container();
                    }
                  },
                );
        },
      ),

      //

      //
      floatingActionButton: FloatingActionButton.extended(
        label: AppText(
          'Donate Food',
          textColor: Get.theme.colorScheme.onPrimary,
        ),

        //
        onPressed: () {
          Get.to(() => AddDonationForm());
        },

        //
        backgroundColor: Get.theme.colorScheme.primary,

        //
        elevation: 0.5,
      ),
    );

    //
  }
}

class NoDonationBox extends StatelessWidget {
  const NoDonationBox({
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
          'No Donation!',
          isBold: true,
          textType: TextType.large,
          textAlign: TextAlign.center,
        ),
        //
        SizedBox(height: 6),

        //
        AppText(
          'You haven\'t made any donated food today',
          //textType: TextType.small,
          textAlign: TextAlign.center,
          isLightShade: true,
        )
      ],
    );
  }
}
