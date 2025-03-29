import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageRepository {
  final FlutterSecureStorage _secureStorage;
  static const String _languageKey = 'language';

  LanguageRepository({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  Future<void> saveLanguage(String languageCode) async {
    await _secureStorage.write(key: _languageKey, value: languageCode);
  }

  Future<String?> loadLanguage() async {
    return await _secureStorage.read(key: _languageKey);
  }
}
