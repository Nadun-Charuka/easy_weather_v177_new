import 'package:easy_weather_v177_new/providers/weather_provider.dart';
import 'package:easy_weather_v177_new/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class WeatherDisplayWidget extends ConsumerWidget {
  const WeatherDisplayWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    return weatherAsync.when(
      data: (weather) {
        if (weather == null) {
          return Text("No data");
        }
        return Column(
          children: [
            Lottie.asset(
              UtilFunctions.getWeatherAnimation(conditon: weather.condition),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weather.cityName,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "${weather.temperature.toStringAsFixed(1)}°C",
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  weather.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Preassure",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${weather.pressure} Pa")
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Humidity",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${weather.humidity}%")
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Wind",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${weather.windSpeed}m/s"),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        );
      },
      error: (err, stackTrace) => Center(child: Text('Error: $err')),
      loading: () => Center(child: const CircularProgressIndicator()),
    );
  }
}
