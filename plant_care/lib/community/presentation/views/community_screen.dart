import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../presentation/widgets/custom_bottom_navbar.dart';
import '../views/comunity_feed_view.dart';
import '../widgets/community_header.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // CONTENT
      body: Column(
        children: const [
          CommunityHeader(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CommunityFeedView(),

            ),
          ),
        ],

      ),



      // NAVBAR
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}
