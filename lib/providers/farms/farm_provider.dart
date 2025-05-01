import 'dart:developer';

import 'package:farmlink/graphql/queries/farm_queries.dart';
import 'package:farmlink/models/farm_model.dart';
import 'package:farmlink/services/graphql_operation.dart';
import 'package:flutter/material.dart';

import '../../services/graphql_service_call.dart';

class FarmProvider extends ChangeNotifier {
  final graphQlService = GraphQLCallService();

  // These variables will store data for general farms and user-specific farms
  AllFarmsResponse _allFarmsResponseData = AllFarmsResponse.error();
  AllFarmsResponse _userSpecificFarmsResponseData = AllFarmsResponse.error();

  AllFarmsResponse get allFarmsResponseData => _allFarmsResponseData;
  AllFarmsResponse get userSpecificFarmsResponseData =>
      _userSpecificFarmsResponseData;

  // Fetch both general farms and user-specific farms
  Future fetchFarms({bool? isMine}) async {
    try {
      // General farms fetch (no user-specific filtering)
      final generalVariables = {
        "filtering": {
          "pageNumber": 1,
        }
      };

      final generalResult = await graphQlService.performGraphQLOperation(
        operationString: getAllFarmsQueryString,
        operationType: OperationType.query,
        responseKey: "getAllFarms",
        wrapInDataKey: true,
        variables: generalVariables,
        fromJson: AllFarmsResponse.fromJson,
      );

      if (generalResult!.response.status) {
        _allFarmsResponseData = generalResult;
      }

      if (isMine == true) {
        final userSpecificVariables = {
          "filtering": {
            "pageNumber": 1,
            "isMine": true,
          }
        };

        final userSpecificResult = await graphQlService.performGraphQLOperation(
          operationString: getAllFarmsQueryString,
          operationType: OperationType.query,
          responseKey: "getAllFarms",
          wrapInDataKey: true,
          variables: userSpecificVariables,
          fromJson: AllFarmsResponse.fromJson,
        );

        if (userSpecificResult!.response.status) {
          _userSpecificFarmsResponseData = userSpecificResult;
        }
      }
    } finally {
      notifyListeners();
    }
  }
}
