import 'dart:developer';

import 'defaults/default_response_model.dart';

class UserProfileResponse {
  final DefaultResponseModel response;
  final UserProfileData? data;

  UserProfileResponse({
    required this.response,
    required this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    final profileJson = json;
    return UserProfileResponse(
      response: DefaultResponseModel.fromJson(profileJson['response'] ?? {}),
      data: profileJson['data'] != null
          ? UserProfileData.fromJson(profileJson['data'])
          : null,
    );
  }

  factory UserProfileResponse.error() {
    return UserProfileResponse(
      response: DefaultResponseModel(
        id: '0',
        status: false,
        code: 4000,
        message: 'No data',
      ),
      data: null,
    );
  }

  Map<String, dynamic> toJson() => {
        'response': response.toJson(),
        'data': data?.toJson(),
      };
}

class UserProfileData {
  final String id;
  final String uniqueId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String photo;
  final String accountType;

  UserProfileData({
    required this.id,
    required this.uniqueId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.photo,
    required this.accountType,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      id: json['id'].toString(),
      uniqueId: json['uniqueId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      accountType: json['accountType'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uniqueId': uniqueId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'photo': photo,
        'accountType': accountType,
      };
}
