import 'package:flutter/material.dart';

import 'loader.dart';

class NetworkInterceptor {
  static final NetworkInterceptor _instance = NetworkInterceptor._internal();
  late BuildContext _context;
  int _activeRequests = 0;

  factory NetworkInterceptor() => _instance;

  NetworkInterceptor._internal();

  void init(BuildContext context) {
    _context = context;
  }

  Future<T> intercept<T>(Future<T> Function() networkCall) async {
    _startLoading();
    try {
      return await networkCall();
    } catch (e) {
      _showError("Network error: $e");
      rethrow;
    } finally {
      _stopLoading();
    }
  }

  void _startLoading() {
    if (_activeRequests == 0) {
      NetworkLoader().show(_context);
    }
    _activeRequests++;
  }

  void _stopLoading() {
    _activeRequests--;
    if (_activeRequests == 0) {
      NetworkLoader().hide();
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
