import 'package:flutter/material.dart';

import '../../graphql/queries/products_queries.dart';
import '../../models/product_model.dart';
import '../../services/graphql_operation.dart';
import '../../services/graphql_service_call.dart';

class ProductsProvider extends ChangeNotifier {
  GetAllProductsResponse _getAllProductsResponse =
      GetAllProductsResponse.error();
  GetAllProductsResponse get productsResponse => _getAllProductsResponse;

  GetAllProductsResponse _filteredProductsResponse =
      GetAllProductsResponse.error();
  GetAllProductsResponse get filteredProductsResponse =>
      _filteredProductsResponse;

  final graphqlLservice = GraphQLCallService();

  Future<void> fetchProducts(
      {Map<String, dynamic>? additionalVariables}) async {
    final Map<String, dynamic> filtering = {
      "pageNumber": 1,
    };

    bool isFiltered = false;

    if (additionalVariables != null &&
        additionalVariables['filtering'] != null) {
      final additionalFiltering =
          additionalVariables['filtering'] as Map<String, dynamic>;
      filtering.addAll(additionalFiltering);
      isFiltered = true;
    }

    final variables = {
      "filtering": filtering,
    };

    final result = await graphqlLservice.performGraphQLOperation(
      operationString: getAllProductQueryString,
      operationType: OperationType.query,
      responseKey: "getAllProducts",
      variables: variables,
      fromJson: GetAllProductsResponse.fromJson,
    );

    if (result!.response.status) {
      if (isFiltered) {
        _filteredProductsResponse = result;
      } else {
        _getAllProductsResponse = result;
      }
    }

    notifyListeners();
  }
}
