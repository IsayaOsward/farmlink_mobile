import 'package:flutter/material.dart';

import '../../graphql/queries/products_queries.dart';
import '../../models/product_model.dart';
import '../../services/graphql_operation.dart';
import '../../services/graphql_service_call.dart';

class ProductsProvider extends ChangeNotifier {
  GetAllProductsResponse _getAllProductsResponse =
      GetAllProductsResponse.error();
  GetAllProductsResponse get productsResponse => _getAllProductsResponse;

  final graphqlLservice = GraphQLCallService();

  Future<void> fetchProducts() async {
    final variables = {
      "filtering": {
        "pageNumber": 1,
      }
    };

    final result = await graphqlLservice.performGraphQLOperation(
      operationString: getAllProductQueryString,
      operationType: OperationType.query,
      responseKey: "getAllProducts",
      variables: variables,
      fromJson: GetAllProductsResponse.fromJson,
    );

    if (result!.response.status) {
      _getAllProductsResponse = result;
    }

    notifyListeners();
  }
}
