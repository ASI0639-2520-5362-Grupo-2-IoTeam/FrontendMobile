import 'package:flutter/material.dart';
import 'presentation/navigation/app_router.dart';
import 'presentation/theme/theme.dart';

void main() {
  runApp(const PlantCareApp());
}

class PlantCareApp extends StatelessWidget {
  const PlantCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'PlantCare',
      theme: AppTheme.lightTheme, // ✅ Aplicamos el theme global
      routerConfig: appRouter,
    );
  }
}
