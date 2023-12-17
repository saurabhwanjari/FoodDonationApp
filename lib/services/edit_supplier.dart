import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/services/firestore_services_ngo.dart';
import 'package:donation_app/services/firestore_services_supplier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/supplier.dart';

class EditSupplier {
  //
  Future<bool> editSupplier(Supplier supplier) async {
    //
    try {
      // creating firebaseFirestore instance
      FirebaseFirestore firebaseFirestore =
          FirestoreServicesSupplier.firebaseFirestore;

      // getting current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // if current user is there then add data to firebase
        await user.reload();
        String userId = user.uid;

        //
        await firebaseFirestore
            .collection(FirestoreServicesSupplier.supplierUsersCollection)
            .doc(userId)
            .update(supplier.toMap());

        await user.reload();

        return true;
      } else {
        //...
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
