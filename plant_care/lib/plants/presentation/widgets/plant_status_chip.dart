// DRY & SRP: Un widget reutilizable solo para mostrar el estado.
import 'package:flutter/material.dart';
import 'package:plant_care/plants/domain/value_objetcs/plant_status.dart';

class PlantStatusChip extends StatelessWidget {
  final PlantStatus status;
  final bool isLarge;
  final TextStyle? textStyle;

  const PlantStatusChip({
    super.key,
    required this.status,
    this.isLarge = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = _getStatusProperties(status, context);

    return Chip(
      label: Text(label),
      labelStyle:
          textStyle ??
          TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: isLarge ? 14 : 10,
          ),
      avatar: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimary,
        size: isLarge ? 20 : 16,
      ),
      backgroundColor: color,
      padding: EdgeInsets.all(isLarge ? 8.0 : 4.0),
    );
  }

  // KISS: Lógica de presentación simple y centralizada
  (String, Color, IconData) _getStatusProperties(
    PlantStatus status,
    BuildContext context,
  ) {
    final colors = Theme.of(context).colorScheme;
    switch (status) {
      case PlantStatus.HEALTHY:
        return ('Saludable', colors.primary, Icons.check_circle);
      case PlantStatus.WARNING:
        return ('Atención', Colors.orange.shade700, Icons.warning);
      case PlantStatus.CRITICAL:
        return ('Crítico', colors.error, Icons.dangerous);
      case PlantStatus.DANGER:
        return ('Peligro', colors.error, Icons.dangerous);
      case PlantStatus.UNKNOWN:
        return ('Desconocido', Colors.grey, Icons.help);
    }
  }
}
