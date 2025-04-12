import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../../widgets/custom_app_bar.dart';

class CategoryItems extends StatelessWidget {
  final String categoryName;
  const CategoryItems({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: GestureDetector(
          onTap: () => Navigator.pop(
            context,
          ),
          child: HeroIcon(
            HeroIcons.arrowLeft,
          ),
        ),
        title: categoryName,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height,
            minWidth: MediaQuery.sizeOf(context).width,
          ),
          child: Center(
            child: Text(
              "Items",
            ),
          ),
        ),
      ),
    );
  }
}
