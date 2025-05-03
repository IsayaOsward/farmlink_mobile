import 'package:flutter/material.dart';

import '../../graphql/queries/category_queries.dart';
import '../../models/category_model.dart';
import '../../services/graphql_operation.dart';
import '../../services/graphql_service_call.dart';

class CategoryProvider extends ChangeNotifier {
  final graphQlService = GraphQLCallService();

  GetAllCategoryResponse _allCategoryResponseData =
      GetAllCategoryResponse.error();
  GetAllCategoryResponse get allCategoryResponseData =>
      _allCategoryResponseData;

  Future fetchAllCategories() async {
    try {
      final generalVariables = {
        "filtering": {
          "pageNumber": 1,
        }
      };

      final result = await graphQlService.performGraphQLOperation(
        operationString: getAllCategoryQueryString,
        operationType: OperationType.query,
        responseKey: "getAllCategory",
        variables: generalVariables,
        fromJson: GetAllCategoryResponse.fromJson,
      );

      if (result!.response.status) {
        _allCategoryResponseData = result;
      }
    } finally {
      notifyListeners();
    }
  }

  udpateCategory() {}
}
