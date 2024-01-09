// import 'package:flutter/material.dart';

// class MapImageWidget extends StatelessWidget {
//   final double? latitude;
//   final double? longitude;
//   final int zoom;
//   final int width;
//   final int height;
//   final String apiKey;

//   const MapImageWidget(
//       {required this.latitude,
//       required this.longitude,
//       this.zoom = 14,
//       this.width = 300,
//       this.height = 200,
//       required this.apiKey,
//       super.key});

//   @override
//   Widget build(BuildContext context) {
//     final url = 'https://maps.googleapis.com/maps/api/staticmap?'
//         'center=$latitude,$longitude&'
//         'zoom=$zoom&'
//         'size=${width}x$height&'
//         'markers=color:red%7Clabel:A%7C$latitude,$longitude&'
//         'key=$apiKey';
//     return Image.network(url);
//   }
// }
