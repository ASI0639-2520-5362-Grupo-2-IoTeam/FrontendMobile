import 'package:plant_care/analytics/domain/entities/watering_trend.dart';

class AnalyticsData {
  final int totalPlants;
  final int healthyPlants;
  final int needsWateringPlants;
  final int criticalPlants;
  final double averageHumidity;
  final int totalWaterings;
  final Map<String, int> plantsByType;
  final Map<String, int> plantsByLocation;
  final List<WateringTrend> wateringTrends;

  AnalyticsData({
    required this.totalPlants,
    required this.healthyPlants,
    required this.needsWateringPlants,
    required this.criticalPlants,
    required this.averageHumidity,
    required this.totalWaterings,
    required this.plantsByType,
    required this.plantsByLocation,
    required this.wateringTrends,
  });
}
