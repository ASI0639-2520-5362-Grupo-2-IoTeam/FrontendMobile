// DDD: Un Value Object para el 'status'.
// KISS: Un enum es la forma más simple y clara de manejar esto.
enum PlantStatus {
  HEALTHY,
  WARNING,
  DANGER,
  CRITICAL,
  UNKNOWN; // Estado por defecto

  // Factory para convertir el String del API a nuestro enum.
  // Esto centraliza la lógica de mapeo (DRY).
  static PlantStatus fromString(String? status) {
    switch (status?.toUpperCase()) {
      case 'HEALTHY': // Asumiendo que podrías tener otros estados
        return PlantStatus.HEALTHY;
      case 'WARNING':
        return PlantStatus.WARNING;
      case 'DANGER': // Asumiendo
        return PlantStatus.DANGER;
      case 'CRITICAL':
        return PlantStatus.CRITICAL;
      default:
        return PlantStatus.UNKNOWN;
    }
  }
}
