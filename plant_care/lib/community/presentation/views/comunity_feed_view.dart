import 'package:flutter/material.dart';
import 'package:provider/provider.dart';     // 👈 IMPORT NECESARIO PARA read() / watch()
import '../../../iam/presentation/providers/auth_provider.dart';
import '../../application/providers/post_provider.dart';
import '../widgets/post_list.dart';

class CommunityFeedView extends StatefulWidget {
  const CommunityFeedView({super.key});

  @override
  State<CommunityFeedView> createState() => _CommunityFeedViewState();
}

class _CommunityFeedViewState extends State<CommunityFeedView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final auth = context.read<AuthProvider>();
      final token = auth.token!;

      context.read<PostProvider>().loadPosts(token);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: PostList(),
      ),
    );
  }
}
