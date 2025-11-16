// SRP: La única responsabilidad de esta clase es orquestar
// la obtención de plantas.
// Es la lógica de negocio pura de la aplicación.

import 'package:plant_care/plants/domain/entities/plant.dart';
import 'package:plant_care/plants/domain/repositories/plant_repository.dart';

class GetPlants {
  final PlantRepository repository;

  GetPlants(this.repository);

  // Usamos 'call' para que la clase sea "callable" como una función.
  Future<List<Plant>> call({required String userId, required String token}) {
    // Aquí podrías añadir lógica de negocio (ej. validaciones) si las hubiera.
    // YAGNI: Por ahora, solo llamamos al repositorio.
    return repository.getPlants(userId, token);
  }
}
