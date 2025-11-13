import '../entities/post_entitiy.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getPosts();
}
