import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommunityHeader extends StatelessWidget {
  const CommunityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT SIDE TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Community",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B2E13),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Connect with fellow plant enthusiasts and share your journey",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    color: Color(0xFF5F6A60),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // CREATE POST BUTTON
          ElevatedButton.icon(
            onPressed: () {
              context.push('/create-post');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6BCB77),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              elevation: 3,
              shadowColor: Colors.black12,
            ),
            icon: const Icon(Icons.add, size: 20, color: Colors.white),
            label: const Text(
              "Create Post",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
