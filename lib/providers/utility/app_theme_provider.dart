import 'package:flutter/material.dart';

import '../../repository/theme_repository.dart';

class AppThemeProvider extends ChangeNotifier {
  final ThemeRepository _repository;
  bool _isDarkMode = false;
  bool _isInitialized = false;

  AppThemeProvider({ThemeRepository? repository})
      : _repository = repository ?? ThemeRepository();

  // Getter for dark mode state
  bool get isDarkMode => _isDarkMode;

  // Getter for the current theme mode
  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Getter to check if the provider is initialized
  bool get isInitialized => _isInitialized;

  // Initialize the theme preference
  Future<void> initialize() async {
    if (!_isInitialized) {
      final bool? darkMode = await _repository.loadTheme();
      // Default to light mode if null
      _isDarkMode = darkMode ?? false;
      _isInitialized = true;
      notifyListeners();
    }
  }

  // Toggle the theme and save the preference
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _repository.saveTheme(_isDarkMode);
    notifyListeners();
  }
}
