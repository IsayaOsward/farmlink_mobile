import 'package:farmlink/graphql/default_graphql_objects.dart';

const String uploadMediaMutationString = '''
mutation UploadBase64File(\$input: Base64FileInputObjects!) {
  uploadBase64File(input: \$input) {
    $defaultResponseObjectString
    data {
      filePath
      fileName
    }
  }
}
''';
