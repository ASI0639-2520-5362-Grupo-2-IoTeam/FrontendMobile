import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_care/plants/domain/entities/plant.dart';
import 'package:plant_care/plants/presentation/widgets/plant_status_chip.dart';
import 'package:plant_care/plants/presentation/widgets/metrics_card.dart';

class PlantDetailPage extends StatelessWidget {
  final Plant plant;
  const PlantDetailPage({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final DateFormat formatter = DateFormat('dd/MM/yyyy \'a las\' hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          // Hero image with overlay gradient and title
          SliverAppBar(
            expandedHeight: 320,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'plant_image_${plant.id}',
                    child: Image.network(
                      plant.imgUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.local_florist,
                          size: 120,
                          color: colorScheme.outline,
                        ),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                  // Plant name at bottom of image
                  Positioned(
                    bottom: 24,
                    left: 24,
                    right: 24,
                    child: Text(
                      plant.name,
                      style: textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          const Shadow(
                            blurRadius: 8,
                            color: Colors.black54,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Quick info chips in a wrap for responsiveness
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _InfoChip(icon: Icons.grass, label: plant.type),
                      _InfoChip(icon: Icons.location_on, label: plant.location),
                      PlantStatusChip(status: plant.status, isLarge: true),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Biography section
                  _SectionTitle(title: 'Biografía'),
                  const SizedBox(height: 8),
                  Text(
                    plant.bio,
                    style: textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Watering section
                  _SectionTitle(title: 'Riego'),
                  const SizedBox(height: 12),
                  _WateringCard(
                    icon: Icons.water_drop,
                    title: 'Último Riego',
                    value: formatter.format(plant.lastWatered),
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  _WateringCard(
                    icon: Icons.alarm,
                    title: 'Próximo Riego',
                    value: formatter.format(plant.nextWatering),
                    color: colorScheme.tertiary,
                  ),
                  const SizedBox(height: 32),

                  // Metrics section
                  _SectionTitle(title: 'Métricas (IoT)'),
                  const SizedBox(height: 12),
                  if (plant.latestMetric != null)
                    MetricsCard(metric: plant.latestMetric!)
                  else
                    _EmptyStateCard(message: 'No hay datos de métricas disponibles.'),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable section title with Material 3 typography
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}

// Enhanced info chip with Material 3 styling
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InputChip(
      avatar: Icon(icon, size: 18, color: colorScheme.primary),
      label: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
      ),
      backgroundColor: colorScheme.surfaceContainerHighest,
      side: BorderSide(color: colorScheme.outlineVariant, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}

// Card-style watering row with elevation and color accent
class _WateringCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _WateringCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color.withOpacity(0.12),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Empty state card with subtle styling
class _EmptyStateCard extends StatelessWidget {
  final String message;
  const _EmptyStateCard({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}