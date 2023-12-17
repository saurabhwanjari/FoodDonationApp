import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/constants/firebase_constants.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/models/donation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreenController extends GetxController {
  NGODataController ngoDataController = Get.find<NGODataController>();
  //
  void onConfirmDonation(Donation donation) {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection(FirebaseConstants.donationCollection)
          .doc(donation.documentId)
          .update({
        'donationStatus': 'Confirmed',
        'ngoOrganizationName': ngoDataController.ngoHead.organizationName,
        'ngoDescription': ngoDataController.ngoHead.description,
        'ngoProfilePicture': ngoDataController.ngoHead.profilePicture,
        'ngoId': ngoDataController.ngoHead.documentId,
      });
    } catch (error) {
      print(error);
    }
  }

  void onRejectDonation(Donation donation) {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection(FirebaseConstants.donationCollection)
          .doc(donation.documentId)
          .update({
        'donationStatus': 'Pending',
        'ngoOrganizationName': '',
        'ngoDescription': '',
        'ngoProfilePicture': '',
        'ngoId': '',
      });
    } catch (error) {
      print(error);
    }
  }

  void onGetLocation(Donation donation) {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection(FirebaseConstants.donationCollection)
          .doc(donation.documentId)
          .update({
        'ngoOrganizationName': ngoDataController.ngoHead.organizationName,
        'ngoDescription': ngoDataController.ngoHead.description,
        'ngoProfilePicture': ngoDataController.ngoHead.profilePicture,
      });
    } catch (error) {
      print(error);
    }
  }
}
