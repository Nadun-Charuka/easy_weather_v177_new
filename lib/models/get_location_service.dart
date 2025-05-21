import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationService {
  Future<List<double>> getCityNameFromCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition();

    debugPrint(position.latitude.toString());
    debugPrint(position.longitude.toString());

    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String cityName = placeMarks[0].locality!;
    debugPrint(cityName);

    return [position.latitude, position.longitude];
  }
}
