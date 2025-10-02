import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/theme.dart'; // para usar AppTheme.primaryGreen

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    const String userName = "Sarah"; // Esto luego vendrá del modelo de usuario

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 👋 Sección de bienvenida
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, $userName!",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Here’s the latest update about your plants 🌱",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Resumen de métricas
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: const [
                _MetricCard(title: "Humidity", value: "65%", icon: Icons.water_drop, color: Colors.blue),
                _MetricCard(title: "Temperature", value: "22°C", icon: Icons.thermostat, color: Colors.orange),
                _MetricCard(title: "Total Plants", value: "12", icon: Icons.local_florist, color: Colors.green),
                _MetricCard(title: "Alerts", value: "3", icon: Icons.warning_amber, color: Colors.red),
              ],
            ),

            const SizedBox(height: 24),

            // Showcase de planta con alerta
            Text("Needs Attention", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Imagen de la planta (placeholder por ahora)
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.green.shade100,
                      ),
                      child: const Icon(Icons.local_florist, size: 40, color: Colors.green),
                    ),
                    const SizedBox(width: 16),
                    // Info de la planta
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Aloe Vera", style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text("Needs watering", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red)),
                          const SizedBox(height: 8),
                          Text("Last watered: 2 days ago", style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go("/plant/1"),
                      child: const Text("View"),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Actividad reciente
            Text("Recent Activity", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Column(
              children: const [
                _ActivityItem(icon: Icons.water_drop, text: "Ficus was watered", time: "5 min ago"),
                _ActivityItem(icon: Icons.warning, text: "Aloe Vera needs water", time: "1 hr ago"),
                _ActivityItem(icon: Icons.thermostat, text: "Temperature back to normal", time: "3 hrs ago"),
              ],
            ),
          ],
        ),
      ),

      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // 0 = Dashboard
        selectedItemColor: AppTheme.primaryGreen,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go("/dashboard");
              break;
            case 1:
              context.go("/myplants");
              break;
            case 2:
              context.go("/history");
              break;
            case 3:
              context.go("/settings");
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: "My Plants"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

// Widget para métricas rápidas
class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: color, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

// Widget para actividad reciente
class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String time;

  const _ActivityItem({
    required this.icon,
    required this.text,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(text, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(time, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
