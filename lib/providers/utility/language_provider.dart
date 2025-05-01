import 'package:flutter/material.dart';

import '../../repository/language_repository.dart';


class LanguageProvider extends ChangeNotifier {
  final LanguageRepository _repository;
  bool _isSwahili = true;
  bool _isInitialized = false;

  LanguageProvider({LanguageRepository? repository})
      : _repository = repository ?? LanguageRepository();

  // Getter for the current locale
  Locale get currentLocale =>
      _isSwahili ? const Locale("sw") : const Locale("en");

  // Getter to check if the provider is initialized
  bool get isInitialized => _isInitialized;

  // Initialize the language preference
  Future<void> initialize() async {
    if (!_isInitialized) {
      final language = await _repository.loadLanguage();
      if (language != null) {
        _isSwahili = language == 'sw';
      }
      _isInitialized = true;
      notifyListeners();
    }
  }

  // Toggle the language and save the preference
  void toggleLanguage() {
    _isSwahili = !_isSwahili;
    _repository.saveLanguage(_isSwahili ? 'sw' : 'en');
    notifyListeners();
  }
}
