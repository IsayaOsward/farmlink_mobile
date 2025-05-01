

import 'defaults/default_page_model.dart';
import 'defaults/default_response_model.dart';

class AssetRequestResponse {
  final DefaultResponseModel response;
  final PageObject page;
  final List<AssetRequestData> data;

  AssetRequestResponse({
    required this.response,
    required this.page,
    required this.data,
  });

  factory AssetRequestResponse.fromJson(Map<String, dynamic> json) {
    return AssetRequestResponse(
      response: DefaultResponseModel.fromJson(json['response']),
      page: PageObject.fromJson(json['page']),
      data: (json['data'] as List<dynamic>)
          .map((e) => AssetRequestData.fromJson(e))
          .toList(),
    );
  }

  factory AssetRequestResponse.empty() {
    return AssetRequestResponse(
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

class AssetRequestData {
  final List<NonConsumableAssetsObject> assetRequested;
  final String uniqueId;
  final String status;
  final String description;
  final DateTime createdAt;

  AssetRequestData({
    required this.assetRequested,
    required this.uniqueId,
    required this.status,
    required this.description,
    required this.createdAt,
  });

  factory AssetRequestData.fromJson(Map<String, dynamic> json) {
    return AssetRequestData(
      assetRequested: (json['assetRequested'] as List<dynamic>)
          .map((e) => NonConsumableAssetsObject.fromJson(e))
          .toList(),
      uniqueId: json['uniqueId'].toString(),
      status: json['status'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  factory AssetRequestData.empty() {
    return AssetRequestData(
      assetRequested: [],
      uniqueId: '',
      status: '',
      description: '',
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'assetRequested': assetRequested.map((e) => e.toJson()).toList(),
        'uniqueId': uniqueId,
        'status': status,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
      };
}

class NonConsumableAssetsObject {
  final String uniqueId;
  final String assetName;
  final String assetQrCode;
  final String assetTagId;
  final String assetDescription;
  final LocationObject assetLocation;
  final LocationObject assignedLocation;
  final String assetCurrentState;
  final NonConsumableTypeAssetObject assetType;
  final bool assetIsAssigned;

  NonConsumableAssetsObject({
    required this.uniqueId,
    required this.assetName,
    required this.assetQrCode,
    required this.assetTagId,
    required this.assetDescription,
    required this.assetLocation,
    required this.assignedLocation,
    required this.assetCurrentState,
    required this.assetType,
    required this.assetIsAssigned,
  });

  factory NonConsumableAssetsObject.fromJson(Map<String, dynamic> json) {
    return NonConsumableAssetsObject(
      uniqueId: json['uniqueId'].toString(),
      assetName: json['assetName'],
      assetQrCode: json['assetQrCode'],
      assetTagId: json['assetTagId'],
      assetDescription: json['assetDescription'],
      assetLocation: LocationObject.fromJson(json['assetLocation']),
      assignedLocation: LocationObject.fromJson(json['assignedLocation']),
      assetCurrentState: json['assetCurrentState'],
      assetType: NonConsumableTypeAssetObject.fromJson(json['assetType']),
      assetIsAssigned: json['assetIsAssigned'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uniqueId': uniqueId,
        'assetName': assetName,
        'assetQrCode': assetQrCode,
        'assetTagId': assetTagId,
        'assetDescription': assetDescription,
        'assetLocation': assetLocation.toJson(),
        'assignedLocation': assignedLocation.toJson(),
        'assetCurrentState': assetCurrentState,
        'assetType': assetType.toJson(),
        'assetIsAssigned': assetIsAssigned,
      };
}

class LocationObject {
  final String locationName;

  LocationObject({required this.locationName});

  factory LocationObject.fromJson(Map<String, dynamic> json) {
    return LocationObject(
      locationName: json['locationName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'locationName': locationName,
      };
}

class NonConsumableTypeAssetObject {
  final String typeCategory;
  final String name;

  NonConsumableTypeAssetObject({
    required this.typeCategory,
    required this.name,
  });

  factory NonConsumableTypeAssetObject.fromJson(Map<String, dynamic> json) {
    return NonConsumableTypeAssetObject(
      typeCategory: json['typeCategory'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'typeCategory': typeCategory,
        'name': name,
      };
}
