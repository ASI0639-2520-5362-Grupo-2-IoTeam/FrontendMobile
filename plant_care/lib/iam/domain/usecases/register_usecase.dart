import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<User> execute({
    required String email,
    required String username,
    required String password,
    required String role,
  }) {
    return _repository.register(
      email: email,
      username: username,
      password: password,
      role: role,
    );
  }
}