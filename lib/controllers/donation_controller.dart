import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/constants/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/donation.dart';

class DonationController extends GetxController {
  //
  Donation? donation;
  var hr = 0.obs;
  var mm = 0.obs;
  var ss = 0.obs;
  var mealExpired = false.obs;
  bool isTimerstarted = false;

  Timer? mealExpiryTimer;

  //
  Future<void> onConfirmDonation() async {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseConstants.donationCollection)
          .doc(donation!.documentId)
          .update({'donationStatus': DonationStatus.confirmed});
    } catch (error) {
      print(error);
    }
  }

  //
  Future<void> onDistributeDonation() async {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseConstants.donationCollection)
          .doc(donation!.documentId)
          .update({'donationStatus': DonationStatus.done});
    } catch (error) {
      print(error);
    }
  }

  // //
  // Future<void> onExpiredDonation() async {
  //   try {
  //     FirebaseFirestore.instance
  //         .collection(FirebaseConstants.donationCollection)
  //         .doc(donation!.documentId)
  //         .update({'donationStatus': DonationStatus.expired});
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  //
  var remainingTime = 0.obs;

  //
  @override
  void onInit() {
    super.onInit();
  }

  void setDonationData(Donation donation) {
    print('setDonationDatacalled');
    isTimerstarted = true;
    this.donation = donation;

    //
    DateTime donationDate = DateTime.fromMillisecondsSinceEpoch(
        donation.donationTime.millisecondsSinceEpoch);
    DateTime dateNow = DateTime.now();

    int timeDifferenSeconds = dateNow.difference(donationDate).inSeconds;

    remainingTime.value =
        donation.mealExpiryTime * 60 * 60 - timeDifferenSeconds;

    if (remainingTime.value <= 0) {
      mealExpired.value = true;
      return;
    }

    hr.value = remainingTime.value ~/ 3600;
    mm.value = (remainingTime.value % 3600) ~/ 60;

    ss.value = (remainingTime.value % 3600) % 60;

    if (!(donation.donationStatus == 'Done')) initTimmer();
  }

  void initTimmer() {
    mealExpiryTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      remainingTime.value = remainingTime.value - 1;
      hr.value = remainingTime.value ~/ 3600;
      mm.value = (remainingTime.value % 3600) ~/ 60;

      ss.value = (remainingTime.value % 3600) % 60;
      //    print('remainingTime ${donation!.mealName} = ${remainingTime.value}');

      if (remainingTime.value <= 0) {
        timer.cancel();
        mealExpiryTimer!.cancel();
        mealExpired.value = true;

        try {
          if (donation!.donationStatus != DonationStatus.done)
            FirebaseFirestore.instance
                .collection(FirebaseConstants.donationCollection)
                .doc(donation!.documentId)
                .update({'donationStatus': DonationStatus.expired});
        } catch (error) {
          print(error);
        }
      }
    });
  }
}
