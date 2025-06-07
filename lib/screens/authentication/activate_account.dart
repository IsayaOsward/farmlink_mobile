import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../utils/image_assets.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart'; // Importing spin kit for loader

class ActivateAccount extends StatefulWidget {
  final String token;

  const ActivateAccount({super.key, required this.token});

  @override
  State<ActivateAccount> createState() => _ActivateAccountState();
}

class _ActivateAccountState extends State<ActivateAccount> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Function to build the button
  CustomButton _buildActivateButton(BuildContext context) {
    return CustomButton(
      buttonText: "Activate Account",
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final password = _passwordController.text;
          final confirmPassword = _confirmPasswordController.text;

          if (password != confirmPassword) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Passwords do not match")),
            );
            return;
          }

          // Call the API to activate the account
          try {
            await context.read<AuthProvider>().activateAccount(
                  token: widget.token,
                  password: password,
                  context: context,
                );
          } catch (e) {}
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // Background Colors
            Column(
              children: [
                Expanded(
                    flex: 3, child: Container(color: Colors.grey.shade200)),
                Expanded(flex: 1, child: Container(color: Colors.green)),
              ],
            ),
            // Content UI
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.4,
                    child: Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
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
                              child:
                                  Center(child: Image.asset(ImageAssets.logo)),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              "SMART",
                              style: TextStyle(
                                fontSize: screenWidth * 0.1,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "FARMLINK APP",
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
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.05,
                        horizontal: screenWidth * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextFormField(
                              label: "Password",
                              prefix: HeroIcon(HeroIcons.lockClosed),
                              controller: _passwordController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            CustomTextFormField(
                              label: "Confirm Password",
                              prefix: HeroIcon(HeroIcons.lockClosed),
                              controller: _confirmPasswordController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            _buildActivateButton(context),
                            SizedBox(height: screenHeight * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
            // Loading Overlay (will be shown if authProvider.isLoading is true)
            if (authProvider.isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
