import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/donation.dart';

class NGOFoodInfocardController extends GetxController {
  //
  late Donation donation;
  // late Timestamp donationTime ;
  // late int mealExpiryTime;
  var remainingTime = 0.obs;

  //
  @override
  void onInit() {
    super.onInit();
  }

  void setDonationData(Donation donation) {
    this.donation = donation;

    //
    DateTime donationDate = DateTime.fromMillisecondsSinceEpoch(
        donation.donationTime.millisecondsSinceEpoch);
    DateTime dateNow = DateTime.now();

    int timeDifferenMinutes = dateNow.difference(donationDate).inMinutes;

    remainingTime.value = donation.mealExpiryTime*60  - timeDifferenMinutes;

    initTimmer();

   // print('remainingTime= ${remainingTime.value}');
  }

  void initTimmer(){
    Timer.periodic(Duration(minutes: 1), (timer) {
      remainingTime.value  = remainingTime.value - 1;

      if(remainingTime.value <=0){
        timer.cancel();
      }
     });
  }
}
