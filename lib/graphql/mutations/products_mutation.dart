import 'package:farmlink/graphql/default_graphql_objects.dart';

const createProductMutationString = '''
mutation Mutation(\$input: ProductInputObject) {
  createProductMutation(input: \$input) {
    $defaultResponseObjectString
  }
}
''';