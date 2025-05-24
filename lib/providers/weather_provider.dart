import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

final weatherServiceProvider = Provider<WeatherService>((ref) {
  final apiKey = dotenv.env['OPEN_WEATHER_API_KEY'] ?? '';
  return WeatherService(apiKey);
});

final weatherProvider =
    AsyncNotifierProvider<WeatherNotifier, Weather?>(WeatherNotifier.new);

class WeatherNotifier extends AsyncNotifier<Weather?> {
  @override
  Future<Weather?> build() async {
    final service = ref.read(weatherServiceProvider);
    return await service.getWeatherFromLocation();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(weatherServiceProvider);
      return await service.getWeatherFromLocation();
    });
  }

  Future<void> fetchByCity(String cityName) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(weatherServiceProvider);
      return await service.getWeatherByCity(cityName);
    });
  }
}
