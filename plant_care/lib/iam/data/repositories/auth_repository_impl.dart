import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_api_service.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  /// ==========================
  /// 🔹 Registro de usuario
  /// ==========================
  @override
  Future<User> register({
    required String email,
    required String username,
    required String password,
    required String role,
  }) async {
    try {
      final response = await _apiService.register({
        'email': email,
        'username': username,
        'password': password,
        'role': role,
      });

      debugPrint("✅ Respuesta del backend (register): $response");

      // Si el backend devuelve el usuario, usamos esos datos.
      // Si no, generamos los faltantes localmente.
      return UserModel.fromJson({
        'id': response['id'] ?? const Uuid().v4(),
        'email': response['email'] ?? email,
        'username': response['username'] ?? username,
        'password': password,
        'role': response['role'] ?? role,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e, stack) {
      debugPrint("❌ Error en AuthRepositoryImpl.register(): $e");
      debugPrint(stack.toString());
      throw Exception("Error en AuthRepositoryImpl.register(): $e");
    }
  }

  /// ==========================
  /// 🔹 Inicio de sesión
  /// ==========================
  @override
  Future<Map<String, dynamic>> login({
  required String email,
  required String password,
}) async {
  final response = await _apiService.login({
    'email': email,
    'password': password,
  });

  // response debe ser Map<String, dynamic> desde tu API
  return {
    'token': response['token'],
    'uuid': response['uuid'],
    'username': response['username'],
  };
}
}