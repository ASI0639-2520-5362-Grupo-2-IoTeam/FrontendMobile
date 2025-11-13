import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<PostEntity>> call(String token) {
    return repository.getPosts(token);
  }
}
