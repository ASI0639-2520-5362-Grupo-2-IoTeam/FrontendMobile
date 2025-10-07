import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Map<String, dynamic>> execute({
    required String email,
    required String password,
  }) async {
    return await _repository.login(email: email, password: password);
  }
}