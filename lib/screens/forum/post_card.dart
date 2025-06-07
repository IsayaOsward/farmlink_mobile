import 'package:farmlink/screens/forum/video_player.dart';
import 'package:flutter/material.dart';

import 'post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.avatarUrl),
                ),
                const SizedBox(width: 8),
                Text(post.username,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),

            // Text content
            Text(post.content),

            // Media (optional)
            if (post.mediaUrl != null && post.mediaType == MediaType.image)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(post.mediaUrl!),
                ),
              ),
            if (post.mediaUrl != null && post.mediaType == MediaType.video)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: VideoPlayerWidget(url: post.mediaUrl!),
              ),

            const SizedBox(height: 8),
            Divider(),
            Row(
              children: [
                Icon(Icons.comment, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text("Comment", style: TextStyle(color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
