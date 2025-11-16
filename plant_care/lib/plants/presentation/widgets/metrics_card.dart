// DRY & SRP: Un widget solo para mostrar la tarjeta de métricas.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_care/plants/domain/entities/plant_metric.dart';

class MetricsCard extends StatelessWidget {
  final PlantMetric metric;
  const MetricsCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final lastUpdated = DateFormat('dd/MM/yy hh:mm a').format(metric.createdAt);
    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dispositivo', style: textTheme.bodySmall),
                    const SizedBox(height: 4),
                    Text(metric.deviceId, style: textTheme.titleMedium),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Última lectura', style: textTheme.bodySmall),
                    const SizedBox(height: 4),
                    Text(lastUpdated, style: textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Big metric row
            Row(
              children: [
                _BigMetricTile(
                  icon: Icons.thermostat,
                  label: 'Temperatura',
                  value: '${metric.temperature.toStringAsFixed(1)}',
                  unit: '°C',
                ),
                const SizedBox(width: 8),
                _BigMetricTile(
                  icon: Icons.water_drop,
                  label: 'Humedad',
                  value: '${metric.humidity.toStringAsFixed(1)}',
                  unit: '%',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _BigMetricTile(
                  icon: Icons.wb_sunny,
                  label: 'Luz',
                  value: '${metric.light.toStringAsFixed(0)}',
                  unit: 'lux',
                ),
                const SizedBox(width: 8),
                _BigMetricTile(
                  icon: Icons.terrain,
                  label: 'Suelo',
                  value: '${metric.soilHumidity.toStringAsFixed(1)}',
                  unit: '%',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget interno para cada métrica
class _BigMetricTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;

  const _BigMetricTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary, size: 22),
                const SizedBox(width: 8),
                Text(label, style: textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                Text(unit, style: textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
