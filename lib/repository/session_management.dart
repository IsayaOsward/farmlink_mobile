import 'dart:convert';
import 'package:farmlink/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

import '../configs/base_url.dart';
import '../widgets/toasts.dart';



class SessionManagement {
  static final storage = FlutterSecureStorage();
  static const String _firstTimeKey = "isFirstTime";

  static Future<void> saveSession(Map<String, dynamic> sessionData) async {
    await storage.write(key: 'access', value: sessionData['access']);
    await storage.write(key: 'refresh', value: sessionData['refresh']);
    await storage.write(key: 'user', value: jsonEncode(sessionData['user']));

    // Decode the tokens to extract expiration and issued time
    Map<String, dynamic> accessPayload =
        JwtDecoder.decode(sessionData['access']);
    Map<String, dynamic> refreshPayload =
        JwtDecoder.decode(sessionData['refresh']);

    await storage.write(
        key: 'access_exp', value: accessPayload['exp'].toString());
    await storage.write(
        key: 'refresh_exp', value: refreshPayload['exp'].toString());
  }

  /// Check if a token is expired
  static Future<bool> isTokenExpired(String key) async {
    String? expString = await storage.read(key: key);
    if (expString == null) return true;

    int expTimestamp = int.parse(expString);
    DateTime expiryDate =
        DateTime.fromMillisecondsSinceEpoch(expTimestamp * 1000);

    return expiryDate.isBefore(DateTime.now());
  }

  /// Refresh the access token
  static Future<bool> refreshAccessToken() async {
    String? refreshToken = await storage.read(key: 'refresh');
    if (refreshToken == null) return false;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/token/refresh/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"refresh": refreshToken}),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> newTokens = jsonDecode(response.body);
        await saveSession(newTokens);
        return true;
      }
    } catch (e) {
      throw ();
    }

    return false;
  }

  /// Check session and refresh token if needed
  static Future<void> checkSession(BuildContext context) async {
    bool isAccessExpired = await isTokenExpired('access_exp');
    bool isRefreshExpired = await isTokenExpired('refresh_exp');

    if (isAccessExpired) {
      if (!isRefreshExpired) {
        bool refreshed = await refreshAccessToken();
        if (refreshed) return;
      }
      if (context.mounted) {
        clearSession(context);
      }
    }
  }

  /// Get the access token
  static Future<String?> getAccessToken() async {
    return await storage.read(key: 'access');
  }

  /// Get the refresh token
  static Future<String?> getRefreshToken() async {
    return await storage.read(key: 'refresh');
  }

  /// Get the stored user data
  static Future<Map<String, dynamic>?> getUserData() async {
    String? userData = await storage.read(key: 'user');
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  /// Clear session and log out user
  static Future<void> clearSession(BuildContext context) async {
    await storage.delete(key: 'access');
    await storage.delete(key: 'refresh');
    await storage.delete(key: 'access_exp');
    await storage.delete(key: 'refresh_exp');
    await storage.delete(key: 'user');

    if (context.mounted) {
      showCustomSnackBar(
        context: context,
        message: "Logged out successfully!",
        infoType: "success",
      );
    }

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, FarmLinkRoutes.loginScreen);
    }
  }

  static Future<void> clearAllTokens() async {
    await storage.delete(key: 'access');
    await storage.delete(key: 'refresh');
    await storage.delete(key: 'access_exp');
    await storage.delete(key: 'refresh_exp');
    await storage.delete(key: 'user');
  }

  /// Save the theme preference
  static Future<void> saveThemePreference(bool isDarkMode) async {
    await storage.write(key: 'theme', value: isDarkMode ? 'dark' : 'light');
  }

  /// Get the theme preference
  static Future<bool> getThemePreference() async {
    String? theme = await storage.read(key: 'theme');
    return theme == 'dark';
  }

  /// Save the language preference
  static Future<void> saveLanguagePreference(String languageCode) async {
    await storage.write(key: 'language', value: languageCode);
  }

  /// Get the language preference
  static Future<String?> getLanguagePreference() async {
    return await storage.read(key: 'language');
  }

  // Save first-time status
  static Future<void> setFirstTime(bool isFirstTime) async {
    await storage.write(key: _firstTimeKey, value: isFirstTime.toString());
  }

  // Load first-time status
  static Future<bool> isFirstTime() async {
    String? value = await storage.read(key: _firstTimeKey);
    return value == null || value == "true";
  }

  static saveCsrfToken(String? csrfToken) {}
}
