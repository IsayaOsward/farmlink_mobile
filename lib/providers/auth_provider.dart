import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../configs/api/api_credentials.dart';
import '../graphql/mutations/uaa.dart';
import '../graphql/queries/uaa.dart';
import '../models/defaults/default_response_model.dart';
import '../models/uaa.dart';
import '../models/user_registration_model.dart';
import '../repository/local_storage.dart';
import '../routes/route_names.dart';
import '../services/graphql_operation.dart';
import '../services/graphql_service_call.dart';
import '../widgets/toasts.dart';
import 'categories/category_provider.dart';
import 'farms/farm_provider.dart';
import 'products/products_provider.dart';

class AuthProvider extends ChangeNotifier {
  final graphQLService = GraphQLCallService();
  bool isLoading = false;
  String _loginMessage = '';
  bool loginSuccess = false;
  bool registerSuccess = false;
  String get loginMessage => _loginMessage;
  UserProfileData? _userData;
  UserProfileData? get userData => _userData;
  final localStorage = LocalStorage();

  Future authenticateUser(
      {required BuildContext context,
      required String username,
      required String password}) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = {
      'username': username,
      'password': password,
      'grant_type': passWordGrantType,
      'client_id': clientId,
      'client_secret': clientSecret,
    };
    try {
      final response =
          await http.post(Uri.parse(loginUrls), headers: headers, body: body);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['access_token'] != null && context.mounted) {
          await localStorage.saveItem(
              key: localStorage.accessToken, value: result['access_token']);
          await localStorage.saveItem(
              key: localStorage.refreshToken, value: result['refresh_token']);
          final user = jsonEncode(result['user']);
          await localStorage.saveItem(key: localStorage.user, value: user);

          final profileResult = await graphQLService.performGraphQLOperation(
              operationString: getUserProfileString,
              operationType: OperationType.query,
              responseKey: "getUserProfileAndRoles",
              fromJson: UserProfileResponse.fromJson);

          if (profileResult!.response.status) {
            _userData = profileResult.data;

            final farmProvider =
                Provider.of<FarmProvider>(context, listen: false);
            final categoryProvider =
                Provider.of<CategoryProvider>(context, listen: false);
            final productProvider =
                Provider.of<ProductsProvider>(context, listen: false);
            log("===============CALLING FARMS========================");

            await farmProvider.fetchFarms();
            await farmProvider.fetchFarms(isMine: true);

            await categoryProvider.fetchAllCategories();
            log("===============CALLING PRODUCTS========================");
            await productProvider.fetchProducts();
          }
          loginSuccess = true;
        } else {
          loginSuccess = false;
          _loginMessage = "Invalid credentials";
        }
      } else {
        loginSuccess = false;
        _loginMessage = "Authentication failed";
      }
    } catch (e) {
      loginSuccess = false;
      _loginMessage = "Authentication failed";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registerUser(
      {required BuildContext context,
      required UserRegistration userData}) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    try {
      final result = await graphQLService.performGraphQLOperation(
        operationString: userRegistrationMutationString,
        operationType: OperationType.mutation,
        responseKey: "createUsersMutation.response",
        variables: userData.toJson(),
        fromJson: DefaultResponseModel.fromJson,
      );
      if (result!.status) {
        if (context.mounted) {
          showCustomSnackBar(
              context: context, message: result.message, infoType: "success");
        }
      } else {
        if (context.mounted) {
          showCustomSnackBar(
              context: context, message: result.message, infoType: "error");
        }
      }
    } finally {
      isLoading = false;
      registerSuccess = true;
      notifyListeners();
    }
  }

  Future<void> activateAccount(
      {required BuildContext context,
      required String token,
      required String password}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoading = true;
      notifyListeners();
    });
    try {
      final result = await graphQLService.performGraphQLOperation(
        operationString: activateAccountMutationString,
        operationType: OperationType.mutation,
        responseKey: "activateOrResetPasswordMutation.response",
        variables: {
          "input": {"requestToken": token, "password": password}
        },
        fromJson: DefaultResponseModel.fromJson,
      );
      if (result!.status) {
        if (context.mounted) {
          showCustomSnackBar(
              context: context, message: result.message, infoType: "success");
          Navigator.pushReplacementNamed(context, FarmLinkRoutes.loginScreen);
        }
      } else {
        if (context.mounted) {
          showCustomSnackBar(
              context: context, message: result.message, infoType: "error");
        }
      }
    } finally {
      isLoading = false;
      registerSuccess = true;
      notifyListeners();
    }
  }

  Future<void> resetPassword() async {}

  Future<void> checkTokenValidity() async {}
}
