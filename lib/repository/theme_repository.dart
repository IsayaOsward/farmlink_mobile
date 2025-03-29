import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeRepository {
  final FlutterSecureStorage _secureStorage;
  static const String _themeKey = 'isDarkMode';

  ThemeRepository({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  Future<void> saveTheme(bool isDarkMode) async {
    await _secureStorage.write(key: _themeKey, value: isDarkMode.toString());
  }

  Future<bool?> loadTheme() async {
    final String? darkMode = await _secureStorage.read(key: _themeKey);
    return darkMode != null ? darkMode == 'true' : null;
  }
}
