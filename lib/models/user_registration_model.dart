class UserRegistration {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String userType;

  UserRegistration({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.userType,
  });

  Map<String, dynamic> toJson() {
    return {
      "input": {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phoneNumber,
        "photo": "https://s3.amazonaws.com/37assets/svn/765-default-avatar.png",
        "email": email,
        "accountType": userType,
      }
    };
  }
}
