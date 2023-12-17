import 'package:donation_app/controllers/supplier_controllers/donate_food_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../widgets/app_text.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  DonateFoodController donateFoodController = Get.find<DonateFoodController>();
  //
  final LatLng ytlLocation = LatLng(20.3899, 78.1307);

  // final LatLng currentPosition = LatLng(lati);
  var lat = 'Getting'.obs;
  var long = 'Getting'.obs;
  String latitude = '';
  String longitude = '';
  late double lati;
  late double longi;

  //
  @override
  void initState() {
    super.initState();

    print(latitude);
    print(longitude);
  }

  //
  @override
  Widget build(BuildContext context) {
    latitude = donateFoodController.latitude.value.toString();
    longitude = donateFoodController.longitude.value.toString();
    lati = double.parse(latitude);
    longi = double.parse(longitude);
    final LatLng currentPosition = LatLng(lati, longi);
    return Scaffold(
      //
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              'Select Donation Location',
              size: 18,
              isBold: true,
              textColor: Get.theme.colorScheme.onPrimary,
            ),
            AppText(
              '(Drag the marker to specific location)',
              size: 13,
              textColor: Get.theme.colorScheme.onPrimary,
            ),
          ],
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),

      //
      body: GoogleMap(
        //
        initialCameraPosition: CameraPosition(
          target: currentPosition,
          zoom: 15,
        ),

        //
        markers: {
          //
          Marker(
            markerId: MarkerId('marker1'),
            position: currentPosition,
            infoWindow: InfoWindow(
              title: 'Your Current Location',
              snippet: 'This is the location where you are currently located.',
            ),

            draggable: true,

            //
            onDragEnd: (LatLng newPosition) {
              //

              donateFoodController.latitude.value =
                  newPosition.latitude.toString();
              donateFoodController.longitude.value =
                  newPosition.longitude.toString();
              print(donateFoodController.latitude.value);
              print(donateFoodController.longitude.value);
            },
          ),
        },
      ),
    );
  }
}
