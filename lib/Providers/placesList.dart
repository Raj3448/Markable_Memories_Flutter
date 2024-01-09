import 'dart:io';

import 'package:flutter/material.dart';
import '/models/Places.dart';
import '/Helpers/db_helpers.dart';

class PlacesList with ChangeNotifier {
  late List<Places> _items = [];

  List<Places> get items {
    return [..._items];
  }

  Future<void> addPlacesList(String cityName, String placeName, File savedImage,
      String dateTime) async {
    Places newEntity = Places(
      id: DateTime.now().toString(),
      title: placeName,
      cityName: cityName,
      location: PlaceCordinates(
          latitude: 65.656567, longitude: 76.87676, address: "--"),
      image: savedImage,
      dateTime: dateTime,
    );
    _items.add(newEntity);
    notifyListeners();
    try {
      await DB_helpers.insertData('Places', {
        'id': newEntity.id,
        'title': newEntity.title,
        'image': newEntity.image.path,
        'cordinates': newEntity.location,
        'cityname': newEntity.cityName,
        'dateTime': newEntity.dateTime,
      });
    } catch (error) {
      //...
    }
  }

  Future<void> fetchingAndLaunchingData() async {
    final extractedData = await DB_helpers.getData('Places');

    _items = extractedData
        .map((items) => Places(
            id: items['id'],
            title: items['title'],
            cityName: items['cityname'],
            location: items['cordinates'],
            image: File(items['image']),
            dateTime: items['dateTime']))
        .toList();
    notifyListeners();
  }
}
