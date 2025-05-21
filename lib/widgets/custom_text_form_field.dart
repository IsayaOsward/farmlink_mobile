import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/utility/image_picker_provider.dart';

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
  final bool isImagePicker;
  final TextEditingController? controller;

  // Dropdown-specific
  final bool isDropDown;
  final List<DropdownMenuItem<String>>? dropdownItems;

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
    this.isDropDown = false,
    this.dropdownItems,
    this.isImagePicker = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final inputDecoration = InputDecoration(
      labelText: label,
      hintText: hint,
      counterText: '',
      prefixIcon: prefix,
      suffixIcon: sufix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: colorScheme.primary),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: colorScheme.error),
        borderRadius: BorderRadius.circular(20),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    if (isDropDown) {
      return DropdownButtonFormField<String>(
        value: controller?.text.isNotEmpty == true ? controller!.text : null,
        items: dropdownItems ?? [],
        onChanged: (val) {
          if (controller != null && val != null) {
            controller!.text = val;
          }
        },
        validator: validator,
        decoration: inputDecoration,
      );
    }

    if (isImagePicker) {
      return Consumer<ImagePickerProvider>(
        builder: (context, imageProvider, _) {
          return GestureDetector(
            onTap: () async {
              await imageProvider.pickImage();
              controller?.text = imageProvider.base64Image ?? '';
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: controller,
                maxLines: 1,
                validator: validator,
                obscuringCharacter: '*',
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                cursorColor: colorScheme.primary,
                decoration: inputDecoration.copyWith(
                  hintText: imageProvider.base64Image != null
                      ? "Image Selected"
                      : hint,
                ),
              ),
            ),
          );
        },
      );
    }

    return TextFormField(
      controller: controller,
      maxLength: maxLength ?? 30,
      maxLines: maxLines ?? 1,
      validator: validator,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      cursorColor: colorScheme.primary,
      keyboardType: keyBoardType ?? TextInputType.name,
      decoration: inputDecoration,
    );
  }
}
