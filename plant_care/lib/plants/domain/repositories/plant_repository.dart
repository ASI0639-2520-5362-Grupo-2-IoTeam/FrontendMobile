import 'package:plant_care/plants/domain/entities/plant.dart';

abstract class PlantRepository {
  /// Fetches a list of plants from the data source.
  Future<List<Plant>> fetchPlantsById(String id);

  /// Adds a new plant to the data source.
  Future<void> addPlant(Plant plant);

  /// Updates an existing plant in the data source.
  Future<void> updatePlant(String id, Plant plant);

  /// Deletes a plant from the data source by its ID.
  Future<void> deletePlant(String id);

  Future<List<Plant>> fetchPlantsByUserId(String userId, String token);
}