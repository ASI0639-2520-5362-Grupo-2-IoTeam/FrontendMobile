import '../repositories/post_repository.dart';

class CreatePostUseCase {
  final PostRepository repository;

  CreatePostUseCase(this.repository);

  Future<void> call({
    required String token,
    required String userId,
    required String title,
    required String content,
    required String species,
    required String tag,
  }) {
    return repository.createPost(
      token: token,
      userId: userId,
      title: title,
      content: content,
      species: species,
      tag: tag,
    );
  }
}
