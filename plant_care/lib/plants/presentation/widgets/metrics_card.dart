import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_care/plants/domain/entities/plant_metric.dart';

class MetricsCard extends StatelessWidget {
  final PlantMetric metric;

  const MetricsCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Formateo de fecha más limpio
    final lastUpdated = DateFormat('d MMM, hh:mm a').format(metric.createdAt);

    return Card(
      elevation: 0, // Modern UI prefiere sombras sutiles o bordes
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Bordes más redondeados (Moderno)
        side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- HEADER: Dispositivo y Fecha ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _DeviceBadge(deviceId: metric.deviceId),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, 
                         size: 14, color: theme.hintColor),
                    const SizedBox(width: 4),
                    Text(
                      lastUpdated,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.hintColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // --- GRID DE MÉTRICAS (Bento Style) ---
            Row(
              children: [
                Expanded(
                  child: _MetricTile(
                    label: 'Temperatura',
                    value: metric.temperature.toStringAsFixed(1),
                    unit: '°C',
                    icon: Icons.thermostat_rounded,
                    accentColor: const Color(0xFFFF6B6B), // Naranja/Rojo suave
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricTile(
                    label: 'Humedad',
                    value: metric.humidity.toStringAsFixed(0), // Sin decimales suele ser mejor
                    unit: '%',
                    icon: Icons.water_drop_rounded,
                    accentColor: const Color(0xFF4ECDC4), // Turquesa
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _MetricTile(
                    label: 'Luz',
                    value: metric.light.toStringAsFixed(0),
                    unit: 'lx',
                    icon: Icons.wb_sunny_rounded,
                    accentColor: const Color(0xFFFFD93D), // Amarillo Sol
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricTile(
                    label: 'Suelo',
                    value: metric.soilHumidity.toStringAsFixed(0),
                    unit: '%',
                    icon: Icons.grass_rounded,
                    accentColor: const Color(0xFF6A994E), // Verde Planta
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- WIDGETS INTERNOS (DRY & SRP) ---

class _DeviceBadge extends StatelessWidget {
  final String deviceId;
  const _DeviceBadge({required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sensors,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 6),
          Text(
            deviceId,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color accentColor;

  const _MetricTile({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Un fondo muy sutil basado en el color del acento da un look "Glassy"
        color: accentColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icono con círculo de fondo
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accentColor, size: 20),
          ),
          const SizedBox(height: 12),
          
          // Valor Numérico Grande
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                    height: 1.0,
                  ),
                ),
                TextSpan(
                  text: unit,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          
          // Etiqueta descriptiva
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}