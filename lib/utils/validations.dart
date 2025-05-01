import 'package:flutter/material.dart';

class Validator {
  // Email validation (strict format)
  static String? validateEmail(String? email, BuildContext context) {
    if (email == null || email.isEmpty) {
      return "Email is required";
    }
    // Regular expression for email validation
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    if (!regex.hasMatch(email.trim())) {
      return "Please enter a valid email";
    }
    return null;
  }

  // Password validation for login (ensure it's not empty)
  static String? validateLoginPassword(String? password, BuildContext context) {
    if (password == null || password.isEmpty) {
      return "Password is required";
    }
    return null;
  }

  // Strong password validation for registration
  static String? validateRegisterPassword(
      String? password, BuildContext context) {
    if (password == null || password.isEmpty) {
      return "Password is required";
    }

    List<String> missingCriteria = [];

    // Check if password is at least 8 characters long
    if (password.length < 8) {
      missingCriteria.add("Password must be at least 8 characters long");
    }

    // Check if password contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      missingCriteria
          .add("Password must contain at least one upper case character");
    }

    // Check if password contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      missingCriteria
          .add("Password must contain at least one upper case character");
    }

    // Check if password contains at least one digit
    if (!password.contains(RegExp(r'\d'))) {
      missingCriteria.add("Password must contain at least one digit");
    }

    // Check if password contains at least one special character
    if (!password.contains(RegExp(r'[@$!%*?&]'))) {
      missingCriteria.add(
          "Password must contain at least one special character"); // Use localized string
    }

    // If the missing criteria list is not empty, return the list of missing criteria
    if (missingCriteria.isNotEmpty) {
      return "Password must contain ${missingCriteria.join(', ')}";
    }

    // If all criteria are met, return null (password is valid)
    return null;
  }

  // Compare password and confirm password
  static String? validateConfirmPassword(
      String? password, String? confirmPassword, BuildContext context) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirm password is requried";
    }
    if (password != confirmPassword) {
      return "Passwords does not match";
    }
    return null;
  }

  // Name validation (no null, no numbers, no special characters)
  static String? validateName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    // Name should only contain alphabets and spaces (no numbers or special characters)
    String namePattern = r'^[a-zA-Z ]+$';
    RegExp regex = RegExp(namePattern);
    if (!regex.hasMatch(value)) {
      return "Invalid input";
    }
    return null;
  }

  // Phone number validation (must start with 0 and be exactly 10 digits)
  static String? validatePhoneNumber(
      String? phoneNumber, BuildContext context) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return "This field is required";
    }

    // Phone number pattern: starts with 0 and has exactly 10 digits
    String phonePattern = r'^0\d{9}$';
    RegExp regex = RegExp(phonePattern);

    if (!regex.hasMatch(phoneNumber)) {
      return "Phone number must start with 0 and be exactly 10 digits";
    }

    return null;
  }

  static String? validateAndFormatPhoneNumberV2(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }

    final trimmed = phoneNumber.trim();

    // Local format (e.g., 07XXXXXXXX)
    if (trimmed.startsWith('0') && trimmed.length == 10) {
      return null; // Considered valid, will be formatted before submission
    }

    // International format (e.g., 2557XXXXXXXX)
    if (trimmed.startsWith('255') && trimmed.length == 12) {
      return null; // Valid as-is
    }

    // Optional: Allow +255 format, will strip "+" before formatting
    if (trimmed.startsWith('+255') && trimmed.length == 13) {
      return null;
    }

    return 'Enter a valid phone number starting with 0 or 255';
  }

  static String? validateInternationalPhoneNumber(
      String? phoneNumber, BuildContext context) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return "This field is required";
    }

    if (phoneNumber.startsWith('0')) {
      // Must be 10 digits
      if (phoneNumber.length != 10) {
        return "Phone number must be exactly 10 digits if it starts with '0'";
      }
    } else if (phoneNumber.startsWith('+')) {
      // Must be 13 characters including '+'
      if (phoneNumber.length != 13) {
        return "Phone number must be exactly 13 characters including '+'";
      }
    } else {
      // Must be 12 digits
      if (phoneNumber.length != 12) {
        return "Phone number must be exactly 12 digits if it doesn't start with '0' or '+'";
      }
    }

    return null; // Validation passed
  }

  static String? validateAndFormatPhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }

    final trimmed = phoneNumber.trim();

    // Local format (e.g., 07XXXXXXXX)
    if (trimmed.startsWith('0') && trimmed.length == 10) {
      return null; // Considered valid, will be formatted before submission
    }

    // International format (e.g., 2557XXXXXXXX)
    if (trimmed.startsWith('255') && trimmed.length == 12) {
      return null; // Valid as-is
    }

    // Optional: Allow +255 format, will strip "+" before formatting
    if (trimmed.startsWith('+255') && trimmed.length == 13) {
      return null;
    }

    return 'Enter a valid phone number starting with 0 or 255';
  }

  // Number validation (ensure it's only digits, no strings)
  static String? validateNumber(String? number, BuildContext context) {
    if (number == null || number.isEmpty) {
      return "This field is required";
    }

    // Regular expression to allow numbers with optional decimals
    String numberPattern = r'^\d+(\.\d+)?$';
    RegExp regex = RegExp(numberPattern);
    if (!regex.hasMatch(number)) {
      return "Only valid numbers are allowed";
    }

    return null;
  }

  static String? validateTin(String value, BuildContext context) {
    if (value.isEmpty) {
      return "TIN number is required";
    }
    if (value.length != 9) {
      return "TIN number must be exactly 9 digits";
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return "TIN number must contain digits only";
    }
    return null;
  }

  /// Validates NIDA number to ensure it's exactly 20 digits
  static String? validateNida(String value, BuildContext context) {
    if (value.isEmpty) {
      return "NIDA number is required";
    }
    if (value.length != 20) {
      return "NIDA number must be exactly 20 digits";
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return "NIDA number must contain digits only";
    }
    return null;
  }

// Bank account number validation (8 to 17 digits)
  static String? validateBankAccountNumber(
      String? accountNumber, BuildContext context) {
    if (accountNumber == null || accountNumber.isEmpty) {
      return "This field is required";
    }
    // Regular expression to ensure the input only contains digits and length is between 8 and 17
    String accountPattern = r'^\d{8,17}$';
    RegExp regex = RegExp(accountPattern);
    if (!regex.hasMatch(accountNumber)) {
      return "Account number must be 8 to 17 digits long";
    }
    return null;
  }

  static String? validateAddress(String? address, BuildContext context) {
    if (address == null || address.isEmpty) {
      return "This field is required";
    }
    // Address can contain letters, numbers, spaces, and common address symbols
    String addressPattern = r'^[a-zA-Z0-9\s,.-]+$';
    RegExp regex = RegExp(addressPattern);
    if (!regex.hasMatch(address)) {
      return "Invalid address format";
    }
    return null;
  }

  static String? validateTextOrMessage(String? text, BuildContext context) {
    if (text == null || text.isEmpty) {
      return "This field is required";
    }
    // Text can contain alphanumeric characters, spaces, and common punctuation
    String textPattern = r"""^[a-zA-Z0-9\s.,?!\'"-]+$""";
    RegExp regex = RegExp(textPattern);
    if (!regex.hasMatch(text)) {
      return "Invalid text or message format";
    }
    return null;
  }

  // OTP validation method: checks if input is a number and matches a specified length
  static String? validateOtp(
      String? otp, int requiredLength, BuildContext context) {
    if (otp == null || otp.isEmpty) {
      return "This field is required";
    }

    // Ensure the input only contains digits
    String numberPattern = r'^\d+$';
    RegExp regex = RegExp(numberPattern);
    if (!regex.hasMatch(otp)) {
      return "Only numbers are allowed";
    }

    // Check if the input length matches the required OTP length
    if (otp.length != requiredLength) {
      return "OTP must be exactly $requiredLength digits";
    }

    return null; // If all checks pass, return null (no error)
  }

  static String? validateDropDownInput(String? value, BuildContext context) {
    if (value == null) {
      return "Please select one of the options provided";
    }
    return null;
  }
}


String formatPhoneNumber(String rawNumber) {
  final trimmed = rawNumber.trim();
  if (trimmed.startsWith('0') && trimmed.length == 10) {
    return '255${trimmed.substring(1)}';
  } else if (trimmed.startsWith('+255') && trimmed.length == 13) {
    return trimmed.substring(1); // Remove the '+'
  } else {
    return trimmed; // Assume it's already in 255XXXXXXXXX format
  }
}
