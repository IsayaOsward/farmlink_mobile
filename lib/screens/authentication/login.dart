import 'package:farmlink/widgets/custom_button.dart';
import 'package:farmlink/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final username = CustomTextFormField(
    prefix: const HeroIcon(HeroIcons.userCircle),
    label: "Email",
  );

  final password = CustomTextFormField(
    label: "Password",
    prefix: const HeroIcon(HeroIcons.lockClosed),
  );

  final submitButton = CustomButton(buttonText: "Login", onPressed: () {});

  void _navigateToForgotPassword(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Forgot Password screen')),
    );
  }

  void _navigateToCreateAccount(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Create Account screen')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background with 3/4 grey and 1/4 green
          Column(
            children: [
              Expanded(
                flex: 3, // 3/4 of the screen
                child: Container(
                  color: Colors.grey.shade400,
                ),
              ),
              Expanded(
                flex: 1, // 1/4 of the screen
                child: Container(
                  color: Colors.green,
                ),
              ),
            ],
          ),
          // Foreground content
          Column(
            children: [
              // Centered Titles at the top
              Expanded(
                flex: 4, // Allocate space for titles at the top
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SMART",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.1,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "FARMLINK APP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Form container that extends downward
              Expanded(
                flex: 3, // Allocate more space for the form
                child: Align(
                  alignment: Alignment.bottomCenter,
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
                        borderRadius: BorderRadius.circular((30))),
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: screenHeight * 0.4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            username,
                            SizedBox(height: screenHeight * 0.02),
                            password,
                            SizedBox(height: screenHeight * 0.01),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () =>
                                    _navigateToForgotPassword(context),
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            submitButton,
                            SizedBox(height: screenHeight * 0.02),
                            Center(
                              child: TextButton(
                                onPressed: () =>
                                    _navigateToCreateAccount(context),
                                child: const Text(
                                  "Don't have an account? Create an account",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
