import 'package:plant_care/analytics/domain/entities/analytics_data.dart';
import 'package:plant_care/analytics/domain/entities/report.dart';

abstract class AnalyticsRepository {
  /// Obtiene los datos de análisis del usuario.
  Future<AnalyticsData> getAnalyticsData(String userId, String token);

  /// Obtiene un reporte por su ID.
  Future<Report?> getReportById(String id, String token);

  /// Obtiene todos los reportes del usuario autenticado.
  Future<List<Report>> fetchReportsByUserId(String userId, String token);

  /// Crea un nuevo reporte y retorna el creado por el backend.
  Future<Report> createReport(Report report, String token);

  /// Elimina un reporte por su ID.
  Future<void> deleteReport(String id, String token);
}
