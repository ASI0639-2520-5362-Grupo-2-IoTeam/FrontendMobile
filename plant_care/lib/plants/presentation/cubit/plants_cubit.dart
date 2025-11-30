import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plant_care/plants/application/usecases/get_plants.dart';
import 'package:plant_care/plants/domain/entities/plant.dart';

part 'plants_state.dart';


class PlantsCubit extends Cubit<PlantsState> {
  final GetPlants getPlants;
  final String userId;
  final String token;

  PlantsCubit({
    required this.getPlants,
    required this.userId,
    required this.token,
  }) : super(PlantsInitial());

  Future<void> fetchPlants() async {
    emit(PlantsLoading());
    try {
      final plants = await getPlants(userId: userId, token: token);
      emit(PlantsLoaded(plants: plants));
    } catch (e) {
      emit(PlantsError(message: e.toString()));
    }
  }
}
