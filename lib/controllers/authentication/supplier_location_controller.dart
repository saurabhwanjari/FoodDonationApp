// import 'dart:async';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';

// class SupplierLocationController extends GetxController {
//   var latitude = 'Getting Latitude..'.obs;
//   var longitude = 'Getting Longitude..'.obs;
//   var address = 'Getting Address..'.obs;
//   late var position = ''.obs;

// void  getLocation() async {
//     //check location service is eanbled
//     bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

//     if (!isServiceEnabled) {
//       print('Device has no location service');
//       await Geolocator.requestPermission();
//     }

//     LocationPermission permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       await Geolocator.requestPermission();
//     }

//     Position currentPosition = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     // latitude = RxString(position.latitude.toString());
//     // longitude = RxString(position.longitude.toString());

//     latitude.value = currentPosition.latitude.toString();
//     longitude.value = currentPosition.longitude.toString();
//     print(latitude.value);
//     print(longitude.value);

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../screens/current_location.dart';

class LocationController extends GetxController {
  var tappedPoint = 0.obs;
  //List<Marker> myMarkers= [];
  RxList<Marker> myMarkers = RxList<Marker>([]);
  //
  //Rx<List<Marker>> myMarkers = Rx<List<Marker>>([]);
  handleTap(LatLng tappedPoint) {
    print(tappedPoint);
    myMarkers = RxList<Marker>([]);
    myMarkers.add(
      Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
            tappedPoint = dragEndPosition;
            //print(tappedPoint);
          }),
    );
  }

  void  getLocation() async {
    //check location service is eanbled
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      print('Device has no location service');
      await Geolocator.requestPermission();
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }

    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // latitude = RxString(position.latitude.toString());
    // longitude = RxString(position.longitude.toString());

    // latitude.value = currentPosition.latitude.toString();
    // longitude.value = currentPosition.longitude.toString();
    // print(latitude.value);
    // print(longitude.value);

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Get.to(CurrentLocation());
  }
}
