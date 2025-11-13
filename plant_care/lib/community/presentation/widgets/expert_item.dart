import 'package:flutter/material.dart';

class ExpertItem extends StatelessWidget {
  final String name;
  final String specialty;
  final String avatarUrl;
  final bool isFollowing;

  const ExpertItem({
    super.key,
    required this.name,
    required this.specialty,
    required this.avatarUrl,
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(specialty,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isFollowing
                  ? const Color(0xFFE3F2E1)
                  : const Color(0xFF8BC34A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isFollowing ? "Following" : "Follow",
              style: TextStyle(
                color: isFollowing ? Colors.green : Colors.white,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}