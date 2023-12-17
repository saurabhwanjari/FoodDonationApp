import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/services/firestore_services_supplier.dart';
import 'package:donation_app/models/supplier.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterSupplier {
  //
  Future<bool> registerSupplier(Supplier supplier) async {
    //
    try {
      //
      FirebaseFirestore firebaseFirestore = FirestoreServicesSupplier.firebaseFirestore;

      //

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.reload();
        String userId = user.uid;

        //
        await firebaseFirestore
            .collection(FirestoreServicesSupplier.supplierUsersCollection)
            .doc(userId)
            .set(supplier.toMap());

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