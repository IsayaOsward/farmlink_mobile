import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BiometricAuth {
  static final LocalAuthentication _localAuth = LocalAuthentication();
  static const String _biometricEnabledKey = "biometric_enabled";

  // Initialize secure storage instance
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Authenticate using biometrics
  static Future<bool> authenticate(String localizedReason) async {
    try {
      final bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
      return isAuthenticated;
    } catch (e) {
      return false;
    }
  }

  // Check if biometrics is enabled (stored securely)
  static Future<bool> isBiometricEnabled() async {
    String? enabled = await _secureStorage.read(key: _biometricEnabledKey);
    return enabled == "true";
  }

  // Enable or disable biometric authentication (store securely)
  static Future<void> setBiometricEnabled(bool isEnabled) async {
    await _secureStorage.write(
      key: _biometricEnabledKey,
      value: isEnabled.toString(),
    );
  }
}
