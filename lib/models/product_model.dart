import 'defaults/default_page_model.dart';
import 'defaults/default_response_model.dart';

class GetAllProductsResponse {
  final DefaultResponseModel response;
  final PageObject page;
  final List<ProductData> data;

  GetAllProductsResponse({
    required this.response,
    required this.page,
    required this.data,
  });

  factory GetAllProductsResponse.fromJson(Map<String, dynamic> json) {
    return GetAllProductsResponse(
      response: DefaultResponseModel.fromJson(json['response']),
      page: PageObject.fromJson(json['page']),
      data: (json['data'] as List<dynamic>)
          .map((e) => ProductData.fromJson(e))
          .toList(),
    );
  }

  factory GetAllProductsResponse.error() {
    return GetAllProductsResponse(
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

class ProductData {
  final String id;
  final String uniqueId;
  final String name;
  final String description;
  final String pricePerUnit;
  final int inStockAmount;
  final String unitMeasure;
  final String category;
  final ProductOwner owner;
  final List<ProductMedia> media;
  final bool publishToMarket;
  final bool isActive;
  final String createdDate;
  final String updatedDate;

  ProductData({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.description,
    required this.pricePerUnit,
    required this.inStockAmount,
    required this.unitMeasure,
    required this.category,
    required this.owner,
    required this.media,
    required this.publishToMarket,
    required this.isActive,
    required this.createdDate,
    required this.updatedDate,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      uniqueId: json['uniqueId'],
      name: json['name'],
      description: json['description'],
      pricePerUnit: json['pricePerUnit'],
      inStockAmount: json['inStockAmount'],
      unitMeasure: json['unitMeasure'],
      category: json['category'],
      owner: ProductOwner.fromJson(json['owner']),
      media: (json['media'] as List<dynamic>)
          .map((e) => ProductMedia.fromJson(e))
          .toList(),
      publishToMarket: json['publishToMarket'],
      isActive: json['isActive'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uniqueId': uniqueId,
        'name': name,
        'description': description,
        'pricePerUnit': pricePerUnit,
        'inStockAmount': inStockAmount,
        'unitMeasure': unitMeasure,
        'category': category,
        'owner': owner.toJson(),
        'media': media.map((e) => e.toJson()).toList(),
        'publishToMarket': publishToMarket,
        'isActive': isActive,
        'createdDate': createdDate,
        'updatedDate': updatedDate,
      };
}

class ProductOwner {
  final String uniqueId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String photo;

  ProductOwner({
    required this.uniqueId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.photo,
  });

  factory ProductOwner.fromJson(Map<String, dynamic> json) {
    return ProductOwner(
      uniqueId: json['uniqueId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uniqueId': uniqueId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'photo': photo,
      };
}

class ProductMedia {
  final String mediaType;
  final String mediaPath;

  ProductMedia({
    required this.mediaType,
    required this.mediaPath,
  });

  factory ProductMedia.fromJson(Map<String, dynamic> json) {
    return ProductMedia(
      mediaType: json['mediaType'],
      mediaPath: json['mediaPath'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mediaType': mediaType,
        'mediaPath': mediaPath,
      };
}
