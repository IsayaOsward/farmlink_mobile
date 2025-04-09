import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageProvider extends ChangeNotifier {
  // Initialize secure storage
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool isSwahili = false;

  LanguageProvider() {
    _loadLanguagePreference();
  }

  Locale get currentLocale =>
      isSwahili ? const Locale("sw") : const Locale("en");

  void toggleLanguage() {
    isSwahili = !isSwahili;
    _saveLanguagePreference(isSwahili ? 'sw' : 'en');
    notifyListeners();
  }

  // Function to save language preference to secure storage
  Future<void> _saveLanguagePreference(String languageCode) async {
    await _secureStorage.write(key: 'language', value: languageCode);
  }

  // Function to load language preference from secure storage
  Future<void> _loadLanguagePreference() async {
    String? language = await _secureStorage.read(key: 'language');
    if (language != null) {
      isSwahili = language == 'sw';
    }
    notifyListeners();
  }
}
