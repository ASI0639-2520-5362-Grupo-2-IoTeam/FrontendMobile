import 'package:flutter/material.dart';
import 'package:plant_care/plants/domain/entities/plant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_care/plants/domain/entities/plant_metric.dart';
import 'package:plant_care/plants/domain/value_objetcs/plant_status.dart';
import 'package:plant_care/plants/presentation/pages/plant_detail_page.dart';
import 'package:plant_care/plants/presentation/widgets/plant_status_chip.dart';
import 'package:plant_care/plants/presentation/cubit/plants_cubit.dart';

class PlantsListPage extends StatelessWidget {
  final bool useFakeData;

  const PlantsListPage({super.key, this.useFakeData = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Plantas'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: useFakeData
          ? _buildFakeList(context)
          : BlocBuilder<PlantsCubit, PlantsState>(
              builder: (context, state) {
                // Patrón State: Reaccionamos a los diferentes estados
                if (state is PlantsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is PlantsError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Error: ${state.message}'),
                    ),
                  );
                }
                if (state is PlantsLoaded) {
                  if (state.plants.isEmpty) {
                    return const Center(
                      child: Text('No tienes plantas registradas.'),
                    );
                  }
                  // Vista de la lista
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: state.plants.length,
                    itemBuilder: (context, index) {
                      final plant = state.plants[index];
                      return _buildPlantCard(context, plant);
                    },
                  );
                }
                // Estado inicial
                return const Center(child: Text('Iniciando...'));
              },
            ),
    );
  }

  // Build a fake list of plants for UI preview without touching API logic
  Widget _buildFakeList(BuildContext context) {
    final now = DateTime.now();
    final fakePlants = <Plant>[
      Plant(
        id: 1,
        userId: 'fake-user',
        name: 'Monstera Deliciosa',
        type: 'Monstera',
        imgUrl: 'https://images.unsplash.com/photo-1516728778615-2d590ea1856f',
        bio: 'A tropical plant with large, glossy leaves.',
        location: 'Living Room',
        status: PlantStatus.HEALTHY,
        lastWatered: now.subtract(const Duration(days: 3)),
        nextWatering: now.add(const Duration(days: 4)),
        metrics: [
          PlantMetric(
            deviceId: 'device-123',
            temperature: 22.5,
            humidity: 45,
            light: 300,
            soilHumidity: 30,
            createdAt: DateTime.now(),
          ),
        ],
      ),
      Plant(
        id: 2,
        userId: 'fake-user',
        name: 'Fiddle Leaf Fig',
        type: 'Ficus lyrata',
        imgUrl: 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6',
        bio: 'Popular indoor tree with large violin-shaped leaves.',
        location: 'Office',
        status: PlantStatus.WARNING,
        lastWatered: now.subtract(const Duration(days: 10)),
        nextWatering: now.add(const Duration(days: 1)),
        metrics: [
          PlantMetric(
            deviceId: 'device-456',
            temperature: 20,
            humidity: 40,
            light: 200,
            soilHumidity: 20,
            createdAt: DateTime.now(),
          ),
        ],
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: fakePlants.length,
      itemBuilder: (context, index) {
        final plant = fakePlants[index];
        return _buildPlantCard(context, plant);
      },
    );
  }

  // DRY: Extraemos el item de la lista a su propio método/widget
  Widget _buildPlantCard(BuildContext context, Plant plant) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: ListTile(
        // Imagen (KISS: usamos la URL directamente)
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(plant.imgUrl),
          onBackgroundImageError: (exception, stackTrace) =>
              const Icon(Icons.error),
          backgroundColor: Colors.black12,
        ),
        // Nombre y Tipo
        title: Text(plant.name, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(
          plant.type,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        // Status (Widget reutilizado)
        trailing: PlantStatusChip(status: plant.status),
        onTap: () {
          // Navegación a la página de detalles
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PlantDetailPage(plant: plant)),
          );
        },
      ),
    );
  }
}
