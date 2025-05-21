import 'package:farmlink/graphql/default_graphql_objects.dart';

const String getAllRegionQueryString = """
query GetAllRegions {
  getAllRegions {
    $defaultResponseObjectString
    $defaultBodyResponseObject
  }
}
""";

const String getDistrictQueryString = """
query GetAllDistrict(\$regionUniqueId: String) {
  getAllDistrict(regionUniqueId: \$regionUniqueId) {
    $defaultResponseObjectString
    $defaultBodyResponseObject
  }
}
""";

const String getAWardQueryString = """
query getAllWards(\$districtUniqueId: String) {
  getAllWards(districtUniqueId: \$districtUniqueId) {
    $defaultResponseObjectString
    $defaultBodyResponseObject
  }
}
""";