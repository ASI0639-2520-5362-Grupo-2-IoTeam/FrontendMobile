import '../../domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> register({
    required String email,
    required String username,
    required String password,
    required String role,
  });

  // Cambiar de String a Map
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });
}