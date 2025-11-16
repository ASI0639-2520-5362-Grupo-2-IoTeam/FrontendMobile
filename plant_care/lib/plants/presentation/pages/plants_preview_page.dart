import 'package:flutter/material.dart';
import 'package:plant_care/plants/domain/entities/plant.dart';
import 'package:plant_care/plants/domain/entities/plant_metric.dart';
import 'package:plant_care/plants/domain/value_objetcs/plant_status.dart';
import 'package:plant_care/plants/presentation/pages/plant_detail_page.dart';
import 'package:plant_care/plants/presentation/widgets/plant_status_chip.dart';

/// A lightweight preview page that shows fake plants so the UI can be
/// validated without connecting to the API or Bloc layers.
/// Now fully aligned with the modern Material 3 grid design.
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
      Plant(
        id: 3,
        userId: 'fake-user',
        name: 'Snake Plant',
        type: 'Sansevieria',
        imgUrl: 'https://images.unsplash.com/photo-1593482890356-7f90d4d31096',
        bio: 'Low-maintenance plant with upright sword-shaped leaves.',
        location: 'Bedroom',
        status: PlantStatus.CRITICAL,
        lastWatered: now.subtract(const Duration(days: 15)),
        nextWatering: now.subtract(const Duration(days: 1)),
        metrics: [],
      ),
    ];

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // AppBar moderno y transparente
      appBar: AppBar(
        title: const Text('Preview: Mis Plantas'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            tooltip: 'Preview Mode',
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _PlantsGrid(plants: fakePlants),
    );
  }
}

// Reutilizamos el mismo grid moderno de PlantsListPage para consistencia visual
class _PlantsGrid extends StatelessWidget {
  final List<Plant> plants;

  const _PlantsGrid({required this.plants});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        16 + MediaQuery.of(context).padding.bottom + 88,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.78,
      ),
      itemCount: plants.length,
      itemBuilder: (context, index) {
        final plant = plants[index];
        return _PlantGridCard(plant: plant);
      },
    );
  }
}

// Tarjeta moderna en grid (Material 3) – 100% reutilizable
class _PlantGridCard extends StatelessWidget {
  final Plant plant;

  const _PlantGridCard({required this.plant});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Hero(
      tag: 'plant_card_${plant.id}',
      child: Card(
        elevation: 0,
        color: colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 350),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    PlantDetailPage(plant: plant),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen con hero y badge de estado
              Expanded(
                flex: 3,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      plant.imgUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.local_florist,
                          size: 48,
                          color: colorScheme.outline,
                        ),
                      ),
                    ),
                    // Status badge
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            plant.status,
                            colorScheme,
                          ).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: PlantStatusChip(
                          status: plant.status,
                          isLarge: false,
                          textStyle: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Contenido inferior
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        plant.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        plant.type,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              plant.location,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.primary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(PlantStatus status, ColorScheme colorScheme) {
    switch (status) {
      case PlantStatus.HEALTHY:
        return colorScheme.primary;
      case PlantStatus.WARNING:
        return colorScheme.tertiary;
      case PlantStatus.CRITICAL:
        return colorScheme.error;
      case PlantStatus.DANGER:
        return colorScheme.error;
      case PlantStatus.UNKNOWN:
        return Colors.grey;
    }
  }
}
