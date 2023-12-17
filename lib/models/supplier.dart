import 'package:cloud_firestore/cloud_firestore.dart';

class Supplier {
  //
  late String documentId;

  late String suppliername;
  late String address;
  late String cityName;
  late String restaurantName;
  late String restaurantAddress;
  late String restaurantCity;
  late String supplierRole;
  late String gender;
  late String mealType;
  late String deliverFoodToNgo;
  late String profilePicture;
  // late String latitude;
  // late String longitude;
  late String description;
  late String liscenseNumber;
  late String mobileNumber;

  //
  Supplier.blankUser();

  //
  Supplier({
    required this.suppliername,
    required this.address,
    required this.cityName,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.restaurantCity,
    required this.supplierRole,
    required this.gender,
    required this.mealType,
    required this.deliverFoodToNgo,
    required this.profilePicture,
    // required this.latitude,
    // required this.longitude,
    required this.description,
    required this.liscenseNumber,
    required this.mobileNumber,
  });

  //
  Supplier.fromDoucmentSnapshot(DocumentSnapshot documentSnapshot) {
    //
    documentId = documentSnapshot.id;
    suppliername = documentSnapshot['suppliername'];
    address = documentSnapshot['address'];
    cityName = documentSnapshot['cityName'];
    restaurantName = documentSnapshot['restaurantName'];
    restaurantAddress = documentSnapshot['restaurantAddress'];
    restaurantCity = documentSnapshot['restaurantCity'];
    supplierRole = documentSnapshot['supplierRole'];
    gender = documentSnapshot['gender'];
    mealType = documentSnapshot['mealType'];
    deliverFoodToNgo = documentSnapshot['deliverFoodToNgo'];
    profilePicture = documentSnapshot['profilePicture'];
    // latitude = documentSnapshot['latitude'];
    // longitude = documentSnapshot['longitude'];
    description = documentSnapshot['description'];
    liscenseNumber = documentSnapshot['liscenseNumber'];
    mobileNumber = documentSnapshot['mobileNumber'];
  }

  //
  Map<String, dynamic> toMap() {
    //
    Map<String, dynamic> map = <String, dynamic>{};

    map['suppliername'] = suppliername;
    map['address'] = address;
    map['cityName'] = cityName;
    map['restaurantName'] = restaurantName;
    map['restaurantAddress'] = restaurantAddress;
    map['restaurantCity'] = restaurantCity;
    map['supplierRole'] = supplierRole;
    map['gender'] = gender;
    map['mealType'] = mealType;
    map['deliverFoodToNgo'] = deliverFoodToNgo;
    map['profilePicture'] = profilePicture;
    // map['latitude'] = latitude;
    // map['longitude'] = longitude;
    map['description'] = description;
    map['liscenseNumber'] = liscenseNumber;
    map['mobileNumber'] = mobileNumber;

    return map;
  }
}
