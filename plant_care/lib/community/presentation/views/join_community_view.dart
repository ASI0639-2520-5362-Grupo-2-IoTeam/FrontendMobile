import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JoinCommunityView extends StatelessWidget {
  final String userId;
  final String baseUrl;

  const JoinCommunityView({
    super.key,
    required this.userId,
    required this.baseUrl,
  });

  Future<void> joinCommunity() async {
    final url = Uri.parse(
        "$baseUrl/api/community/members/register?userId=$userId");

    final response = await http.post(url);

    if (response.statusCode != 200) {
      throw Exception("Error joining community");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Join Community")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Join the Plant Community 🌱",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "To participate, we need to register your user ID. This will allow you to create posts, interact with others and explore the community feed.",
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await joinCommunity();
                  Navigator.pop(context, true);
                },
                child: const Text("Join Now"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
