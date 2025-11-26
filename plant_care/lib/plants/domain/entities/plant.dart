import 'package:equatable/equatable.dart';
import 'package:plant_care/plants/domain/entities/plant_metric.dart';
import 'package:plant_care/plants/domain/value_objetcs/plant_status.dart';

// DDD: Esta es la Entidad pura. No sabe nada de JSON o APIs.
// Es inmutable (final) y usa Equatable para comparaciones (buenas prácticas).
class Plant extends Equatable {
  final int id;
  final String userId;
  final String name;
  final String type;
  final String imgUrl;
  final String bio;
  final String location;
  final PlantStatus status;
  final DateTime lastWatered;
  final DateTime nextWatering;
  final List<PlantMetric> metrics;

  const Plant({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.imgUrl,
    required this.bio,
    required this.location,
    required this.status,
    required this.lastWatered,
    required this.nextWatering,
    required this.metrics,
  });

  // Helper para obtener la métrica más reciente
  PlantMetric? get latestMetric => metrics.isEmpty
      ? null
      : metrics.reduce((a, b) =>
          a.createdAt.isAfter(b.createdAt) ? a : b);

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        type,
        imgUrl,
        bio,
        location,
        status,
        lastWatered,
        nextWatering,
        metrics
      ];
}