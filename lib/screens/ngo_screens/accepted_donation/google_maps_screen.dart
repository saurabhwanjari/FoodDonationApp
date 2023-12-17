import 'package:donation_app/controllers/supplier_controllers/donate_food_controller.dart';
import 'package:donation_app/models/donation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart';

class GoogleMapsScreen extends StatefulWidget {
  GoogleMapsScreen({Key? key}) : super(key: key);

  //DonateFoodController donateFoodController = Get.find<DonateFoodController>();

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreen();
}

class _GoogleMapsScreen extends State<GoogleMapsScreen> {
  Donation? donation;
  Location location = Location();
  var lat, long;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var value = await location.getLocation();
                lat = value.latitude!.toDouble();
                long = value.longitude!.toDouble();
              },
              child: Text('Get Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                //var value = await location.getLocation();

                var latd = donation!.latitude;
                var longd = donation!.longitude;

                MapLauncher.showDirections(
                    mapType: MapType.google,
                    //destination: Coords(21.1458, 79.0882),   //Nagpur Co-ordinates
                    destination:
                        Coords(double.parse(latd), double.parse(longd)),
                    origin: Coords(lat.toDouble(), long.toDouble()));
              },
              child: Text('Google Maps'),
            )
          ]),
    );
  }
}
