import 'package:farmlink/widgets/custom_button.dart';
import 'package:farmlink/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final email = CustomTextFormField(
    label: "Email",
    prefix: const Icon(Icons.email_outlined),
  );
  final fullname = CustomTextFormField(
    label: "Full Name",
    prefix: const Icon(Icons.person_outline),
  );
  final username = CustomTextFormField(
    label: "Username",
    prefix: const Icon(Icons.account_circle_outlined),
  );
  final dealer = CustomTextFormField(
    label: "Dealer",
    prefix: const Icon(Icons.store_outlined),
  );
  final password = CustomTextFormField(
    label: "Password",
    obscureText: true,
    prefix: const Icon(Icons.lock_outline),
  );
  final confirmPassword = CustomTextFormField(
    label: "Confirm Password",
    obscureText: true,
    prefix: const Icon(Icons.lock_outline),
  );

  CustomButton _buildSubmitButton(BuildContext context) {
    return CustomButton(
      buttonText: "Create Account",
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account creation submitted')),
        );
      },
    );
  }

  void _navigateBackToLogin(BuildContext context) {
    Navigator.pop(context); // Go back to the previous screen (Login)
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
        backgroundColor: Colors.green, // Match the green theme
        foregroundColor: Colors.white, // White text/icon for contrast
      ),
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // Background with 3/4 grey and 1/4 green
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.grey.shade400,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            // Foreground content with scroll
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  // Adjusted top spacing to account for AppBar
                  SizedBox(height: screenHeight * 0.05),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.05,
                        horizontal: screenWidth * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            fullname,
                            SizedBox(height: screenHeight * 0.02),
                            username,
                            SizedBox(height: screenHeight * 0.02),
                            email,
                            SizedBox(height: screenHeight * 0.02),
                            dealer,
                            SizedBox(height: screenHeight * 0.02),
                            password,
                            SizedBox(height: screenHeight * 0.02),
                            confirmPassword,
                            SizedBox(height: screenHeight * 0.02),
                            _buildSubmitButton(context),
                            SizedBox(height: screenHeight * 0.02),
                            Center(
                              child: TextButton(
                                onPressed: () => _navigateBackToLogin(context),
                                child: const Text(
                                  "Back to Login",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
