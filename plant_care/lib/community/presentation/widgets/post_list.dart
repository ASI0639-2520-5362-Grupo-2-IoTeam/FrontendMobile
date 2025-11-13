import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../../iam/presentation/providers/auth_provider.dart';
import '../../application/providers/post_provider.dart';
import 'post_card.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();

    if (postProvider.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (postProvider.posts.isEmpty) {
      return const Center(
        child: Text(
          "No posts yet. Be the first to share something! 🌱",
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: postProvider.posts.length,
      itemBuilder: (context, index) {
        final auth = context.read<AuthProvider>();
        final post = postProvider.posts[index];

        final authorName = post.authorId == auth.currentUser!.id
            ? auth.currentUser!.username // mostrar username del usuario logeado
            : post.authorId.substring(0, 6) + "…"; // para otros usuarios

        return PostCard(
          author: authorName,
          content: post.content,
          createdAt: post.createdAt.toString().substring(0, 16),
          imageUrl: null,
          likes: 12,
          comments: 0,
        );
      },
    );
  }
}
