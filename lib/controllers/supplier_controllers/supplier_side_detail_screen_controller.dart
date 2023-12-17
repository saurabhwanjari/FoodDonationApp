import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/constants/firebase_constants.dart';
import 'package:donation_app/models/donation.dart';
import 'package:get/get.dart';

class SupplierSideDetailScreenController extends GetxController {
  //
  Future<void> onNGOPickedDonation(Donation donation) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection(FirebaseConstants.donationCollection)
          .doc(donation.documentId)
          .update({
        'donationStatus': 'Done',
        'donationCompleteTime': DateTime.now(),
        'donationCompleteDate': DateTime.now(),
      });
    } catch (error) {
      print(error);
    }
  }
}
