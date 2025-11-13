import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final String name;
  final String time;

  const PostHeader({super.key, required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              "https://i.pravatar.cc/300"), // Avatar temporal
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        )
      ],
    );
  }
}
