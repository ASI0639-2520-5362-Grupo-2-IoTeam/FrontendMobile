import '../repositories/post_repository.dart';

class RegisterMemberUseCase {
  final PostRepository repository;

  RegisterMemberUseCase(this.repository);

  Future<bool> call(String userId, String token) {
    return repository.registerMember(userId, token);
  }
}
