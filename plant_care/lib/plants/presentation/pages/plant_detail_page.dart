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
    final textTheme = Theme.of(context).textTheme;

    // Formateador de fechas (DRY)
    final DateFormat formatter = DateFormat('dd/MM/yyyy \'a las\' hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen principal
            Hero(
              tag: 'plant_image_${plant.id}', // Animación simple
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  plant.imgUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.local_florist,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bio
            Text('Biografía', style: textTheme.titleLarge),
            Text(plant.bio, style: textTheme.bodyLarge),
            const SizedBox(height: 20),

            // Fila de Info Rápida (Tipo, Ubicación, Status)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoChip(icon: Icons.grass, label: plant.type),
                _InfoChip(icon: Icons.location_on, label: plant.location),
                PlantStatusChip(status: plant.status, isLarge: true),
              ],
            ),
            const Divider(height: 40),

            // Riegos
            Text('Riego', style: textTheme.titleLarge),
            _DetailRow(
              icon: Icons.water_drop,
              title: 'Último Riego',
              value: formatter.format(plant.lastWatered),
            ),
            _DetailRow(
              icon: Icons.alarm,
              title: 'Próximo Riego',
              value: formatter.format(plant.nextWatering),
            ),
            const SizedBox(height: 20),

            // Métricas (Widget reutilizado)
            Text('Métricas (IoT)', style: textTheme.titleLarge),
            if (plant.latestMetric != null)
              MetricsCard(metric: plant.latestMetric!)
            else
              const Text('No hay datos de métricas disponibles.'),
          ],
        ),
      ),
    );
  }
}

// DRY: Widget interno para filas de detalles
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Text('$title: ', style: Theme.of(context).textTheme.titleMedium),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

// DRY: Widget interno para chips de info
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    );
  }
}
