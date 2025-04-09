import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';


import '../repository/session_management.dart';
import 'base_url.dart';

class ApiService {
  final String _baseUrl = baseUrl;
  final String _registerfacilityUrl = registerfacilityUrl;
  final Duration _timeout = const Duration(seconds: 15);

  Future<Map<String, String>> _getHeaders() async {
    String? token = await SessionManagement.getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String endpoint,
      {Map<String, dynamic>? params}) async {
    final uri =
        Uri.parse('$_baseUrl$endpoint').replace(queryParameters: params);
    final headers = await _getHeaders();
    return await http.get(uri, headers: headers).timeout(_timeout);
  }

  Future<http.Response> post(String endpoint, {dynamic data}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();
    final body = jsonEncode(data ?? (data is List ? [] : {}));
    return await http.post(uri, headers: headers, body: body).timeout(_timeout);
  }

  Future<http.Response> postFacility(String endpoint, {dynamic data}) async {
    final uri = Uri.parse('$_registerfacilityUrl$endpoint');
    final headers = await _getHeaders();
    final body = jsonEncode(data ?? (data is List ? [] : {}));
    return await http.post(uri, headers: headers, body: body).timeout(_timeout);
  }

  Future<http.Response> put(String endpoint,
      {Map<String, dynamic>? data}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();
    return await http
        .put(uri, headers: headers, body: jsonEncode(data))
        .timeout(_timeout);
  }

  Future<http.Response> delete(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();
    return await http.delete(uri, headers: headers).timeout(_timeout);
  }

  Future<http.StreamedResponse> uploadFile(
      String endpoint, String filePath) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);

    File file = File(filePath);
    if (!await file.exists()) {
      throw Exception("File does not exist at $filePath");
    }

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        filePath,
        filename: basename(filePath),
      ),
    );

    return await request.send();
  }

  Future<String?> refreshAccessToken() async {
    await SessionManagement.refreshAccessToken();
    return SessionManagement.getAccessToken();
  }
}
