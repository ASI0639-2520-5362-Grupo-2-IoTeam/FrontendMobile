import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthApiService {
  final String baseUrl;

  AuthApiService({this.baseUrl = 'http://10.0.2.2:8090/api/v1'});

  /// ==========================
  /// 🔹 Registro de usuario
  /// ==========================
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/auth/register');
    debugPrint('➡️ POST $url');
    debugPrint('📦 Body: $data');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    debugPrint('📥 Status: ${response.statusCode}');
    debugPrint('📨 Response: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isEmpty) {
        // El servidor no devuelve JSON, devolvemos los datos básicos
        return {
          "email": data["email"],
          "username": data["username"],
          "role": data["role"],
        };
      }

      try {
        final decoded = jsonDecode(response.body);

        // Validamos que contenga al menos email y username
        if (decoded is Map<String, dynamic>) {
          return decoded;
        } else {
          throw Exception("Respuesta inválida del servidor");
        }
      } catch (e) {
        debugPrint("⚠️ Respuesta no es JSON válido: $e");
        return {
          "email": data["email"],
          "username": data["username"],
          "role": data["role"],
        };
      }
    } else {
      throw Exception('Error al registrar usuario: ${response.body}');
    }
  }

  /// ==========================
  /// 🔹 Inicio de sesión
  /// ==========================
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl/auth/login');
    debugPrint("➡️ POST $uri");
    debugPrint("📦 Body: $data");

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    debugPrint("📥 Status: ${response.statusCode}");
    debugPrint("📨 Response: ${response.body}");

    if (response.statusCode == 200) {
      try {
        final decoded = jsonDecode(response.body);

        // Si el backend devuelve token y algunos datos de usuario
        if (decoded is Map<String, dynamic>) {
          return decoded;
        } else {
          throw Exception("Formato inválido de respuesta");
        }
      } catch (e) {
        throw Exception("Error al procesar respuesta del login: $e");
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      throw Exception('Credenciales incorrectas o acceso denegado');
    } else {
      throw Exception('Error al iniciar sesión: ${response.body}');
    }
  }
}