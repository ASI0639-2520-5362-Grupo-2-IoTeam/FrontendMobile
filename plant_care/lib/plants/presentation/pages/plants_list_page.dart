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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // AppBar transparente con efecto de profundidad
      appBar: AppBar(
        title: const Text('Mis Plantas'),
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
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implementar búsqueda
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      extendBodyBehindAppBar: false,
      // FAB moderno (opcional, pero recomendado)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navegar a formulario de nueva planta
        },
        child: const Icon(Icons.add),
      ),
      body: useFakeData
          ? _buildFakeList(context)
          : BlocBuilder<PlantsCubit, PlantsState>(
              builder: (context, state) {
                if (state is PlantsLoading) {
                  return const _LoadingState();
                }
                if (state is PlantsError) {
                  return _ErrorState(message: state.message);
                }
                if (state is PlantsLoaded) {
                  if (state.plants.isEmpty) {
                    return const _EmptyState();
                  }
                  return _PlantsGrid(plants: state.plants);
                }
                return const _InitialState();
              },
            ),
    );
  }

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

    return _PlantsGrid(plants: fakePlants);
  }
}

// Grid de plantas con tarjetas modernas
class _PlantsGrid extends StatelessWidget {
  final List<Plant> plants;

  const _PlantsGrid({required this.plants});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: GridView.builder(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom + 96,
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
      ),
    );
  }
}

// Tarjeta moderna en grid (Material 3)
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
              // Imagen con hero
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
                    // Status badge en la esquina
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
              // Contenido inferior centrado para simetría
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        plant.type,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              plant.location,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.primary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
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

// Estados vacíos y de error con diseño moderno
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.eco, size: 72, color: colorScheme.outline),
            const SizedBox(height: 24),
            Text(
              'No tienes plantas registradas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Agrega tu primera planta para comenzar a cuidarla',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 72, color: colorScheme.error),
            const SizedBox(height: 24),
            Text(
              'Error al cargar las plantas',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.tonal(
              onPressed: () {
                context.read<PlantsCubit>().fetchPlants();
              },
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(strokeWidth: 3));
  }
}

class _InitialState extends StatelessWidget {
  const _InitialState();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Iniciando...'));
  }
}
