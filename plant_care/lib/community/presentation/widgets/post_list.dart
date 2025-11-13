import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/providers/post_provider.dart';
import 'post_card.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();

    if (postProvider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final posts = postProvider.posts;

    if (posts.isEmpty) {
      return const Center(child: Text("No posts yet"));
    }

    return Column(
      children: posts
          .map((post) => PostCard(
        name: post.authorId,
        time: post.createdAt.toIso8601String(),
        content: post.content,
        imageUrl: null, // tu backend aún no devuelve imagen
        likes: 0,
        comments: 0,
      ))
          .toList(),
    );
  }
}
