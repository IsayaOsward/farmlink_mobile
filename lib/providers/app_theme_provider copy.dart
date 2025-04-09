import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  AppThemeProvider() {
    _loadThemePreference();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _saveThemePreference(_isDarkMode);
    notifyListeners();
  }

  Future<void> _loadThemePreference() async {
    String? darkMode = await _secureStorage.read(key: 'isDarkMode');
    if (darkMode != null) {
      _isDarkMode = darkMode == 'true';
    } else {
      _isDarkMode = false;
    }
    notifyListeners();
  }

  Future<void> _saveThemePreference(bool isDarkMode) async {
    await _secureStorage.write(key: 'isDarkMode', value: isDarkMode.toString());
  }
}


