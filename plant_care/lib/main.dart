import 'package:flutter/material.dart';
import 'package:plant_care/presentation/navigation/app_router.dart';
import 'package:provider/provider.dart';
import 'presentation/theme/theme.dart';
import 'presentation/viewmodel/theme_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeViewModel(),
      child: const PlantCareApp(),
    ),
  );
}

class PlantCareApp extends StatelessWidget {
  const PlantCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (context, themeViewModel, child) {
        final isDark = themeViewModel.isDarkMode;
        final theme = isDark ? AppTheme.darkTheme : AppTheme.lightTheme;

        return AnimatedTheme(
          data: theme,
          duration: const Duration(milliseconds: 400), // transición suave
          curve: Curves.easeInOut,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: appRouter,
          ),
        );
      },
    );
  }
}
