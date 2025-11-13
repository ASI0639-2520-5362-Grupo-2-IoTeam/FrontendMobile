import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getPosts(String token);

  Future<void> createPost({
    required String token,
    required String userId,
    required String title,
    required String content,
    required String species,
    required String tag,
  });

  Future<bool> registerMember(String userId, String token);
}
