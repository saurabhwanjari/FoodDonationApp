import 'package:cloud_firestore/cloud_firestore.dart';

class NGOHead {
  //
  late String documentId;
  late String name;
  late String organizationName;
  late String peopleInOrganization;
  late String ngoCertificationNumber;
  late String campaignsDone;
  late String eventsDone;
  late String getFoodFromSupplier;
  //late String latitude;
  //late String longitude;
  late String address;
  late String cityName;
  late String description;
  late String gender;
  late String profilePicture;
  late String mobileNumber;

  //
  NGOHead.blankUser();
  //
  NGOHead ({
    required this.name,
    required this.organizationName,
    required this.peopleInOrganization,
    required this.ngoCertificationNumber,
    required this.campaignsDone,
    required this.eventsDone,
    required this.getFoodFromSupplier,
    //required this.latitude,
    //required this.longitude,
    required this.address,
    required this.cityName,
    required this.description,
    required this.gender,
    required this.profilePicture,
    required this.mobileNumber,
  });

  //
  NGOHead.fromDoucmentSnapshot(DocumentSnapshot documentSnapshot) {
    //
    documentId = documentSnapshot.id;
    name = documentSnapshot['name'];
    organizationName = documentSnapshot['organizationName'];
    peopleInOrganization = documentSnapshot['peopleInOrganization'];
    ngoCertificationNumber = documentSnapshot['ngoCertificationNumber'];
    campaignsDone = documentSnapshot['campaignsDone'];
    eventsDone = documentSnapshot['eventsDone'];
    getFoodFromSupplier = documentSnapshot['getFoodFromSupplier'];
    //latitude = documentSnapshot['latitude'];
    //longitude = documentSnapshot['longitude'];
    address = documentSnapshot['address'];
    cityName = documentSnapshot['cityName'];
    description = documentSnapshot['description'];
    gender = documentSnapshot['gender'];
    profilePicture = documentSnapshot['profilePicture'];
    mobileNumber = documentSnapshot['mobileNumber'];
  }

  //
  Map<String, dynamic> toMap() {
    //
    Map<String, dynamic> map = <String, dynamic>{};

    map['name'] = name;
    map['organizationName'] = organizationName;
    map['peopleInOrganization'] = peopleInOrganization;
    map['ngoCertificationNumber'] = ngoCertificationNumber;
    map['campaignsDone'] = campaignsDone;
    map['eventsDone'] = eventsDone;
    map['getFoodFromSupplier'] = getFoodFromSupplier;
    //map['latitude'] = latitude;
    //map['longitude'] = longitude;
    map['address'] = address;
    map['cityName'] = cityName;
    map['description'] = description;
    map['gender'] = gender;
    map['profilePicture'] = profilePicture;
    map['mobileNumber'] = mobileNumber;

    return map;
  }
}


