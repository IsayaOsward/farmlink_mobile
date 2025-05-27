import 'package:farmlink/utils/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/faq/faq_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/toasts.dart';

void showCreateFaqDialog(BuildContext context) {
  final qnController = TextEditingController();
  final ansController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => StatefulBuilder(
      builder: (context, setState) {
        Future<void> handleSubmit() async {
          if (!formKey.currentState!.validate()) return;

          showLoaderDialog(context);

          final faqProvider = Provider.of<FaqProvider>(context, listen: false);

          await faqProvider.createFaq(
            qnController.text.trim(),
            ansController.text.trim(),
          );

          final isSuccess = faqProvider.createFaqResponse?.status ?? false;

          Navigator.pop(context); // close loader
          Navigator.pop(context); // close form dialog

          showCustomSnackBar(
            context: context,
            message: isSuccess
                ? "FAQ created successfully!"
                : (faqProvider.createFaqResponse?.message ??
                    "Something went wrong."),
            infoType: isSuccess ? "success" : "error",
          );
        }

        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              "Create FAQ",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: qnController,
                    decoration: InputDecoration(
                      hintText: 'Question',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter a question";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: ansController,
                    decoration: InputDecoration(
                      hintText: 'Answer',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter an answer";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              label: const Text("Cancel"),
            ),
            CustomButton(
              buttonText: "Create",
              onPressed: handleSubmit,
            ),
          ],
        );
      },
    ),
  );
}

void showLoaderDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (_) {
      return const Center(
        child: CustomLoadingIndicator(),
      );
    },
  );
}
