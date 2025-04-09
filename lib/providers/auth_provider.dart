import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/session_management.dart';



class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  String _loginMessage = '';
  bool loginSuccess = false;
  String get loginMessage => _loginMessage;
  Map<String, dynamic>? userData = {};


  Future<void> login(
      {required String username,
      required String password,
      required BuildContext context}) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    try {

        _loginMessage = "Login Successfully!";
        loginSuccess = true;
      
    } finally {
      await getUserProfile();
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword() async {}

  Future<void> checkTokenValidity() async {}

  Future<void> getUserProfile() async {
    final profile = await SessionManagement.getUserData();
    userData = profile;
    notifyListeners();
  }

  Future<void> setUserData(Map<String, dynamic> userProfileData) async {
    userData = userProfileData;
    notifyListeners();
  }
}
