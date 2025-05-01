import 'package:farmlink/graphql/default_graphql_objects.dart';

const String getAllFarmsQueryString = '''
query Query(\$filtering: FarmFilteringInputObject) {
  getAllFarms(filtering: \$filtering) {
    $defaultResponseObjectString
    $defaultPageObjectString
    data {
      id
      uniqueId
      name
      description
      owner {
        id
        uniqueId
        firstName
        lastName
        email
        phone
        photo
        accountType
        isActive
        createdDate
      }
      coverage
      location
      media {
        mediaType
        mediaPath
      }
      isActive
    }
  }
}
''';