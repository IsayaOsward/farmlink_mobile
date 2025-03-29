import 'package:farmlink/widgets/custom_button.dart';
import 'package:farmlink/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class Registration extends StatelessWidget {
  Registration({super.key});
  final email = CustomTextFormField(label: "Email");
  final fullname = CustomTextFormField(label: "Full Name");
  final username = CustomTextFormField(label: "Username");
  final dealer = CustomTextFormField(label: "Dealer");
  final password = CustomTextFormField(label: "Password", obscureText: true);
  final confirmPassword =
      CustomTextFormField(label: "Confirm Password", obscureText: true);
  final submitButton =
      CustomButton(buttonText: "Create Account", onPressed: () {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              fullname,
              SizedBox(height: 16),
              username,
              SizedBox(height: 16),
              email,
              SizedBox(height: 16),
              dealer,
              SizedBox(height: 16),
              password,
              SizedBox(height: 16),
              confirmPassword,
              SizedBox(height: 32),
              SizedBox(width: double.infinity, child: submitButton),
            ],
          ),
        ),
      ),
    );
  }
}
