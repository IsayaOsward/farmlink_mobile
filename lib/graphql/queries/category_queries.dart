import '../default_graphql_objects.dart';

const String getAllCategoryQueryString = '''
query GetAllCategory(\$filtering: CategoryFilteringInputObject) {
  getAllCategory(filtering: \$filtering) {
    $defaultResponseObjectString
    $defaultPageObjectString
    data {
      id
      uniqueId
      name
      description
      media {
        mediaType
        mediaPath
      }
      isActive
      createdDate
    }
  }
}
''';