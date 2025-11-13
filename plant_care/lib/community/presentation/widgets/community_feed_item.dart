import 'package:flutter/material.dart';

class CommunityFeedItem extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String text;
  final String? imageUrl;

  const CommunityFeedItem({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.text,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFB7D8A1),
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
          if (imageUrl != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl!, fit: BoxFit.cover),
            )
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.grey.shade700),
              const SizedBox(width: 6),
              Icon(Icons.chat_bubble_outline, color: Colors.grey.shade700),
              const SizedBox(width: 6),
              Icon(Icons.share, color: Colors.grey.shade700),
            ],
          )
        ],
      ),
    );
  }
}