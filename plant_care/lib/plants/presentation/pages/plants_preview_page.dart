import 'package:flutter/material.dart';
import 'package:plant_care/plants/domain/entities/plant.dart';
import 'package:plant_care/plants/domain/entities/plant_metric.dart';
import 'package:plant_care/plants/domain/value_objetcs/plant_status.dart';
import 'package:plant_care/plants/presentation/pages/plant_detail_page.dart';
import 'package:plant_care/plants/presentation/widgets/plant_status_chip.dart';

/// A lightweight preview page that shows fake plants so the UI can be
/// validated without connecting to the API or Bloc layers.
class PlantsPreviewPage extends StatelessWidget {
  const PlantsPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            createdAt: now,
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
            createdAt: now,
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview: Mis Plantas'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: fakePlants.length,
        itemBuilder: (context, index) {
          final plant = fakePlants[index];
          return _buildPlantCard(context, plant);
        },
      ),
    );
  }

  Widget _buildPlantCard(BuildContext context, Plant plant) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(plant.imgUrl),
          onBackgroundImageError: (exception, stackTrace) =>
              const Icon(Icons.error),
          backgroundColor: Colors.black12,
        ),
        title: Text(plant.name, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(
          plant.type,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: PlantStatusChip(status: plant.status),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PlantDetailPage(plant: plant)),
          );
        },
      ),
    );
  }
}
