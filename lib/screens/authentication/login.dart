import 'package:farmlink/routes/route_names.dart';
import 'package:farmlink/screens/home_pages/chat_page.dart';
import 'package:farmlink/screens/home_pages/main_page.dart';
import 'package:farmlink/utils/image_assets.dart';
import 'package:farmlink/widgets/custom_button.dart';
import 'package:farmlink/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final username = CustomTextFormField(
    prefix: const HeroIcon(HeroIcons.userCircle),
    label: "Email",
  );

  final password = CustomTextFormField(
    label: "Password",
    prefix: const HeroIcon(HeroIcons.lockClosed),
  );

  late final CustomButton submitButton;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true); // Makes it bounce continuously

    // Define scale animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Initialize submitButton
    submitButton = CustomButton(
      buttonText: "Login",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => MainScreen()),
        );
      },
    );
  }

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToForgotPassword(BuildContext context) {
    Navigator.pushNamed(
      context,
      FarmLinkRoutes.passwordResetScreen,
    );
  }

  void _navigateToCreateAccount(BuildContext context) {
    Navigator.pushNamed(context, FarmLinkRoutes.registrationScreen);
  }

  void _navigateToChatWithAI(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatPage()));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.grey.shade300,
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
                  SizedBox(
                    height: screenHeight * 0.4,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: screenWidth * 0.2,
                              height: screenWidth * 0.2,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Image.asset(ImageAssets.logo),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
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
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
      // Animated Floating Action Button
      floatingActionButton: ScaleTransition(
        scale: _scaleAnimation,
        child: FloatingActionButton(
          onPressed: () => _navigateToChatWithAI(context),
          backgroundColor: Colors.white,
          tooltip: 'Chat with AI',
          child: const Icon(
            Icons.email,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
