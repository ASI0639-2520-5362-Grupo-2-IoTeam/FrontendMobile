import '../../domain/entities/post_entitiy.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_api_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiDataSource dataSource;

  PostRepositoryImpl(this.dataSource);

  @override
  Future<List<PostEntity>> getPosts() async {
    final dtos = await dataSource.getPosts();
    return dtos.map((e) => e.toEntity()).toList();
  }
}
