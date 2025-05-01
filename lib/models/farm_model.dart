import 'defaults/default_page_model.dart';
import 'defaults/default_response_model.dart';

class AllFarmsResponse {
  final DefaultResponseModel response;
  final PageObject page;
  final List<Farm> data;

  AllFarmsResponse({
    required this.response,
    required this.page,
    required this.data,
  });

  factory AllFarmsResponse.fromJson(Map<String, dynamic> json) {
    final farmsJson = json['data']?['getAllFarms'];
    return AllFarmsResponse(
      response: DefaultResponseModel.fromJson(farmsJson?['response'] ?? {}),
      page: PageObject.fromJson(farmsJson?['page'] ?? {}),
      data: (farmsJson?['data'] as List<dynamic>?)
              ?.map((e) => Farm.fromJson(e))
              .toList() ??
          [],
    );
  }

  factory AllFarmsResponse.error() {
    return AllFarmsResponse(
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

class Farm {
  final String id;
  final String uniqueId;
  final String name;
  final String description;
  final FarmOwner owner;
  final String coverage;
  final String location;
  final List<Media> media;

  Farm({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.description,
    required this.owner,
    required this.coverage,
    required this.location,
    required this.media,
  });

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      id: json['id'],
      uniqueId: json['uniqueId'],
      name: json['name'],
      description: json['description'],
      owner: FarmOwner.fromJson(json['owner']),
      coverage: json['coverage'],
      location: json['location'],
      media: (json['media'] as List<dynamic>)
          .map((e) => Media.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uniqueId': uniqueId,
        'name': name,
        'description': description,
        'owner': owner.toJson(),
        'coverage': coverage,
        'location': location,
        'media': media.map((e) => e.toJson()).toList(),
      };
}

class FarmOwner {
  final String id;
  final String uniqueId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String photo;
  final String accountType;
  final bool isActive;
  final String createdDate;

  FarmOwner({
    required this.id,
    required this.uniqueId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.photo,
    required this.accountType,
    required this.isActive,
    required this.createdDate,
  });

  factory FarmOwner.fromJson(Map<String, dynamic> json) {
    return FarmOwner(
      id: json['id'],
      uniqueId: json['uniqueId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      accountType: json['accountType'],
      isActive: json['isActive'],
      createdDate: json['createdDate'],
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
        'isActive': isActive,
        'createdDate': createdDate,
      };
}

class Media {
  final String mediaType;
  final String mediaPath;

  Media({
    required this.mediaType,
    required this.mediaPath,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      mediaType: json['mediaType'],
      mediaPath: json['mediaPath'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mediaType': mediaType,
        'mediaPath': mediaPath,
      };
}
