
import 'package:plant_care/plants/data/datasources/plant_api_service.dart';

import '../../domain/entities/plant.dart';
import '../../domain/repositories/plant_repository.dart';
import '../../data/models/plant_model.dart';

class PlantRepositoryImpl implements PlantRepository {
  final PlantApiService apiService;

  PlantRepositoryImpl({required this.apiService});

  @override
  Future<List<Plant>> fetchPlantsById(String id) async {
    final plant = await apiService.getPlantById(id);
    if (plant == null) return [];
    return [plant];
  }

  @override
  Future<void> addPlant(Plant plant) async {
    final model = PlantModel(
      id: plant.id,
      userId: plant.userId,
      name: plant.name,
      type: plant.type,
      imgUrl: plant.imgUrl,
      humidity: plant.humidity,
      lastWatered: plant.lastWatered,
      nextWatering: plant.nextWatering,
      status: plant.status,
      bio: plant.bio,
    );

    await apiService.addPlant(model);
  }

  @override
  Future<void> updatePlant(String id, Plant plant) async {
    final model = PlantModel(
      id: plant.id,
      userId: plant.userId,
      name: plant.name,
      type: plant.type,
      imgUrl: plant.imgUrl,
      humidity: plant.humidity,
      lastWatered: plant.lastWatered,
      nextWatering: plant.nextWatering,
      status: plant.status,
      bio: plant.bio,
    );

    await apiService.updatePlant(id, model);
  }

  @override
  Future<void> deletePlant(String id) async {
    await apiService.deletePlant(id);
  }

  @override
Future<List<Plant>> fetchPlantsByUserId(String userId, String token) async {
  final List<PlantModel> models = await apiService.getPlantsByUserId(userId, token: token);
  return models.map((m) => Plant(
    id: m.id,
    userId: m.userId,
    name: m.name,
    type: m.type,
    imgUrl: m.imgUrl,
    humidity: m.humidity,
    lastWatered: m.lastWatered,
    nextWatering: m.nextWatering,
    status: m.status,
    bio: m.bio,
  )).toList();
}
}