import 'package:cloud_firestore/cloud_firestore.dart';

final List<String> mealTypes = [
  'Breakfast',
  'Lunch',
  'Dinner',
];

//
final List<String> mealCategories = [
  'Veg',
  ' Veg & Non-Veg',
];

final List<String> getLocationsList = [
  'Get My Location',
];

//
final List<String> mealPackaging = [
  'Plastic Containers',
  'Cooking Pods',
  'Loose Packages',
  'Meal Box',
  'None'
];

//
final List<String> donationReasons = [
  'Charity',
  'Left Food',
];

//field to be added later
// final List<String> deliveryType = [
//   'We will deliver',
//   'Picked by NGO',
// ];

class DonationStatus {
  static const String pending = 'Pending';
  static const String confirmed = 'Confirmed';
  static const String done = 'Done';
  static const String expired = 'Expired';
}

class Donation {
  //

  late String documentId;
  late String mealNames;
  late String description;
  late String mealType;
  late String mealCategory;
  late String mealPackaging;
  late String donationCityName;
  late String donationReason;
  late String donationAddress;
  late String foodImage;
  late double mealQuantity;
  late int mealExpiryTime;
  late Timestamp donationTime;
  late Timestamp donationDate;
  late String latitude;
  late String longitude;
  late String donationStatus;
  late String ngoOrganizationName;
  late String ngoDescription;
  late String ngoProfilePicture;
  late Timestamp donationCompleteTime;
  late Timestamp donationCompleteDate;
  late String supplierName;
  late String supplierProfilrPicture;
  late String supplierRole;
  late String supplierMobileNumber;
  late String supplierRestaurantName;
  //late String mealPreparationTime;

  // supplier id taken from firestore to identify the supplier of particular food
  late String supplierId;
  late String ngoId;

  //
  Donation({
    required this.mealNames,
    required this.description,
    required this.mealType,
    required this.mealCategory,
    required this.mealPackaging,
    required this.donationCityName,
    required this.supplierId,
    required this.ngoId,
    required this.donationReason,
    required this.donationAddress,
    required this.mealQuantity,
    required this.mealExpiryTime,
    required this.latitude,
    required this.longitude,
    required this.ngoOrganizationName,
    required this.ngoDescription,
    required this.ngoProfilePicture,
    required this.supplierName,
    required this.supplierProfilrPicture,
    required this.supplierRole,
    required this.supplierMobileNumber,
    required this.supplierRestaurantName,
    //required this.donationCompleteTime,
    //required this.donationCompleteDate,
    //required this.mealPreparationTime,
    //this.donationTime,
    this.foodImage =
        'https://firebasestorage.googleapis.com/v0/b/donation-app-94611.appspot.com/o/foodPictures%2Fdefault_food.jpg?alt=media&token=1e584c2e-0823-47bf-8355-bbe5572662de',
  });

  // //
  Donation.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    //
    documentId = documentSnapshot.id;

    mealNames = documentSnapshot['mealNames'];
    description = documentSnapshot['description'];
    mealType = documentSnapshot['mealType'];
    mealCategory = documentSnapshot['mealCategory'];
    mealPackaging = documentSnapshot['mealPackaging'];
    donationCityName = documentSnapshot['donationCityName'];
    foodImage = documentSnapshot['foodImage'];
    donationReason = documentSnapshot['donationReason'];
    donationAddress = documentSnapshot['donationAddress'];
    mealQuantity = documentSnapshot['mealQuantity'];
    mealExpiryTime = documentSnapshot['mealExpiryTime'].toInt();
    donationTime = documentSnapshot['donationTime'];
    donationDate = documentSnapshot['donationDate'];
    latitude = documentSnapshot['latitude'];
    longitude = documentSnapshot['longitude'];
    donationStatus = documentSnapshot['donationStatus'];
    ngoOrganizationName = documentSnapshot['ngoOrganizationName'];
    ngoDescription = documentSnapshot['ngoDescription'];
    ngoProfilePicture = documentSnapshot['ngoProfilePicture'];
    donationCompleteTime = documentSnapshot['donationCompleteTime'];

    donationCompleteDate = documentSnapshot['donationCompleteDate'];
    supplierName = documentSnapshot['supplierName'];
    supplierProfilrPicture = documentSnapshot['supplierProfilrPicture'];
    supplierRole = documentSnapshot['supplierRole'];
    supplierMobileNumber = documentSnapshot['supplierMobileNumber'];
    supplierRestaurantName = documentSnapshot['supplierRestaurantName'];
    //mealPreparationTime = documentSnapshot['mealPreparationTime'];
    supplierId = documentSnapshot['supplierId'];
    ngoId = documentSnapshot['ngoId'];
  }

  // //
  Map<String, dynamic> toMap({Donation? oldDonation}) {
    //
    Map<String, dynamic> map = {};

    print('oldDonation = $oldDonation');
    

    if (oldDonation != null) {
      map['donationTime'] = oldDonation.donationTime;
      map['donationDate'] = oldDonation.donationDate;
    } else {
      map['donationTime'] = DateTime.now();
      map['donationDate'] = DateTime.now();
    }

    map['mealNames'] = mealNames;
    map['description'] = description;
    map['mealType'] = mealType;
    map['mealCategory'] = mealCategory;
    map['mealPackaging'] = mealPackaging;
    map['donationCityName'] = donationCityName;
    map['foodImage'] = foodImage;
    map['donationReason'] = donationReason;
    map['donationAddress'] = donationAddress;
    map['mealQuantity'] = mealQuantity;
    map['mealExpiryTime'] = mealExpiryTime;
    map['supplierId'] = supplierId;
    map['ngoId'] = ngoId;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['ngoOrganizationName'] = ngoOrganizationName;
    map['ngoDescription'] = ngoDescription;
    map['ngoProfilePicture'] = ngoProfilePicture;
    map['supplierName'] = supplierName;
    map['supplierProfilrPicture'] = supplierProfilrPicture;
    map['supplierRole'] = supplierRole;
    map['supplierMobileNumber'] = supplierMobileNumber;
    map['supplierRestaurantName'] = supplierRestaurantName;
    map['donationCompleteTime'] = DateTime.now();
    ;
    map['donationCompleteDate'] = DateTime.now();
    ;
    map['donationStatus'] = DonationStatus.pending;
    //map['mealPreparationTime'] = mealPreparationTime;
    return map;
  }

  //

}
