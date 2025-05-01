import 'package:flutter/material.dart';

import '../../utils/biometric_util.dart';

class BiometricProvider extends ChangeNotifier {
  bool _isBiometricEnabled = false;

  bool get isBiometricEnabled => _isBiometricEnabled;

  BiometricProvider() {
    _loadBiometricPreference();
  }

  Future<void> handleBiometricToggle(bool value) async {
    if (value) {
      final isAuthenticated = await BiometricAuth.authenticate(
        "Confirm your identity to enable biometric lock.",
      );
      if (isAuthenticated) {
        await BiometricAuth.setBiometricEnabled(true);
        _isBiometricEnabled = true;
        notifyListeners();
      }
    } else {
      await BiometricAuth.setBiometricEnabled(false);
      _isBiometricEnabled = false;
      notifyListeners();
    }
  }

  Future<void> _loadBiometricPreference() async {
    final isEnabled = await BiometricAuth.isBiometricEnabled();
    _isBiometricEnabled = isEnabled;
    notifyListeners();
  }
}
