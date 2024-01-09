import 'dart:io';

class PlaceCordinates {
  double? latitude;
  double? longitude;
  String? address;

  PlaceCordinates(
      {required this.latitude, required this.longitude, required this.address});
}

class Places {
  final String id;
  final String title;
  final String cityName;
  final PlaceCordinates location;
  final String dateTime;
  final File image;

  Places(
      {required this.id,
      required this.title,
      required this.cityName,
      required this.location,
      required this.dateTime,
      required this.image});
}
