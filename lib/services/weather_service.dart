import 'dart:convert';
import 'package:easy_weather_v177_new/services/get_location_service.dart';
import 'package:easy_weather_v177_new/models/weather_model.dart';

import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;
  WeatherService(this.apiKey);

  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  Future<Weather> getWeatherFromLocation() async {
    final location = GetLocationService();
    final coords = await location.getCurrentCoordinates();
    final url =
        '$baseUrl?lat=${coords[0]}&lon=${coords[1]}&appid=$apiKey&units=metric';

    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return Weather.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load weather: ${res.statusCode}');
    }
  }

  Future<Weather> getWeatherByCity(String cityName) async {
    final url = '$baseUrl?q=$cityName&appid=$apiKey&units=metric';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return Weather.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load weather using city: ${res.statusCode}');
    }
  }
}
