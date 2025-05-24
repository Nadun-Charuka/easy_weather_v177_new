import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  late Box _themeBox;
  ThemeNotifier() : super(ThemeMode.light) {
    _themeBox = Hive.box('theme');
    final isDark = _themeBox.get('isDarkMode', defaultValue: false);
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }
  void toggleTheme() {
    final isDark = state == ThemeMode.dark;
    state = isDark ? ThemeMode.light : ThemeMode.dark;
    _themeBox.put('isDarkMode', state == ThemeMode.dark);
  }
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
