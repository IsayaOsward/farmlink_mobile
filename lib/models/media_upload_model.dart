import 'package:farmlink/models/defaults/default_response_model.dart';

class MediaUploadModel {
  final DefaultResponseModel responseModel;
  final UploadBase64Data uploadBase64Data;

  MediaUploadModel(
      {required this.responseModel, required this.uploadBase64Data});

  factory MediaUploadModel.fromJson(Map<String, dynamic> json) {
    return MediaUploadModel(
      responseModel: DefaultResponseModel.fromJson(json['response']),
      uploadBase64Data: UploadBase64Data.fromJson(json['data']),
    );
  }
}

class UploadBase64Data {
  final String filePath;
  final String fileName;

  UploadBase64Data({required this.filePath, required this.fileName});

  factory UploadBase64Data.fromJson(Map<String, dynamic> json) {
    return UploadBase64Data(
        filePath: json['filePath'], fileName: json['fileName']);
  }
}
