import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import '../../widgets/custom_app_bar.dart';
import 'post_card.dart';
import 'post_model.dart';

class ViewForum extends StatelessWidget {
  const ViewForum({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = List.generate(2, (index) => mockPosts[index]);

    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: HeroIcon(
          HeroIcons.arrowLeft,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: "Forum",
        subTitle: "Where Farmers and Growers Connect",
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostCard(post: post);
        },
      ),
    );
  }
}
