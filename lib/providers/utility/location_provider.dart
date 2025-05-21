import 'package:farmlink/services/graphql_operation.dart';
import 'package:flutter/material.dart';

import '../../graphql/queries/location_queries.dart';
import '../../models/location_model.dart';
import '../../services/graphql_service_call.dart';

class LocationProvider extends ChangeNotifier {
  final graphqlLservice = GraphQLCallService();
  bool isSubmitEnabled = false;

  LocationResponse regionData = LocationResponse.empty();
  LocationResponse districtData = LocationResponse.empty();
  LocationResponse wardData = LocationResponse.empty();
  String? selectedValue;

  
  Future<void> getAllRegions() async {
    if (regionData.data.isEmpty) {
      final response = await graphqlLservice.performGraphQLOperation(
        operationString: getAllRegionQueryString,
        operationType: OperationType.query,
        responseKey: "getAllRegions",
        fromJson: LocationResponse.fromJson,
      );
      if (response!.response.status) {
        regionData = response;
      }
    }
    notifyListeners();
  }

  Future<void> getDistrict({required String regionUniqueId}) async {
    final response = await graphqlLservice.performGraphQLOperation(
      operationString: getDistrictQueryString,
      operationType: OperationType.query,
      variables: {"regionUniqueId": regionUniqueId},
      responseKey: "getAllDistrict",
      fromJson: LocationResponse.fromJson,
    );

    if (response!.response.status) {
      districtData = response;
    }
    notifyListeners();
  }

  Future<void> getWards({required String districtUniqueId}) async {
    final response = await graphqlLservice.performGraphQLOperation(
      operationString: getAWardQueryString,
      operationType: OperationType.query,
      variables: {"districtUniqueId": districtUniqueId},
      responseKey: "getAllWards",
      fromJson: LocationResponse.fromJson,
    );

    if (response!.response.status) {
      wardData = response;
    }
    notifyListeners();
  }

  void clearAllSelections() {
    districtData.data.clear();
    wardData.data.clear();
    notifyListeners();
  }

  void clearWardData() {
    wardData.data.clear();
    notifyListeners();
  }

  void enableSubmit() {
    isSubmitEnabled = true;
    notifyListeners();
  }
}
