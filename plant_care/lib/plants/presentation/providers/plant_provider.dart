import 'package:flutter/material.dart';
import 'package:plant_care/plants/data/datasources/plant_api_service.dart';
import 'package:plant_care/plants/data/models/plant_model.dart';


class PlantProvider extends ChangeNotifier {
  final PlantApiService _apiService = PlantApiService();
  List<PlantModel> _plants = [];
  bool _isLoading = false;
  String? _message; 

  List<PlantModel> get plants => _plants;
  bool get isLoading => _isLoading;
  String? get message => _message;

  /// ⚡ Ahora recibe token además del userId
  Future<void> fetchPlantsByUserId({
    required String userId,
    required String token,
  }) async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    try {
      _plants = await _apiService.getPlantsByUserId(userId, token: token);

      if (_plants.isEmpty) {
        _message = "No hay plantas registradas 🌿";
      }

    } on Exception catch (e) {
      // Manejo específico de errores
      if (e.toString().contains('403')) {
        _message = "Acceso denegado: verifica tu token o permisos.";
      } else {
        _message = "Error al cargar plantas: $e";
      }
      debugPrint(_message);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}