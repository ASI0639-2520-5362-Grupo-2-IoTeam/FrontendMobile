import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/widgets/custom_bottom_navbar.dart';
import '../views/comunity_feed_view.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: const CommunityFeedView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/create-post');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

}
