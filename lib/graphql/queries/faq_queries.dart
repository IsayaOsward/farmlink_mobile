import '../default_graphql_objects.dart';

const fetchFaqQueryString = '''
query GetAllFaqs(\$filtering: FAQsFilteringInputObject) {
  getAllFaqs(filtering: \$filtering) {
    $defaultResponseObjectString
    data {
      id
      uniqueId
      question
      answer
      createdAt
    }
    $defaultPageObjectString
  }
}
''';
