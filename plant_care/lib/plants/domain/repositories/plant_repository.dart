import 'package:plant_care/plants/domain/entities/plant.dart';


// DDD & DIP (Dependency Inversion Principle):
// Definimos la abstracción (el "qué").
// El 'application' layer dependerá de esto, no de la implementación.

abstract class PlantRepository {
  // Nota: En un app real, el userId y token vendrían de un feature de Auth.
  Future<List<Plant>> getPlants(String userId, String token);
}