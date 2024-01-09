import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final String? preViewImageUrl = null;
  double? latitude = 0.0;
  double? longitude = 0.0;

  LocationInput._private({super.key});
  static LocationInput? _singleInstance;
  factory LocationInput.setImage({
    required double latitude,
    required double longitude,
  }) {
    _singleInstance ??= LocationInput._private();

    _singleInstance!.latitude = latitude;
    _singleInstance!.longitude = longitude;

    return _singleInstance!;
  }

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  late GoogleMapController googleMapController;
  CameraPosition? initialCameraPosition = null;
  Set<Marker> markers = {};

  Future<void> _getCurrentLocation() async {
    var locationData = await Location().getLocation();

    setState(() {
      widget.latitude = locationData.latitude;
      widget.longitude = locationData.longitude;
      initialCameraPosition = CameraPosition(
          target: LatLng(widget.latitude!, widget.longitude!), zoom: 14);
      markers.add(Marker(
          markerId: const MarkerId('User Location'),
          position: LatLng(widget.latitude!, widget.longitude!)));
    });

    print('Latitude : ${locationData.latitude}');
    print('Longitude : ${locationData.longitude}');
    print('altitude : ${locationData.altitude}');
    print('Accuracy : ${locationData.accuracy}');
    print('Satallite Number : ${locationData.satelliteNumber}');
    print('Speed : ${locationData.speed}');
    print('elapsedRealtimeNanos : ${locationData.elapsedRealtimeNanos}');
    print(
        'elapsedRealtimeUncertaintyNanos : ${locationData.elapsedRealtimeUncertaintyNanos}');
    print('Heading : ${locationData.heading}');
    print('isMock : ${locationData.isMock}');
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 163, 135, 239),
              width: 3,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 170,
          width: double.infinity,
          child: (widget.latitude == 0.0 && widget.longitude == 0.0)
              ? const Center(
                  child: Text(
                    'No Location Chosen',
                  ),
                )
              : GoogleMap(
                  initialCameraPosition: initialCameraPosition!,
                  onMapCreated: (controller) {
                    googleMapController = controller;
                  },
                  markers: markers,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text(
                  'Current Location',
                  style: TextStyle(color: Color(0xFF7E57C2)),
                )),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text(
                  'Select Location From Map',
                  style: TextStyle(color: Color(0xFF7E57C2)),
                )),
          ],
        )
      ],
    );
  }
}
