import 'package:farmlink/graphql/default_graphql_objects.dart';

const String getAllProductQueryString = '''
query GetAllProducts(\$filtering: ProductFilteringInputObject) {
  getAllProducts(filtering: \$filtering) {
    $defaultResponseObjectString,
    $defaultPageObjectString
    data {
      id
      uniqueId
      name
      description
      pricePerUnit
      inStockAmount
      unitMeasure
      category
      owner {
        uniqueId
        firstName
        lastName
        email
        phone
        photo
      }
      media {
        mediaType
        mediaPath
      }
      publishToMarket
      isActive
      createdDate
      updatedDate
    }
    page {
      number
      hasNextPage
      hasPreviousPage
      currentPageNumber
      nextPageNumber
      previousPageNumber
      numberOfPages
      totalElements
      pagesNumberArray
    }
  }
}
''';
