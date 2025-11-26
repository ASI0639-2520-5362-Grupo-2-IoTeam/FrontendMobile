import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plant_care/plants/application/usecases/get_plants.dart';
import 'package:plant_care/plants/domain/entities/plant.dart';

part 'plants_state.dart';

// El Cubit maneja la lógica de estado de la UI.
class PlantsCubit extends Cubit<PlantsState> {
  final GetPlants getPlants;

  // HARDCODEADO: Reemplaza esto con tu lógica de autenticación real
  final String _tempUserId = '0991f1df-2f4d-420e-b2bd-6874c96e6a58';
  final String _tempToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzaWRlcmFsQGdtYWlsLmNvbSIsInJvbGUiOiJVU0VSIiwiaWF0IjoxNzYzMjU1NjQwLCJleHAiOjE3NjMyNTkyNDB9.A-VNnT-mgE1FDMcDuqHH7FnJN1Hh5sEkwVo3_UAlvus';

  PlantsCubit({required this.getPlants}) : super(PlantsInitial());

  Future<void> fetchPlants() async {
    emit(PlantsLoading());
    try {
      final plants = await getPlants(userId: _tempUserId, token: _tempToken);
      emit(PlantsLoaded(plants: plants));
    } catch (e) {
      emit(PlantsError(message: e.toString()));
    }
  }
}
