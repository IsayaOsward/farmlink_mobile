import 'defaults/default_response_model.dart';

class LocationResponse {
  final DefaultResponseModel response;
  final List<LocationData> data;

  LocationResponse({
    required this.response,
    required this.data,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      response: DefaultResponseModel.fromJson(json['response']),
      data: (json['data'] as List<dynamic>)
          .map((e) => LocationData.fromJson(e))
          .toList(),
    );
  }

  factory LocationResponse.empty() {
    return LocationResponse(
      response: DefaultResponseModel(
        id: '0',
        status: false,
        code: 4000,
        message: 'No data',
      ),
      data: [],
    );
  }

  Map<String, dynamic> toJson() => {
        'response': response.toJson(),
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class LocationData {
  final String id;
  final String uniqueId;
  final String name;
  final String code;

  LocationData({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.code,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      id: json['id'].toString(),
      uniqueId: json['uniqueId'].toString(),
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uniqueId': uniqueId,
        'name': name,
        'code': code,
      };
}
