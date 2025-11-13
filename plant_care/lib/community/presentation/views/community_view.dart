import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../presentation/widgets/custom_bottom_navbar.dart';

/// COMMUNITY MODULE
import '../../application/providers/post_provider.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../data/datasources/post_api_datasource.dart';

import '../widgets/community_feed_item.dart';
import '../widgets/expert_item.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {

    // ---------- PROVIDER LOCAL SOLO PARA ESTA PANTALLA ----------
    return ChangeNotifierProvider(
      create: (_) {
        /// Inyección local del módulo Community
        final dataSource = PostApiDataSource(
          baseUrl: "https://plantcare-awcchhb2bfg3hxgf.canadacentral-01.azurewebsites.net",
        );
        final repository = PostRepositoryImpl(dataSource);
        final usecase = GetPostsUsecase(repository);

        final provider = PostsProvider(usecase);
        provider.loadPosts(); // carga automática
        return provider;
      },

      child: Consumer<PostsProvider>(
        builder: (context, postsProvider, _) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F7F2),

            // ============= APP BAR =============
            appBar: AppBar(
              backgroundColor: const Color(0xFFF5F7F2),
              elevation: 0,
              centerTitle: false,
              title: const Text(
                "Community",
                style: TextStyle(
                  color: Color(0xFF2F3E2C),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8BC34A),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // abrir pantalla Create Post
                    },
                    child: const Text(
                      "Create Post",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),

            // ============= BODY =============
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ---------- LOADING ----------
                  if (postsProvider.isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF8BC34A),
                      ),
                    ),

                  // ---------- ERROR ----------
                  if (postsProvider.error != null)
                    Text(
                      "Error: ${postsProvider.error}",
                      style: const TextStyle(color: Colors.red),
                    ),

                  // ---------- FEED DINÁMICO ----------
                  if (!postsProvider.isLoading &&
                      postsProvider.error == null) ...[
                    const Text(
                      "Community Feed",
                      style: TextStyle(
                        color: Color(0xFF2F3E2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    for (final post in postsProvider.posts) ...[
                      CommunityFeedItem(
                        username: post.authorId,
                        timeAgo: post.createdAt.toIso8601String(),
                        text: post.content,
                        imageUrl: null,
                      ),
                      const SizedBox(height: 16),
                    ],

                    const SizedBox(height: 24),

                    // ---------- PLANT EXPERTS ----------
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
                      avatarUrl:
                      "https://randomuser.me/api/portraits/men/32.jpg",
                      isFollowing: false,
                    ),

                    const ExpertItem(
                      name: "Green Thumb Guru",
                      specialty: "Indoor Gardening",
                      avatarUrl:
                      "https://randomuser.me/api/portraits/women/19.jpg",
                      isFollowing: true,
                    ),

                    const SizedBox(height: 28),
                  ]
                ],
              ),
            ),

            // ============= BOTTOM NAV =============
            bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
          );
        },
      ),
    );
  }
}
