// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:donation_app/constants/firebase_constants.dart';
// import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
// import 'package:get/get.dart';
// import 'package:donation_app/models/donation.dart';
// import 'firestore_services_ngo.dart';

// class DonationServices {
//   final NGODataController ngoDataController = Get.find<NGODataController>();

//   //
//   Stream<List<Donation>> getDonationRequest() {
//     //
//     //String ngoId = ngoDataController.ngoHead.documentId;

//     //
//     Query query = FirestoreServicesNGO.firebaseFirestore
//         .collection(FirebaseConstants.donationCollection)
//         .where('donationStatus', isEqualTo: 'pending');

//     return query.snapshots().map((QuerySnapshot query) {
//       List<Donation> donationList = [];

//       //
//       for (var doc in query.docs) {
//         final Donation donation = Donation.fromDocumentSnapshot(doc);
//         donationList.add(donation);
//       }

//       //
//       return donationList;
//     });
//   }

//   //
//   void acceptDonationRequest(Donation donation) {
//     try {
//       FirestoreServicesNGO.firebaseFirestore
//           .collection(FirebaseConstants.donationCollection)
//           .doc(donation.documentId)
//           .update({'donationStatus': 'accepted'});
//     } catch (error) {
//       print(error);
//     }
//   }
// }
