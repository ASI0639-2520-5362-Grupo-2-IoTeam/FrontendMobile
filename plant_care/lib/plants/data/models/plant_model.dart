import 'package:plant_care/plants/domain/entities/plant.dart';
import 'package:uuid/uuid.dart';
  
class PlantModel extends Plant {

  PlantModel({
    required id,
    required userId,
    required name,
    required type,
    required imgUrl,
    required humidity,
    required lastWatered,
    required nextWatering,
    required status,
    required bio,
  }) : super(
          id: id,
          userId: userId,
          name: name,
          type: type,
          imgUrl: imgUrl,
          humidity: humidity,
          lastWatered: lastWatered,
          nextWatering: nextWatering,
          status: status,
          bio: bio,
        );

  /// Creates a [PlantModel] instance from a JSON map.
  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      id: json['id'] as int,
      userId: Uuid.parse(json['userId'] as String),
      name: json['name'] as String,
      type: json['type'] as String,
      imgUrl: json['imgUrl'] as String,
      humidity: (json['humidity'] as num).toDouble(),
      lastWatered: json['lastWatered'] as String,
      nextWatering: json['nextWatering'] as String,
      status: PlantStatusExtension.fromString(json['status'] as String),
      bio: json['bio'] as String,
    );
  }

  /// Converts a [Plant] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'type': type,
      'imgUrl': imgUrl,
      'humidity': humidity,
      'lastWatered': lastWatered,
      'nextWatering': nextWatering,
      'status': status.name,
      'bio': bio,
    };
  }
}

/// Enum defining the possible health states of a plant.
enum PlantStatus { healthy, warning, critical }

/// Extension to easily convert strings to [PlantStatus].
extension PlantStatusExtension on PlantStatus {
  static PlantStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'healthy':
        return PlantStatus.healthy;
      case 'warning':
        return PlantStatus.warning;
      case 'critical':
        return PlantStatus.critical;
      default:
        throw ArgumentError('Unknown plant status: $value');
    }
  }
}
