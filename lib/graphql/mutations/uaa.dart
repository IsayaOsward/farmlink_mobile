import '../default_graphql_objects.dart';

const userRegistrationMutationString = '''
mutation CreateUsersMutation(\$input: ProfileInputObject!) {
  createUsersMutation(input: \$input) {
    $defaultResponseObjectString
  }
}
''';

const String changePasswordMutation = """
mutation ChangePasswordMutation (\$input: ChangePasswordInputObject){
    changePasswordMutation(input: \$input) {
        $defaultResponseObjectString
    }
}
""";

const String forgotPasswordMutation = """
mutation ForgotPasswordMutation(\$userEmail: String!) {
      forgotPasswordMutation(userEmail: \$userEmail) {
          $defaultResponseObjectString
      }
    }
""";

const String resetPasswordMutation = """
    mutation ResetPasswordMutation(\$input: ResetPasswordInputObject!) {
      resetPasswordMutation(input: \$input) {
           $defaultResponseObjectString
      }
    }
  """;

const String activateAccountMutationString = '''
mutation activateOrResetPasswordMutation(\$input: SetOrResetPasswordInputObject) {
  activateOrResetPasswordMutation(input: \$input) {
    $defaultResponseObjectString
  }
}
''';
