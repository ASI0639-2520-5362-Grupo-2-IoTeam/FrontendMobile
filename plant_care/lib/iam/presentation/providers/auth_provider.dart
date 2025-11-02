
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_care/iam/domain/entities/role.dart';
import 'package:plant_care/iam/domain/usecases/google_signin_usecase.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;

  User? _currentUser;
  String? _token;
  bool _isLoading = false;

  AuthProvider({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required GoogleSignInUseCase googleSignInUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _googleSignInUseCase = googleSignInUseCase;

  // ===== Getters =====
  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;

  // ===== Login =====
  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      final loginResponse =
          await _loginUseCase.execute(email: email, password: password);

      _token = loginResponse.token;

      _currentUser = User(
        id: loginResponse.id,
        email: loginResponse.email,
        username: loginResponse.username,
        password: loginResponse.password,
        role: loginResponse.role,
        createdAt: loginResponse.createdAt,
        updatedAt: loginResponse.updatedAt,
      );

      debugPrint("✅ Usuario logueado: ${_currentUser?.email}");
    } catch (e) {
      debugPrint("❌ Error al iniciar sesión: $e");
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // ===== Registro =====
  Future<void> register({
    required String email,
    required String username,
    required String password,
    String role = "USER",
  }) async {
    _setLoading(true);
    try {
      final user = await _registerUseCase.execute(
        email: email,
        username: username,
        password: password,
        role: role,
      );

      _currentUser = user;
      debugPrint("✅ Usuario registrado: ${_currentUser?.email}");
    } catch (e) {
      debugPrint("❌ Error al registrar usuario: $e");
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // ===== Google Sign-In =====
  Future<void> signInWithGoogle() async {
    _setLoading(true);
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint("🚫 Inicio de sesión cancelado por el usuario");
        return;
      }

      final googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      if (idToken == null) throw Exception("No se recibió idToken de Google");

      final response = await _googleSignInUseCase.execute(idToken);

      _token = response['token'] ?? response['jwt'];

      _currentUser = User(
        id: response['uuid'] ?? response['id'] ?? '',
        email: response['email'] ?? googleUser.email,
        username: response['username'] ?? googleUser.displayName ?? "Usuario",
        password: '',
        role: Role.user,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      debugPrint("✅ Usuario autenticado con Google: ${_currentUser?.email}");
    } catch (e) {
      debugPrint("❌ Error al iniciar sesión con Google: $e");
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // ===== Logout =====
  Future<void> logout() async {
    _currentUser = null;
    _token = null;
    await GoogleSignIn().signOut();
    notifyListeners();
  }

  // ===== Private helper =====
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}