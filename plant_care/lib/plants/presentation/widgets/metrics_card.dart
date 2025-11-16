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
      elevation: 2,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dispositivo: ${metric.deviceId}',
              style: textTheme.titleMedium,
            ),
            Text('Última act: $lastUpdated', style: textTheme.bodySmall),
            const Divider(height: 24),
            // Grid para las 4 métricas principales
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.5, // Hace los items más anchos que altos
              children: [
                _MetricItem(
                  icon: Icons.thermostat,
                  label: 'Temperatura',
                  value: '${metric.temperature.toStringAsFixed(1)} °C',
                ),
                _MetricItem(
                  icon: Icons.water,
                  label: 'Humedad Amb.',
                  value: '${metric.humidity.toStringAsFixed(1)} %',
                ),
                _MetricItem(
                  icon: Icons.wb_sunny,
                  label: 'Luz',
                  value: '${metric.light.toStringAsFixed(0)} lux',
                ),
                _MetricItem(
                  icon: Icons.terrain,
                  label: 'Humedad Suelo',
                  value: '${metric.soilHumidity.toStringAsFixed(1)} %',
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
class _MetricItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _MetricItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                Text(value, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
