import 'package:flutter/material.dart';
import 'package:plant_care/iam/presentation/providers/auth_provider.dart';
import 'package:plant_care/presentation/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../../plant_detail/presentation/widgets/plant_detail_view.dart';
import '../../../presentation/widgets/custom_bottom_navbar.dart';
import '../../data/datasources/plant_api_service.dart';
import '../../data/models/plant_model.dart';

class MyPlantsView extends StatefulWidget {
  const MyPlantsView({super.key});

  @override
  State<MyPlantsView> createState() => _MyPlantsViewState();
}

class _MyPlantsViewState extends State<MyPlantsView> {
  late final PlantApiService _apiService;
  Future<List<PlantModel>>? _plantsFuture;

  @override
  void initState() {
    super.initState();
    _apiService = PlantApiService();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final authProvider = context.read<AuthProvider>();
    final userId = authProvider.userId; // UUID
    final token = authProvider.token;
    
    debugPrint("✅ Token enviado: $token");
    debugPrint("✅ UserId enviado: $userId");

    if (userId != null && token != null) {
      setState(() {
        _plantsFuture = _apiService.getPlantsByUserId(userId, token: token);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _plantsFuture == null
              ? const Center(
                  child: Text(
                    "No user logged in.",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : FutureBuilder<List<PlantModel>>(
                  future: _plantsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error al cargar las plantas: ${snapshot.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final plants = snapshot.data ?? [];

                    return Column(
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
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${plants.length} plants",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
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
                        Expanded(
                          child: ListView.builder(
                            itemCount: plants.length,
                            itemBuilder: (context, index) {
                              final plant = plants[index];
                              return Card(
                                margin:
                                    const EdgeInsets.only(bottom: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(16)),
                                clipBehavior: Clip.antiAlias,
                                elevation: 2,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration: const Duration(
                                            milliseconds: 400),
                                        pageBuilder: (_, __, ___) =>
                                            PlantDetailView(
                                                plantId:
                                                    plant.id.toString()),
                                        transitionsBuilder:
                                            (_, animation, __, child) {
                                          final offsetAnimation =
                                              Tween<Offset>(
                                            begin: const Offset(0.1, 0),
                                            end: Offset.zero,
                                          ).animate(CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeOutCubic,
                                          ));
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  splashColor: AppTheme.primaryGreen
                                      .withOpacity(0.2),
                                  highlightColor: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Hero(
                                          tag: plant.id,
                                          child: const Icon(
                                            Icons.local_florist,
                                            size: 40,
                                            color: AppTheme.primaryGreen,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    plant.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: AppTheme
                                                          .getStatusColor(
                                                              plant.status
                                                                  .name)
                                                          .withOpacity(0.15),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(12),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          AppTheme
                                                              .getStatusIcon(
                                                                  plant.status
                                                                      .name),
                                                          color: AppTheme
                                                              .getStatusColor(
                                                                  plant.status
                                                                      .name),
                                                          size: 16,
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          plant.status.name
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: AppTheme
                                                                .getStatusColor(
                                                                    plant
                                                                        .status
                                                                        .name),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "Humidity: ${plant.humidity ?? '-'}%",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                "Last watered: ${plant.lastWatered ?? 'unknown'}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
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
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(currentIndex: 1),
    );
  }
}
