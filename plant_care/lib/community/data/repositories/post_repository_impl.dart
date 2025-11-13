import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_api_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiDataSource datasource;

  PostRepositoryImpl(this.datasource);

  @override
  Future<List<PostEntity>> getPosts(String token) async {
    final dtos = await datasource.getPosts(token);
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<void> createPost({
    required String token,
    required String userId,
    required String title,
    required String content,
    required String species,
    required String tag,
  }) async {
    await datasource.createPost(
      token: token,
      userId: userId,
      title: title,
      content: content,
      species: species,
      tag: tag,
    );
  }

  @override
  Future<bool> registerMember(String userId, String token) {
    return datasource.registerMember(userId, token);
  }
}
