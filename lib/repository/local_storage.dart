import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  //Sample Keys stored
  String accessToken = 'access_token';
  String refreshToken = 'refresh_token';
  String tokenExpireTime = 'expires_in';
  String tokenType = 'token_type';
  String user = 'user';
  String firstName = 'first_name';
  String lastName = 'last_name';
  String email = 'email';
  String username = 'username';

  final _storage = FlutterSecureStorage();

  Future<void> saveItem({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> getItem({required String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteItem({required String key}) async {
    await _storage.delete(key: key);
  }

  Future<void> flushStorage() async {
    await _storage.deleteAll();
  }
}
