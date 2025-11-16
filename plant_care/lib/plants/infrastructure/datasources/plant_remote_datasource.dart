// Abstracción del Datasource (buena práctica para testing/mocks)
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plant_care/plants/infrastructure/models/plant_model.dart';

abstract class PlantRemoteDataSource {
  Future<List<PlantModel>> getPlants(String userId, String token);
}

// SRP: Esta clase solo sabe cómo hablar con el API (HTTP).
// No sabe nada de la lógica de dominio.
class PlantRemoteDataSourceImpl implements PlantRemoteDataSource {
  final http.Client client;

  PlantRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PlantModel>> getPlants(String userId, String token) async {
    // Hardcodeamos la URL base. En un app real, esto estaría en un config.
    final uri = Uri.parse('http://localhost:8090/api/v1/users/$userId/plants');

    try {
      final response = await client
          .get(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
              'accept': '*/*',
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        // Usamos el DTO (PlantModel) para parsear el JSON
        return body.map((json) => PlantModel.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid token');
      } else {
        throw Exception('Failed to load plants: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load plants: $e');
    }
  }
}
