import 'package:easy_weather_v177_new/models/weather_model.dart';
import 'package:easy_weather_v177_new/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final WeatherService _weatherService =
      WeatherService(apiKey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? "");

  Weather? _weather;

  //method to fetch the weather
  void fetchWeather() async {
    try {
      final weather = await _weatherService.getWeatherFromLocation();
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      debugPrint("$e");
      throw Exception();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
