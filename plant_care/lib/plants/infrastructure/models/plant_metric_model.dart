

// DTO para las métricas anidadas
import 'package:plant_care/plants/domain/entities/plant_metric.dart';

class PlantMetricModel {
  final String deviceId;
  final num temperature; // Usamos 'num' para flexibilidad (int o double)
  final num humidity;
  final num light;
  final num soilHumidity;
  final String createdAt;

  PlantMetricModel({
    required this.deviceId,
    required this.temperature,
    required this.humidity,
    required this.light,
    required this.soilHumidity,
    required this.createdAt,
  });

  factory PlantMetricModel.fromJson(Map<String, dynamic> json) {
    return PlantMetricModel(
      deviceId: json['deviceId'],
      temperature: json['temperature'],
      humidity: json['humidity'],
      light: json['light'],
      soilHumidity: json['soilHumidity'],
      createdAt: json['createdAt'],
    );
  }

  // Conversión al de la Entidad de Dominio
  PlantMetric toEntity() {
    return PlantMetric(
      deviceId: deviceId,
      temperature: temperature.toDouble(), // Aseguramos el tipo
      humidity: humidity.toDouble(),
      light: light.toDouble(),
      soilHumidity: soilHumidity.toDouble(),
      createdAt: DateTime.parse(createdAt),
    );
  }
}