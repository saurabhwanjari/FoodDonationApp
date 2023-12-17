import 'package:cloud_firestore/cloud_firestore.dart';

class HotelUser {
  //
  late String documentId;
  late String name;
  late String hotelName;
  late String hotelAddress;

  final String role = 'Hotel Owner';
  late String gender;
  late String foodCategory;
  late String profilePicture;

  //
  HotelUser({
    required this.name,
    required this.hotelName,
    required this.hotelAddress,
    required this.gender,
    required this.foodCategory,
    required this.profilePicture,
  });

  //
  HotelUser.fromDoucmentSnapshot(DocumentSnapshot documentSnapshot) {
    //
    documentId = documentSnapshot.id;
    name = documentSnapshot['name'];
    hotelName = documentSnapshot['hotelName'];
    hotelAddress = documentSnapshot['hotelAddress'];
    gender = documentSnapshot['gender'];
    foodCategory = documentSnapshot['foodCategory'];
    profilePicture = documentSnapshot['profilePicture'];
  }

  //
  Map<String, dynamic> toMap() {
    //
    Map<String, dynamic> map = <String, dynamic>{};

    map['name'] = name;
    map['hotelName'] = hotelName;
    map['hotelAddress'] = hotelAddress;
    map['gender'] = gender;
    map['foodCategory'] = foodCategory;
    map['profilePicture'] = profilePicture;

    return map;
  }
}
