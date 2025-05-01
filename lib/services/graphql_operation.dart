import 'package:graphql_flutter/graphql_flutter.dart';

import '../configs/api/api_credentials.dart';
import '../configs/api/graphql_config_url.dart';

enum OperationType { query, mutation }

class GraphQLServiceOperation {
  static Future<QueryResult> executeOperation(
    String operationString,
    OperationType type, {
    Map<String, dynamic>? variables,
  }) async {
    final client = await GraphQLConfig.initializeClient();
    final gqlDoc = gql(operationString);
    final duration = Duration(seconds: apiCallTimeOut);

    late QueryResult result;

    if (type == OperationType.query) {
      final options = QueryOptions(
        document: gqlDoc,
        variables: variables ?? {},
        fetchPolicy: FetchPolicy.networkOnly,
        queryRequestTimeout: duration,
      );
      result = await client.query(options);
    } else {
      final options = MutationOptions(
        document: gqlDoc,
        variables: variables ?? {},
        queryRequestTimeout: duration,
      );
      result = await client.mutate(options);
    }

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    return result;
  }

  static Future<QueryResult> performQuery(String query,
      {Map<String, dynamic>? variables}) {
    return executeOperation(query, OperationType.query, variables: variables);
  }

  static Future<QueryResult> performMutation(String mutation,
      {Map<String, dynamic>? variables}) {
    return executeOperation(mutation, OperationType.mutation,
        variables: variables);
  }
}
