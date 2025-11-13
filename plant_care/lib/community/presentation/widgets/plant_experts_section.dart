import 'package:flutter/material.dart';

class PlantExpertsSection extends StatelessWidget {
  const PlantExpertsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- TITLE ----------
          Row(
            children: const [
              Icon(Icons.emoji_events, color: Color(0xFF66C27C)),
              SizedBox(width: 8),
              Text(
                "Plant Experts",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B2E13),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ---------- EXPERT 1 ----------
          _ExpertTile(
            avatarUrl:
            "https://i.pravatar.cc/150?img=5", // puedes cambiar avatar
            name: "Dr. Plant Expert",
            subtitle: "Horticulturist",
            tag: "Tropical Plants",
            followers: "12.5K",
            isFollowing: false,
          ),

          const SizedBox(height: 18),

          // ---------- EXPERT 2 ----------
          _ExpertTile(
            initials: "GTG",
            name: "Green Thumb Guru",
            subtitle: "Plant Care Specialist",
            tag: "Indoor Gardens",
            followers: "8.3K",
            isFollowing: true,
          ),
        ],
      ),
    );
  }
}

// ================== CARD DE EXPERTO ==================

class _ExpertTile extends StatelessWidget {
  final String? avatarUrl;
  final String? initials;
  final String name;
  final String subtitle;
  final String tag;
  final String followers;
  final bool isFollowing;

  const _ExpertTile({
    this.avatarUrl,
    this.initials,
    required this.name,
    required this.subtitle,
    required this.tag,
    required this.followers,
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar: imagen o iniciales
        CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xFFB4D9B7),
          backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
          child: avatarUrl == null
              ? Text(
            initials!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
              : null,
        ),

        const SizedBox(width: 14),

        // INFO
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A2A12)),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  // Tag
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xFFF4F7F3),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF3A4F3C),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Text(
                    "$followers followers",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        const SizedBox(width: 8),

        // BOTÓN FOLLOW / FOLLOWING
        _FollowButton(isFollowing: isFollowing),
      ],
    );
  }
}

// ================== BOTÓN FOLLOW ==================

class _FollowButton extends StatelessWidget {
  final bool isFollowing;

  const _FollowButton({required this.isFollowing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isFollowing ? Colors.white : const Color(0xFF66C27C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isFollowing ? Colors.grey.shade300 : Colors.transparent,
        ),
        boxShadow: [
          if (!isFollowing)
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Text(
        isFollowing ? "Following" : "Follow",
        style: TextStyle(
          color: isFollowing ? Colors.black87 : Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
