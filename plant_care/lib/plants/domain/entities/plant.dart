import 'package:uuid/uuid.dart';

class Plant {
  final int id;
  final Uuid userId;
  final String name;
  final String type;
  final String imgUrl;
  final double humidity;
  final String lastWatered;
  final String nextWatering;
  final PlantStatus status;
  final String bio;

  Plant({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.imgUrl,
    required this.humidity,
    required this.lastWatered,
    required this.nextWatering,
    required this.status,
    required this.bio,
  });
}

class PlantStatus {
  final String name;

  const PlantStatus._(this.name);

  static const healthy = PlantStatus._('healthy');
  static const warning = PlantStatus._('warning');
  static const critical = PlantStatus._('critical');

  static PlantStatus fromString(String status) {
    switch (status) {
      case 'healthy':
        return healthy;
      case 'warning':
        return warning;
      case 'critical':
        return critical;
      default:
        throw Exception('Unknown PlantStatus: $status');
    }
  }

}