import 'package:flutter/material.dart';
import '../../domain/entities/post_entitiy.dart';
import '../../domain/usecases/get_posts_usecase.dart';

class PostsProvider extends ChangeNotifier {
  final GetPostsUsecase getPostsUsecase;

  PostsProvider(this.getPostsUsecase);

  List<PostEntity> posts = [];
  bool isLoading = false;
  String? error;

  Future<void> loadPosts() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      posts = await getPostsUsecase();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
