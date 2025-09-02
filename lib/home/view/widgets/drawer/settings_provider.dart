import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  String languageCode = "en";
  bool get isDark => themeMode == ThemeMode.dark;
  void changeTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }

  void changeLanguage(String code) {
    languageCode = code;
    notifyListeners();
  }
}
