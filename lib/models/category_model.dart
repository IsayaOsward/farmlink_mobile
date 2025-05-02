import 'dart:developer';

import 'defaults/default_page_model.dart';
import 'defaults/default_response_model.dart';

class GetAllCategoryResponse {
  final DefaultResponseModel response;
  final PageObject page;
  final List<CategoryData> data;

  GetAllCategoryResponse({
    required this.response,
    required this.page,
    required this.data,
  });

  factory GetAllCategoryResponse.fromJson(Map<String, dynamic> json) {
    log("===========$json==========");
    return GetAllCategoryResponse(
      response: DefaultResponseModel.fromJson(json['response']),
      page: PageObject.fromJson(json['page']),
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoryData.fromJson(e))
          .toList(),
    );
  }

  factory GetAllCategoryResponse.error() {
    return GetAllCategoryResponse(
      response: DefaultResponseModel(
        id: '0',
        status: false,
        code: 4000,
        message: 'No data',
      ),
      page: PageObject.error(),
      data: [],
    );
  }

  Map<String, dynamic> toJson() => {
        'response': response.toJson(),
        'page': page.toJson(),
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class CategoryData {
  final String id;
  final String uniqueId;
  final String name;
  final String description;
  final MediaObject media;
  final bool isActive;
  final DateTime createdDate;

  CategoryData({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.description,
    required this.media,
    required this.isActive,
    required this.createdDate,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'],
      uniqueId: json['uniqueId'],
      name: json['name'],
      description: json['description'],
      media: MediaObject.fromJson(json['media']),
      isActive: json['isActive'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uniqueId': uniqueId,
        'name': name,
        'description': description,
        'media': media.toJson(),
        'isActive': isActive,
        'createdDate': createdDate.toIso8601String(),
      };
}

class MediaObject {
  final String mediaType;
  final String mediaPath;

  MediaObject({
    required this.mediaType,
    required this.mediaPath,
  });

  factory MediaObject.fromJson(Map<String, dynamic> json) {
    return MediaObject(
      mediaType: json['mediaType'],
      mediaPath: json['mediaPath'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mediaType': mediaType,
        'mediaPath': mediaPath,
      };
}
