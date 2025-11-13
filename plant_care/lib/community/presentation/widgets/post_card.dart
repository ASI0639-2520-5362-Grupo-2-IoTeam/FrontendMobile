import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String author;
  final String content;
  final String? imageUrl;
  final String createdAt;
  final int likes;
  final int comments;

  const PostCard({
    super.key,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.likes,
    required this.comments,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- HEADER ----------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                    "https://www.w3schools.com/howto/img_avatar.png"),
              ),
              const SizedBox(width: 12),

              // Text column must be flexible to avoid overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AUTHOR (ELIPSIS PARA UUID LARGOS)
                    Text(
                      author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      createdAt,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // More icon
              const Icon(Icons.more_horiz, size: 22),
            ],
          ),

          const SizedBox(height: 12),

          // ---------------- CONTENT ----------------
          Text(
            content,
            style: const TextStyle(fontSize: 15),
          ),

          if (imageUrl != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],

          const SizedBox(height: 16),

          // ---------------- FOOTER ----------------
          Row(
            children: [
              Icon(Icons.favorite_border,
                  size: 22, color: Colors.grey.shade700),
              const SizedBox(width: 6),
              Text("$likes"),

              const SizedBox(width: 20),

              Icon(Icons.mode_comment_outlined,
                  size: 22, color: Colors.grey.shade700),
              const SizedBox(width: 6),
              Text("$comments"),
            ],
          ),
        ],
      ),
    );
  }
}
