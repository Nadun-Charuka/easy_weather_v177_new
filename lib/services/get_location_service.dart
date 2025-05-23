import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class GetLocationService {
  Future<List<double>> getCurrentCoordinates() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    final position = await Geolocator.getCurrentPosition();
    debugPrint("Lat: ${position.latitude}, Lon: ${position.longitude}");

    return [position.latitude, position.longitude];
  }
}
