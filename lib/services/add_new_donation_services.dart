import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/controllers/supplier_controllers/donate_food_controller.dart';
import 'package:donation_app/models/donation.dart';

import '../constants/firebase_constants.dart';

class AddNewDonationServices {
  ///
  Future<void> addMenuToFirestore(Donation donation) async {
    try {
      //
      FirebaseFirestore.instance
          .collection(FirebaseConstants.donationCollection)
          .add(donation.toMap());
    } catch (error) {
      print('error: $error');
    }
  }

  //
  Future<void> updateDonationToFirestore(Donation donation) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.donationCollection)
          .doc(donation.documentId)
          .delete();

      print('updation start ${donation.donationTime}');

      //
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.donationCollection)
          .add(donation.toMap(oldDonation: donation));

      print('updation end');
    } catch (error) {
      print('error: $error');
    }
  }

  //
  Future<void> deleteDonationFromFirestore(Donation donation) async {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseConstants.donationCollection)
          .doc(donation.documentId)
          .delete();
    } catch (error) {
      print('error: $error');
    }
  }
}
