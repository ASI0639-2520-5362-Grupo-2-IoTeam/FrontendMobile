




// DDD: Este es el DTO (Data Transfer Object) o "Model".
// Sabe cómo parsear JSON (fromJson) y cómo convertirse en una Entidad de dominio (toEntity).
// Esto desacopla totalmente el Dominio (Plant) de la Infraestructura (el JSON del API).
import 'package:plant_care/plants/domain/entities/plant.dart';
import 'package:plant_care/plants/domain/value_objetcs/plant_status.dart';
import 'package:plant_care/plants/infrastructure/models/plant_metric_model.dart';

class PlantModel {
  final int id;
  final String userId;
  final String name;
  final String type;
  final String imgUrl;
  final String bio;
  final String location;
  final String status; // Como String, desde el JSON
  final String lastWatered;
  final String nextWatering;
  final List<PlantMetricModel> metrics;
  // Omitimos wateringLogs, createdAt, updatedAt según tu solicitud.

  PlantModel({
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

  // Factory Pattern: Un método "constructor" para crear desde JSON.
  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      type: json['type'],
      imgUrl: json['imgUrl'],
      bio: json['bio'],
      location: json['location'],
      status: json['status'],
      lastWatered: json['lastWatered'],
      nextWatering: json['nextWatering'],
      metrics: (json['metrics'] as List)
          .map((metricJson) => PlantMetricModel.fromJson(metricJson))
          .toList(),
    );
  }

  // Método de conversión a la Entidad del Dominio.
  // Aquí ocurre la "magia" de la transformación de datos.
  Plant toEntity() {
    return Plant(
      id: id,
      userId: userId,
      name: name,
      type: type,
      imgUrl: imgUrl,
      bio: bio,
      location: location,
      status: PlantStatus.fromString(status), // Conversión de Value Object
      lastWatered: DateTime.parse(lastWatered), // Conversión de tipo
      nextWatering: DateTime.parse(nextWatering),
      metrics: metrics
          .map((model) => model.toEntity())
          .toList(), // Conversión recursiva
    );
  }
}