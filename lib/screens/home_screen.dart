import 'package:easy_weather_v177_new/providers/theme_provider.dart';
import 'package:easy_weather_v177_new/widgets/weather_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    final theme = themeMode == ThemeMode.dark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _controller.clear();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Easy Weather",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Fetch weather of current location"),
                  ),
                );
                ref.read(weatherProvider.notifier).refresh();
              },
            ),
            IconButton(
              icon: theme ? Icon(Icons.dark_mode) : Icon(Icons.light_mode),
              onPressed: () =>
                  ref.read(themeNotifierProvider.notifier).toggleTheme(),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    icon: Icon(Icons.sunny_snowing),
                    hintText: "Search by City",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        final String cityName = _controller.text.trim();
                        if (cityName.isNotEmpty) {
                          ref
                              .read(weatherProvider.notifier)
                              .fetchByCity(cityName);
                        }
                      },
                      icon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                WeatherDisplayWidget(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
