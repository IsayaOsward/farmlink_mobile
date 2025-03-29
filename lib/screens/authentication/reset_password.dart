import 'package:farmlink/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final emailField = CustomTextFormField(label: "Email");
  final customButton =
      CustomButton(buttonText: "Reset Password", onPressed: () {});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          spacing: 20,
          children: [emailField, customButton],
        ),
      ),
    );
  }
}
