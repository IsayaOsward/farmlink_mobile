import '../base_url.dart';

final String clientId = 'e301b99d879ff72cd331';
final String clientSecret = 'd2109264054130f38f59253bf40bcbc545ab755d';
const passWordGrantType = 'password';
const refreshTokenGrantType = 'refresh_token';
const sessionTimeOut = 900000;
const apiCallTimeOut = 30;
final String loginUrls = '$baseUrl/oauth2/access_token';
final gqlServerUrl = '$baseUrl/graphql';
