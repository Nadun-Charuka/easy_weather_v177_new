//https://api.openweathermap.org/data/2.5/weather?q=Kottawa,lk&appid=e6d84f3fe6692f72ca32032280d89d5f&units=metric

import 'dart:convert';

import 'package:easy_weather_v177_new/models/get_location_service.dart';
import 'package:easy_weather_v177_new/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;
  WeatherService({required this.apiKey});

  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  //get the weather from the city name
  Future<Weather> getWeather(String cityName, String countryName) async {
    try {
      final url =
          '$baseUrl?q={$cityName},$countryName&appid=$apiKey&units=metric';
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return Weather.fromJson(data);
      } else {
        throw Exception("Error in response body ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("failed to load the city");
    }
  }

  //get the weather from the cuurent location

//https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=e6d84f3fe6692f72ca32032280d89d5f&units=metric

  Future<Weather> getWeatherFromLocation() async {
    try {
      final location = GetLocationService();
      final latlog = await location.getCityNameFromCurrentLocation();

      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${latlog[0]}&lon=${latlog[1]}&appid=e6d84f3fe6692f72ca32032280d89d5f&units=metric';

      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return Weather.fromJson(data);
      } else {
        throw Exception("Error in response body ${res.statusCode}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
