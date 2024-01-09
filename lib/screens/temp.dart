import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class temp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: const GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(34.9783, 78.97328), zoom: 14),
      ),
    );
  }
}
