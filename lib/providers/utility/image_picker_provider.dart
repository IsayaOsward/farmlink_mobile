// image_provider.dart
import 'dart:convert';
import 'dart:io';
import 'package:farmlink/graphql/mutations/media_upload_mutation.dart';
import 'package:farmlink/models/media_upload_model.dart';
import 'package:farmlink/services/graphql_operation.dart';
import 'package:farmlink/services/graphql_service_call.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  String? _base64Image;
  String? _fileName;
  String? _filePath;
  String? get base64Image => _base64Image;
  String? get fileName => _fileName;
  String? get filePath => _filePath;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final service = GraphQLCallService();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await File(picked.path).readAsBytes();
      _fileName = picked.name;
      _base64Image = base64Encode(bytes);
      try {
        final response = await service.performGraphQLOperation(
          operationString: uploadMediaMutationString,
          operationType: OperationType.mutation,
          responseKey: "uploadBase64File",
          fromJson: MediaUploadModel.fromJson,
        );

        if (response?.responseModel.status ?? false) {
          _filePath = response!.uploadBase64Data.filePath;
          _fileName = response.uploadBase64Data.fileName;
        } else {
          _filePath = "No path from server";
          _fileName = "No name specified";
        }
      } catch (e) {
        _filePath = "No path from server";
        _fileName = "No name specified";
      } finally {
        notifyListeners();
      }
    }
  }

  void clearImage() {
    _base64Image = _fileName = _filePath = null;
    notifyListeners();
  }
}
