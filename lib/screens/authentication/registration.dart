import 'package:farmlink/models/user_registration_model.dart';
import 'package:farmlink/utils/validations.dart';
import 'package:farmlink/widgets/custom_button.dart';
import 'package:farmlink/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../providers/auth_provider.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final userTypeController = TextEditingController();

  CustomButton _buildSubmitButton(BuildContext context) {
    return CustomButton(
      buttonText: "Create Account",
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);

          final userData = UserRegistration(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            phoneNumber: formatPhoneNumber(phoneNumberController.text),
            email: emailController.text,
            userType: userTypeController.text,
          );

          await authProvider.registerUser(userData: userData, context: context);

          if (!mounted) return;

          if (authProvider.registerSuccess) {
            // ✅ Clear fields
            firstNameController.clear();
            lastNameController.clear();
            phoneNumberController.clear();
            emailController.clear();
            userTypeController.clear();

            if (context.mounted) {
              _navigateBackToLogin(context);
            }
          }
        }
      },
    );
  }

  void _navigateBackToLogin(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    flex: 3, child: Container(color: Colors.grey.shade400)),
                Expanded(flex: 1, child: Container(color: Colors.green)),
              ],
            ),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.05),
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
                              label: "First Name",
                              controller: firstNameController,
                              validator: (value) =>
                                  Validator.validateName(value, context),
                              prefix: const HeroIcon(HeroIcons.userCircle),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            CustomTextFormField(
                              label: "Last Name",
                              controller: lastNameController,
                              validator: (value) =>
                                  Validator.validateName(value, context),
                              prefix: const HeroIcon(HeroIcons.userCircle),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            CustomTextFormField(
                              label: "Phone number",
                              keyBoardType: TextInputType.phone,
                              maxLength: 12,
                              controller: phoneNumberController,
                              validator: (value) =>
                                  Validator.validateAndFormatPhoneNumber(value),
                              prefix: const HeroIcon(HeroIcons.phone),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            CustomTextFormField(
                              controller: emailController,
                              label: "Email",
                              validator: (value) =>
                                  Validator.validateEmail(value, context),
                              prefix: const HeroIcon(HeroIcons.envelope),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            CustomTextFormField(
                              label: "Account Type",
                              isDropDown: true,
                              controller: userTypeController,
                              validator: (value) =>
                                  Validator.validateDropDownInput(
                                      value, context),
                              dropdownItems: const [
                                DropdownMenuItem(
                                    value: "DEALER", child: Text("Dealer")),
                                DropdownMenuItem(
                                    value: "PRODUCER", child: Text("Producer")),
                              ],
                            ),
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
            if (authProvider.isLoading) ...[
              const Opacity(
                opacity: 0.5,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
              const Center(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
