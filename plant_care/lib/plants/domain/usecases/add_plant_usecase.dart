import 'package:plant_care/plants/domain/repositories/plant_repository.dart';

import '../entities/plant.dart';

class AddPlantUseCase {
  final PlantRepository repository;

  AddPlantUseCase(this.repository);

  Future<Plant> call(Plant plant) async {
    await repository.addPlant(plant);
    return plant;
  }
}