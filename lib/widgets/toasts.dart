import 'package:flutter/material.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  required String infoType, // 'success', 'error', 'warning', or 'info'
}) {
  // Define the background color based on the info type
  Color backgroundColor;
  switch (infoType) {
    case 'success':
      backgroundColor = Colors.green;
      break;
    case 'warning':
      backgroundColor = Colors.orange;
      break;
    case 'info':
      backgroundColor = Colors.blue;
      break;
    case 'error':
      backgroundColor = Colors.red;
      break;
    default:
      backgroundColor = Colors.grey;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white, // Text color is always white
            ),
      ),
    ),
  );
}
