import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final int? maxLength;
  final int? maxLines;
  final Widget? prefix;
  final Widget? sufix;
  final bool? obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyBoardType;
  final TextEditingController? controller;
  const CustomTextFormField({
    super.key,
    required this.label,
    this.hint,
    this.validator,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.keyBoardType,
    this.prefix,
    this.sufix,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      maxLength: maxLength ?? 30,
      maxLines: maxLines ?? 1,
      validator: validator,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      cursorColor: colorScheme.primary,
      keyboardType: keyBoardType ?? TextInputType.name,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        counterText: '',
        prefixIcon: prefix,
        suffixIcon: sufix,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: colorScheme.error),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
      ),
    );
  }
}
