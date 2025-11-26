import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para HapticFeedback
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_care/plants/domain/entities/plant.dart';
import 'package:plant_care/plants/domain/entities/plant_metric.dart';
import 'package:plant_care/plants/domain/value_objetcs/plant_status.dart';
import 'package:plant_care/plants/presentation/cubit/plants_cubit.dart';
import 'package:plant_care/plants/presentation/pages/plant_detail_page.dart';
// Asegúrate de tener tus imports correctos para los widgets personalizados

class PlantsListPage extends StatelessWidget {
  final bool useFakeData;

  const PlantsListPage({super.key, this.useFakeData = false});

  @override
  Widget build(BuildContext context) {
    // Color de fondo estilo iOS Grouped
    const backgroundColor = Color(0xFFF2F2F7); 

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        // Rebote característico de iOS
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. APP BAR TIPO "LARGE TITLE"
          SliverAppBar.large(
            backgroundColor: backgroundColor,
            surfaceTintColor: Colors.transparent, // Evita el tinte de Material 3
            title: const Text(
              'Mis Plantas',
              style: TextStyle(
                color: Colors.black, 
                fontWeight: FontWeight.w700,
                letterSpacing: -1.0, // Kerning apretado estilo Apple
              ),
            ),
            centerTitle: false,
            expandedHeight: 120,
            floating: true,
            pinned: true,
            actions: [
               // Botón Buscar (Icono gris sutil)
               IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(Icons.search, size: 20, color: Colors.black),
                ),
                onPressed: () { /* TODO: Search */ },
              ),
              // Botón Añadir (Estilo iOS Header)
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black, // Acento fuerte
                  ),
                  child: const Icon(Icons.add, size: 20, color: Colors.white),
                ),
                onPressed: () { 
                  // Haptic Feedback al pulsar botones importantes
                  HapticFeedback.lightImpact();
                  /* TODO: Add Plant */ 
                },
              ),
              const SizedBox(width: 16),
            ],
          ),

          // 2. CONTENIDO DE LA LISTA (GRILLA)
          if (useFakeData)
             _buildFakeGrid(context)
          else
            BlocBuilder<PlantsCubit, PlantsState>(
              builder: (context, state) {
                if (state is PlantsLoading) {
                  return const SliverFillRemaining(child: _LoadingState());
                }
                if (state is PlantsError) {
                  return SliverFillRemaining(child: _ErrorState(message: state.message));
                }
                if (state is PlantsLoaded) {
                  if (state.plants.isEmpty) {
                    return const SliverFillRemaining(child: _EmptyState());
                  }
                  return _PlantsSliverGrid(plants: state.plants);
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            
          // Espacio extra abajo para que no choque con la barra de navegación del sistema
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildFakeGrid(BuildContext context) {
    // (Tu data falsa original aquí, omitida para brevedad pero se mantiene igual)
    final now = DateTime.now();
    final fakePlants = [
      Plant(
        id: 1, userId: 'u1', name: 'Monstera Deliciosa', type: 'Monstera',
        imgUrl: 'https://images.unsplash.com/photo-1516728778615-2d590ea1856f',
        bio: '...', location: 'Sala', status: PlantStatus.HEALTHY,
        lastWatered: now, nextWatering: now, metrics: []
      ),
       Plant(
        id: 2, userId: 'u2', name: 'Ficus Lyrata', type: 'Ficus',
        imgUrl: 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6',
        bio: '...', location: 'Oficina', status: PlantStatus.WARNING,
        lastWatered: now, nextWatering: now, metrics: []
      ),
    ];
    return _PlantsSliverGrid(plants: fakePlants);
  }
}

// Usamos SliverPadding + SliverGrid para integrarlo en el CustomScrollView
class _PlantsSliverGrid extends StatelessWidget {
  final List<Plant> plants;

  const _PlantsSliverGrid({required this.plants});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75, // Un poco más alto para la imagen
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final plant = plants[index];
            return _AppleStyleCard(plant: plant);
          },
          childCount: plants.length,
        ),
      ),
    );
  }
}

class _AppleStyleCard extends StatelessWidget {
  final Plant plant;

  const _AppleStyleCard({required this.plant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegación nativa de iOS
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PlantDetailPage(plant: plant)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          // Sombra estilo Apple: muy difusa y transparente
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- IMAGEN ---
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.network(
                        plant.imgUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
                      ),
                    ),
                  ),
                  // Badge de estado flotante (Glassmorphism sutil)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _StatusBadge(status: plant.status),
                  ),
                ],
              ),
            ),
            
            // --- INFO ---
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      plant.type.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8E8E93), // Gris iOS
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      plant.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded, size: 12, color: Color(0xFF007AFF)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            plant.location,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF007AFF), // Azul iOS
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final PlantStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    // Colores semánticos tipo Apple
    Color color;
    switch (status) {
      case PlantStatus.HEALTHY: color = const Color(0xFF34C759); break; // Green
      case PlantStatus.WARNING: color = const Color(0xFFFF9500); break; // Orange
      case PlantStatus.CRITICAL: color = const Color(0xFFFF3B30); break; // Red
      default: color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Semi-transparente
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
        ]
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6, height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            _statusText(status),
            style: TextStyle(
              color: color, 
              fontSize: 10, 
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }

  String _statusText(PlantStatus s) => s.toString().split('.').last;
}

// Estados Vacíos y de Carga minimalistas
class _LoadingState extends StatelessWidget {
  const _LoadingState();
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive()); // Adaptive usa el spinner de iOS
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.energy_savings_leaf_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text("Sin plantas", style: TextStyle(color: Colors.grey, fontSize: 18)),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message, style: const TextStyle(color: Colors.red)));
  }
}