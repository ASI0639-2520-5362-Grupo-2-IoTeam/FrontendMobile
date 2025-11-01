import 'package:flutter/material.dart';
import 'package:plant_care/presentation/navigation/app_router.dart';
import 'package:provider/provider.dart';
import 'iam/data/datasources/auth_api_service.dart';
import 'iam/data/repositories/auth_repository_impl.dart';
import 'iam/domain/usecases/login_usecase.dart';
import 'iam/domain/usecases/register_usecase.dart';
import 'iam/presentation/providers/auth_provider.dart';
import 'plants/presentation/providers/plant_provider.dart';
import 'presentation/theme/theme.dart';
import 'presentation/viewmodel/theme_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authApiService = AuthApiService();
  final authRepository = AuthRepositoryImpl(authApiService);
  final loginUseCase = LoginUseCase(authRepository);
  final registerUseCase = RegisterUseCase(authRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            loginUseCase: loginUseCase,
            registerUseCase: registerUseCase,
          ),
        ),
        ChangeNotifierProvider(create: (_) => PlantProvider()),
      ],
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
          duration: const Duration(milliseconds: 400),
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


