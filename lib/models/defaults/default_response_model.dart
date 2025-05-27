import 'dart:developer';

class DefaultResponseModel {
  final String id;
  final bool status;
  final int code;
  final String message;

  DefaultResponseModel({
    required this.id,
    required this.status,
    required this.code,
    required this.message,
  });

  /// Factory method to create a `DefaultResponseModel` from JSON
  factory DefaultResponseModel.fromJson(Map<String, dynamic> json) {
    log("===================$json");
    return DefaultResponseModel(
      id: json['id'] ?? "0",
      status: json['status'] ?? false,
      code: json['code'] ?? 4000,
      message: json['message'] ?? 'Unknown error occurred',
    );
  }

  factory DefaultResponseModel.error(String errorMessage) {
    return DefaultResponseModel(
      id: "0",
      status: false,
      code: 4000,
      message: errorMessage,
    );
  }

  /// Convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'code': code,
      'message': message,
    };
  }
}
