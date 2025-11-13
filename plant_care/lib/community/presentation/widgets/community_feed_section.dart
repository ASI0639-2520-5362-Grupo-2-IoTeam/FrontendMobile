import 'package:flutter/material.dart';
import 'community_feed_item.dart';
import 'expert_item.dart';

class CommunityFeedSection extends StatelessWidget {
  const CommunityFeedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // -------------------------------------------------
        //         COMMUNITY FEED
        // -------------------------------------------------
        const SizedBox(height: 16),
        const Text(
          "Community Feed",
          style: TextStyle(
            color: Color(0xFF2F3E2C),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        // POST 1
        const CommunityFeedItem(
          username: "Sarah Chen",
          timeAgo: "2 hours ago",
          text:
          "My Monstera finally grew a new leaf after 4 months! The fenestrations are coming in beautifully 🌿✨",
          imageUrl:
          "https://images.unsplash.com/photo-1501004318641-b39e6451bec6",
        ),

        const SizedBox(height: 16),

        // POST 2
        const CommunityFeedItem(
          username: "Marcus Rivera",
          timeAgo: "4 hours ago",
          text:
          "Anyone else struggling with their fiddle leaf fig dropping leaves? I've tried adjusting watering schedule but no luck so far. Any tips?",
        ),

        const SizedBox(height: 24),

        // -------------------------------------------------
        //           PLANT EXPERTS
        // -------------------------------------------------
        const Text(
          "Plant Experts",
          style: TextStyle(
            color: Color(0xFF2F3E2C),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        const ExpertItem(
          name: "Dr Plant Expert",
          specialty: "Tropical Plants",
          avatarUrl: "https://randomuser.me/api/portraits/men/32.jpg",
          isFollowing: false,
        ),

        const ExpertItem(
          name: "Green Thumb Guru",
          specialty: "Indoor Gardening",
          avatarUrl: "https://randomuser.me/api/portraits/women/19.jpg",
          isFollowing: true,
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
