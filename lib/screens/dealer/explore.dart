import 'package:farmlink/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Explore Farms",
      ),
    );
  }
}