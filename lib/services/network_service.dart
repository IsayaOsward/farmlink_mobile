import 'dart:convert';
import 'package:http/http.dart' as http;

import '../configs/base_url.dart';
import '../repository/local_storage.dart';

class NetworkService {
  final LocalStorage _storage = LocalStorage();

  // Singleton pattern
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  Future<Map<String, String>> _buildHeaders({bool requiresAuth = false}) async {
    final headers = {'Content-Type': 'application/json'};
    if (requiresAuth) {
      final token = await _storage.getItem(key: _storage.accessToken);
      final type = await _storage.getItem(key: _storage.tokenType) ?? 'Bearer';

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = '$type $token';
      }
    }
    return headers;
  }

  Future<http.Response> get(String endpoint, {bool auth = false}) async {
    final headers = await _buildHeaders(requiresAuth: auth);
    return http.get(Uri.parse('$baseUrl/$endpoint'), headers: headers);
  }

  Future<http.Response> post(String endpoint, dynamic data,
      {bool auth = false}) async {
    final headers = await _buildHeaders(requiresAuth: auth);
    return http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: headers,
      body: jsonEncode(data),
    );
  }

  Future<http.Response> put(String endpoint, dynamic data,
      {bool auth = false}) async {
    final headers = await _buildHeaders(requiresAuth: auth);
    return http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: headers,
      body: jsonEncode(data),
    );
  }

  Future<http.Response> delete(String endpoint, {bool auth = false}) async {
    final headers = await _buildHeaders(requiresAuth: auth);
    return http.delete(Uri.parse('$baseUrl/$endpoint'), headers: headers);
  }
}
