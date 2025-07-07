import 'package:flutter/material.dart';
import '../models/theme_service.dart';

class ThemeViewModel extends ChangeNotifier {
  final ThemeService _themeService = ThemeService();
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  ThemeData get lightTheme => _themeService.getLightTheme();
  ThemeData get darkTheme => _themeService.getDarkTheme();

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // 테마 전환
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}
