import '../entities/post_entitiy.dart';
import '../repositories/post_repository.dart';

class GetPostsUsecase {
  final PostRepository repository;

  GetPostsUsecase(this.repository);

  Future<List<PostEntity>> call() {
    return repository.getPosts();
  }
}
