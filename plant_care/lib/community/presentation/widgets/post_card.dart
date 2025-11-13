import 'package:flutter/material.dart';
import 'post_header.dart';

class PostCard extends StatelessWidget {
  final String name;
  final String time;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;

  const PostCard({
    super.key,
    required this.name,
    required this.time,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(name: name, time: time),
          const SizedBox(height: 10),

          Text(
            content,
            style: const TextStyle(fontSize: 15, height: 1.3),
          ),
          const SizedBox(height: 10),

          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl!, height: 180, fit: BoxFit.cover),
            ),

          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.favorite_border, size: 20, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text("$likes"),
              const SizedBox(width: 16),
              Icon(Icons.mode_comment_outlined, size: 20, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text("$comments"),
              const Spacer(),
              Icon(Icons.bookmark_border, size: 20, color: Colors.grey[600]),
            ],
          )
        ],
      ),
    );
  }
}
