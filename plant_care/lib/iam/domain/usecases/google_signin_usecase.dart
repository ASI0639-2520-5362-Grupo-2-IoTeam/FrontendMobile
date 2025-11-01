import 'dart:convert';
import 'package:http/http.dart' as http;


class GoogleSignInUseCase {
  final String baseUrl = "http://10.0.2.2:8090/api/v1/auth/google/mobile";

  Future<Map<String, dynamic>> execute(String idToken) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"googleToken": idToken}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error al autenticar con Google: ${response.body}");
    }
  }
}