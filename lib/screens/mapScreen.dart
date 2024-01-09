// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplace/screens/LocationInput.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/mapScreen';

  MapScreen._private();
  static MapScreen? _singleInstance;

  factory MapScreen() {
    _singleInstance ??= MapScreen._private();
    return _singleInstance!;
  }

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController googleMapController;

  CameraPosition? _initialCameraPosition = null;

  Set<Marker> markers = {};
  static LatLng? pickedLoaction = null;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentCordinates();
  }

  static get getpickedLocation => pickedLoaction;

  void _getCurrentCordinates() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 14);
    });
  }

//For getting current co-ordinates of user
  Future<Position> _determinedPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location Service is disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission denied forever');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  void _selectedLocation(LatLng position) {
    setState(() {
      pickedLoaction = position;
      markers.clear();
      markers.add(Marker(
          markerId: const MarkerId('Picked Location'),
          position: pickedLoaction!));
    });
    debugPrint('Picked Location : ${pickedLoaction.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return _initialCameraPosition == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Stack(children: [
            GoogleMap(
              initialCameraPosition:
                  _initialCameraPosition!, //map open zalyananyr cameryachi position kay asayla havi ya sathi
              markers: markers,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
              onTap: _selectedLocation,
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  alignment: Alignment.topRight,
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.deepPurpleAccent,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      Position position = await _determinedPosition();

                      googleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 14)));
                      markers.clear();

                      markers.add(Marker(
                          markerId: const MarkerId('CurrentLocation'),
                          position:
                              LatLng(position.latitude, position.longitude)));

                      setState(() {
                        pickedLoaction =
                            LatLng(position.latitude, position.longitude);
                        isLoading = false;
                      });
                    },
                    label: !isLoading
                        ? const Text('Current Location')
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                    icon: const Icon(Icons.location_history),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  alignment: Alignment.topRight,
                  child: FloatingActionButton.extended(
                    backgroundColor: pickedLoaction == null
                        ? Colors.grey
                        : Colors.deepPurpleAccent,
                    onPressed: pickedLoaction == null
                        ? null
                        : () {
                            LocationInput.setImage(
                              latitude: pickedLoaction!.latitude,
                              longitude: pickedLoaction!.longitude,
                            );
                            debugPrint(
                                'Picked Location jsj : ${pickedLoaction.toString()}');
                          },
                    label: const Text('Add Location'),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            )
          ]);
  }
}
