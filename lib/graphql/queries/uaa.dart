import 'package:farmlink/graphql/default_graphql_objects.dart';

const getUserProfileString = '''
query Query {
  getUserProfileAndRoles {
    $defaultResponseObjectString
    data {
      id
      uniqueId
      firstName
      lastName
      email
      phone
      photo
      accountType
    }
  }
}
''';
