import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/services/firestore_services_ngo.dart';
import 'package:donation_app/models/ngo_head.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterNGO {
  //
  Future<bool> registerNGO(NGOHead ngoHead) async {
    //
    try {
      //
      FirebaseFirestore firebaseFirestore = FirestoreServicesNGO.firebaseFirestore;

      //

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.reload();
        String userId = user.uid;

        //
        await firebaseFirestore
            .collection(FirestoreServicesNGO.ngoUsersCollection)
            .doc(userId)
            .set(ngoHead.toMap());

        return true;
      } else {
        //...
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }
}