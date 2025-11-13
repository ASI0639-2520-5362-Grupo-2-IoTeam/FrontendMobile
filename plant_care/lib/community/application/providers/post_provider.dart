import 'package:flutter/material.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_post_usecase.dart';
import '../../domain/usecases/create_post_usecase.dart';
import '../../domain/usecases/register_member_usecase.dart';

class PostProvider extends ChangeNotifier {
  final GetPostsUseCase getPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final RegisterMemberUseCase registerMemberUseCase;

  List<PostEntity> posts = [];
  bool loading = false;
  bool isMember = false;
  String? errorMessage;

  PostProvider({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.registerMemberUseCase,
  });

  Future<void> loadPosts(String token) async {
    loading = true;
    notifyListeners();

    try {
      posts = await getPostsUseCase(token);
    } catch (e) {
      errorMessage = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  Future<bool> register(String userId, String token) async {
    final result = await registerMemberUseCase(userId, token);
    isMember = result;
    notifyListeners();
    return result;
  }

  Future<bool> createPost({
    required String token,
    required String userId,
    required String title,
    required String content,
    required String species,
    required String tag,
  }) async {
    // Registrar si no es miembro
    if (!isMember) {
      final ok = await register(userId, token);
      if (!ok) {
        errorMessage = "No autorizado (403)";
        notifyListeners();
        return false;
      }
    }

    try {
      await createPostUseCase(
        token: token,
        userId: userId,
        title: title,
        content: content,
        species: species,
        tag: tag,
      );

      await loadPosts(token);
      return true;

    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
