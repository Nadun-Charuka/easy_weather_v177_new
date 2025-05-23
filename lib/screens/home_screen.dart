import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Easy Weather"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(weatherProvider.notifier).refresh(),
          )
        ],
      ),
      body: weatherAsync.when(
        data: (weather) {
          if (weather == null) return const Center(child: Text("No data."));
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  weather.cityName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text("${weather.temperature}°C - ${weather.description}"),
                const SizedBox(height: 16),
                Text("Humidity: ${weather.humidity}%"),
                Text("Wind: ${weather.windSpeed} m/s"),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
