import 'package:flutter/material.dart';
import 'package:plant_care/presentation/theme/theme.dart';
import 'plant_detail_view.dart';
import '../widgets/custom_bottom_navbar.dart';

class MyPlantsView extends StatelessWidget {
  const MyPlantsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> plants = [
      {
        "id": "1",
        "name": "Aloe Vera",
        "humidity": 45,
        "lastWatered": "2 days ago",
        "status": "warning",
      },
      {
        "id": "2",
        "name": "Ficus",
        "humidity": 70,
        "lastWatered": "1 day ago",
        "status": "healthy",
      },
      {
        "id": "3",
        "name": "Basil",
        "humidity": 20,
        "lastWatered": "5 days ago",
        "status": "critical",
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Plants",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${plants.length} plants",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle, size: 32),
                    color: AppTheme.primaryGreen,
                    onPressed: () {
                      // TODO: acción para añadir plantas
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Lista de plantas
              // Lista de plantas con efecto ripple (InkWell)
Expanded(
  child: ListView.builder(
    itemCount: plants.length,
    itemBuilder: (context, index) {
      final plant = plants[index];
      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias, // permite el efecto ripple dentro del borde
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (_, __, ___) =>
                    PlantDetailView(plantId: plant["id"]),
                transitionsBuilder: (_, animation, __, child) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0.1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );
                  return SlideTransition(position: offsetAnimation, child: child);
                },
              ),
            );
          },
          splashColor: AppTheme.primaryGreen.withOpacity(0.2),
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icono de planta (placeholder)
                Hero(
                  tag: plant["id"],
                  child: const Icon(
                    Icons.local_florist,
                    size: 40,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(width: 16),

                // Info planta
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre + estado (badge)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            plant["name"],
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.getStatusColor(plant["status"])
                                  .withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  AppTheme.getStatusIcon(plant["status"]),
                                  color: AppTheme.getStatusColor(plant["status"]),
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  plant["status"].toUpperCase(),
                                  style: TextStyle(
                                    color: AppTheme.getStatusColor(plant["status"]),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Datos de la planta
                      Text("Humidity: ${plant["humidity"]}%",
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text("Last watered: ${plant["lastWatered"]}",
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),

            ],
          ),
        ),
      ),

      // Ahora usamos el CustomBottomNavBar
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}
