// import 'package:donation_app/controllers/authentication/supplier_location_controller.dart';
// import 'package:donation_app/widgets/app_text.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class CurrentLocation extends StatelessWidget {
//   CurrentLocation({Key? key}) : super(key: key);

//   //
//   LocationController locationController = Get.put(LocationController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: AppText('Google Maps'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Get.back(result: locationController.tappedPoint);
//             },
//             icon: Icon(Icons.check),
//           ),
//         ],
//       ),
//       body: GoogleMap(
//         initialCameraPosition:
//             CameraPosition(target: LatLng(20.3899, 78.1307), zoom: 14.0),
//         markers: Set.from(locationController.myMarkers),
//         mapType: MapType.normal,
//         onTap: locationController.handleTap,
//       ),
//       bottomSheet: Container(
//         //decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.green),
//         alignment: Alignment.bottomCenter,
//         height: 70,
//         width: Get.width * 0.85,
//         padding: EdgeInsets.all(8.0),
//         color: Get.theme.colorScheme.secondary,
//         child: AppText(
//           'Search yor location and tap it. You can also drag the marker to your desired location.',
//           isBold: true,
//           textAlign: TextAlign.justify,
//         ),
//       ),
//     );
//   }
// }

//.........................................................................................................

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends StatefulWidget {
  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  //
  final LatLng initialLocation = LatLng(20.5937, 78.9629);
  late GoogleMapController mapController;
  Marker? currentLocationMarker;

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        //
        title: Text('Current Location'),

        //
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              gotoCurrentLocation();
            },
          ),
        ],
      ),

      //
      body: GoogleMap(
        //
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 5,
        ),

        //
        onMapCreated: (GoogleMapController mapController) {
          this.mapController = mapController;
        },

        //
        markers: {if (currentLocationMarker != null) currentLocationMarker!},
      ),
    );
  }

  //
  Future<void> gotoCurrentLocation() async {
    // check location service is eanbled
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      print('Device has no location service');
      Geolocator.requestPermission();
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }

    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 20,
        ),
      ),
    );

    currentLocationMarker = Marker(
      markerId: MarkerId('my_location'),
      infoWindow: InfoWindow(title: 'Your Current Location'),
      position: LatLng(currentPosition.latitude, currentPosition.longitude),
      draggable: true,
    );

    setState(() {
      //
    });
  }
}
