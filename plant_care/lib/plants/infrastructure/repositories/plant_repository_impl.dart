

// DIP: Esta es la implementación concreta del repositorio abstracto.
// Es el "puente" entre el Datasource (datos crudos) y el Dominio (entidades).
// SRP: Su única responsabilidad es coordinar la obtención de datos.
import 'package:plant_care/plants/domain/entities/plant.dart';
import 'package:plant_care/plants/domain/repositories/plant_repository.dart';
import 'package:plant_care/plants/infrastructure/datasources/plant_remote_datasource.dart';

class PlantRepositoryImpl implements PlantRepository {
  final PlantRemoteDataSource remoteDataSource;
  // Podríamos añadir un localDataSource aquí para caché (Principio Open/Closed)

  PlantRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Plant>> getPlants(String userId, String token) async {
    try {
      // 1. Llama al datasource para obtener los DTOs (Models)
      final plantModels = await remoteDataSource.getPlants(userId, token);

      // 2. Mapea los DTOs a Entidades del Dominio
      // La UI y la lógica de negocio solo verán Entidades (Plant),
      // nunca DTOs (PlantModel).
      return plantModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      // Manejo de errores: Podríamos mapear errores específicos aquí.
      throw Exception('Error fetching plants: $e');
    }
  }
}