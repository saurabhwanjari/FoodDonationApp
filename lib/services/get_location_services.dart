import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/app_text.dart';

class GetLocationServices extends StatelessWidget {
  GetLocationServices({Key? key}) : super(key: key);
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";

  void checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  void getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    long = position.longitude.toString();
    lat = position.latitude.toString();

    //
    print(lat); //Output: 80.24599079
    print(long); //Output: 29.6593457

    // LocationSettings locationSettings = LocationSettings(
    //   accuracy: LocationAccuracy.high, //accuracy of the location data
    //   distanceFilter: 100, //minimum distance (measured in meters) a
    //   //device must move horizontally before an update event is generated;
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
