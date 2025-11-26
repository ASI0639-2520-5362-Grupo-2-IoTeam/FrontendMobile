import 'dart:ui'; // Necesario para ImageFilter (Blur)
import 'package:flutter/material.dart';
import 'package:plant_care/plants/domain/entities/plant.dart';
import 'package:plant_care/plants/domain/entities/plant_metric.dart';
import 'package:plant_care/plants/domain/value_objetcs/plant_status.dart';
import 'package:plant_care/plants/presentation/widgets/metrics_card.dart'; // Tu widget anterior

class PlantDetailPage extends StatelessWidget {
  final Plant plant; // Agregado para aceptar el parámetro 'plant'

  const PlantDetailPage({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    // Datos falsos para previsualización
    final fakeMetrics = [
      PlantMetric(
        deviceId: 'device123',
        temperature: 22.5,
        humidity: 60.0,
        soilHumidity: 45.0,
        light: 300.0,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      PlantMetric(
        deviceId: 'device123',
        temperature: 23.0,
        humidity: 58.0,
        soilHumidity: 50.0,
        light: 320.0,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];

    final fakePlant = Plant(
      id: 1,
      userId: 'user123',
      name: 'Ficus Lyrata',
      type: 'Interior',
      imgUrl: 'https://via.placeholder.com/350x150',
      bio: 'Una planta tropical que requiere luz indirecta y riego moderado.',
      location: 'Sala de estar',
      status: PlantStatus.HEALTHY,
      lastWatered: DateTime.now().subtract(const Duration(days: 3)),
      nextWatering: DateTime.now().add(const Duration(days: 4)),
      metrics: fakeMetrics,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Vista previa de planta')),
      body: PlantDetailPageContent(plant: fakePlant),
    );
  }
}

class PlantDetailPageContent extends StatelessWidget {
  final Plant plant;
  const PlantDetailPageContent({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    // Color de fondo clásico de iOS Grouped Background
    const backgroundColor = Color(0xFFF2F2F7);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(), // Rebote estilo iOS
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título Grande estilo "Large Title"
                  Text(
                    plant.name,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtítulo / Especie
                  Text(
                    plant.type.toUpperCase(),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Bloque 1: Estado y Ubicación (Row estilizada)
                  _buildInfoRow(context),
                  const SizedBox(height: 24),

                  // Bloque 2: Biografía (Container Blanco)
                  _iOSSectionTitle('Biografía'),
                  _iOSContentContainer(
                    child: Text(
                      plant.bio,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Color(0xFF3A3A3C), // Gris oscuro iOS
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Bloque 3: Riego (Grid 2 columnas)
                  _iOSSectionTitle('Ciclo de Riego'),
                  Row(
                    children: [
                      Expanded(
                        child: _WateringTile(
                          label: 'Último riego',
                          date: plant.lastWatered,
                          icon: Icons.water_drop_rounded,
                          color: const Color(0xFF007AFF), // iOS Blue
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _WateringTile(
                          label: 'Próximo riego',
                          date: plant.nextWatering,
                          icon: Icons.access_alarm_rounded,
                          color: const Color(0xFFFF9500), // iOS Orange
                          isNext: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Bloque 4: Métricas (Tu widget anterior)
                  _iOSSectionTitle('Sensores en vivo'),
                  if (plant.latestMetric != null)
                    // Usar MetricsCard directamente
                    MetricsCard(metric: plant.latestMetric!)
                  else
                    _iOSContentContainer(
                      child: const Center(
                        child: Text('Conectando sensores...'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- APP BAR CON EFECTO BLUR (Glassmorphism) ---
  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350,
      backgroundColor: Colors.transparent,
      stretch: true,
      pinned: true,
      leading: Container(
        margin: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: const Color.fromARGB(127, 255, 255, 255),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: const Color.fromARGB(127, 255, 255, 255),
                child: IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 18,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Imagen de la planta
            Image.network(plant.imgUrl, fit: BoxFit.cover),
            // Degradado para mejorar contraste
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.2), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helpers iOS-like ---
  Widget _buildInfoRow(BuildContext context) {
    Color statusColor;
    String statusText;
    switch (plant.status) {
      case PlantStatus.HEALTHY:
        statusColor = Colors.green;
        statusText = 'Sana';
        break;
      case PlantStatus.WARNING:
        statusColor = Colors.orange;
        statusText = 'Precaución';
        break;
      case PlantStatus.DANGER:
        statusColor = Colors.red;
        statusText = 'En peligro';
        break;
      case PlantStatus.CRITICAL:
        statusColor = Colors.deepPurple;
        statusText = 'Crítico';
        break;
      case PlantStatus.UNKNOWN:
        statusColor = Colors.grey;
        statusText = 'Desconocido';
        break;
    }

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: statusColor.withAlpha(31),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Colors.grey,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  plant.location,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _iOSSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _iOSContentContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _WateringTile({
    required String label,
    required DateTime date,
    required IconData icon,
    required Color color,
    bool isNext = false,
  }) {
    final formatted = '${date.day}/${date.month}/${date.year}';
    return _iOSContentContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha(31),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(formatted, style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ],
          ),
          if (isNext) ...[
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                elevation: 0,
              ),
              child: const Text('Marcar como regado'),
            ),
          ],
        ],
      ),
    );
  }
}
