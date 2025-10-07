import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:plant_care/presentation/theme/theme.dart';

class PlantDetailView extends StatelessWidget {
  final String plantId;
  const PlantDetailView({super.key, required this.plantId});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> plant = {
      "id": plantId,
      "name": "Aloe Vera",
      "humidity": 45,
      "lastWatered": "2 days ago",
      "status": "warning",
      "nextWatering": "In 2 days",
      "recommendations": [
        "Water every 3–4 days",
        "Needs indirect sunlight",
        "Avoid overwatering"
      ],
      "history": [60, 55, 50, 48, 47, 46, 45],
    };

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Header con animación Hero
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Botones arriba
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 4),

                    // 🌱 Animación Hero del ícono de planta
                    Center(
                      child: Hero(
                        tag: plant["id"],
                        child: const Icon(
                          Icons.local_florist,
                          size: 80,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Nombre de la planta
                    Text(
                      plant["name"],
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),

                    // Estado (badge) + datos
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.getStatusColor(plant["status"])
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                AppTheme.getStatusIcon(plant["status"]),
                                color: AppTheme.getStatusColor(plant["status"]),
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                plant["status"].toUpperCase(),
                                style: TextStyle(
                                  color:
                                      AppTheme.getStatusColor(plant["status"]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text("Humidity: ${plant["humidity"]}%"),
                        Text("Last watered: ${plant["lastWatered"]}"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Gráfico con animación de entrada
_SectionCard(
  title: "Humidity over last 7 days",
  child: SizedBox(
    height: 200,
    child: TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1900),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 40),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (v, meta) {
                    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                    if (v.toInt() < days.length) return Text(days[v.toInt()]);
                    return const Text("");
                  },
                ),
              ),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                color: AppTheme.primaryGreen,
                barWidth: 3,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                ),
                spots: [
                  for (int i = 0; i < plant["history"].length; i++)
                    FlSpot(
                      i.toDouble(),
                      // multiplicamos por "value" para animar la altura
                      plant["history"][i].toDouble() * value,
                    )
                ],
              ),
            ],
          ),
        );
      },
    ),
  ),
),

              const SizedBox(height: 16),

              // Próximo riego
              _SectionCard(
                title: "Next watering",
                child: Row(
                  children: [
                    Icon(Icons.water_drop,
                        color: AppTheme.primaryGreen, size: 28),
                    const SizedBox(width: 12),
                    Text(
                      plant["nextWatering"],
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Recomendaciones
              _SectionCard(
                title: "Recommendations",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final rec in plant["recommendations"])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Icon(Icons.check,
                                size: 20, color: AppTheme.primaryGreen),
                            const SizedBox(width: 8),
                            Expanded(child: Text(rec)),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔸 Card reutilizable (usa el cardTheme del tema global)
class _SectionCard extends StatelessWidget {
  final String? title;
  final Widget child;

  const _SectionCard({this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null && title!.isNotEmpty) ...[
              Text(
                title!,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
