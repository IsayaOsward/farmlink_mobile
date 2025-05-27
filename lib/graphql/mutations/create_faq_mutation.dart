import 'package:farmlink/graphql/default_graphql_objects.dart';

const String createFaqMutationString = '''
mutation CreateFaqMutation(\$input: FAQsInputObject) {
  createFaqMutation(input: \$input) {
    $defaultResponseObjectString
  }
}
''';