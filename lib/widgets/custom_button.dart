import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isTextButton;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isTextButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (isTextButton) {
      // Optional TextButton mode
      return GestureDetector(
        onTap: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: colorScheme.primary,
          ),
        ),
      );
    } else {
      // Default ElevatedButton mode
      return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.green),
          foregroundColor: WidgetStatePropertyAll(colorScheme.onPrimary),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        child: Text(buttonText),
      );
    }
  }
}
