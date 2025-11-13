import 'package:flutter/material.dart';
import 'package:plant_care/iam/domain/usecases/google_signin_usecase.dart';
import 'package:plant_care/presentation/navigation/app_router.dart';
import 'package:provider/provider.dart';
import 'community/domain/usecases/register_member_usecase.dart';
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

// ====== COMMUNITY IMPORTS ======
import 'community/data/datasources/post_api_datasource.dart';
import 'community/data/repositories/post_repository_impl.dart';
import 'community/domain/usecases/get_post_usecase.dart';
import 'community/domain/usecases/create_post_usecase.dart';
import 'community/application/providers/post_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      debugPrint("✅ Firebase inicializado correctamente");
    } else {
      debugPrint("⚠️ Firebase ya estaba inicializado, se omitió la reinicialización.");
    }
  } catch (e) {
    debugPrint("❌ Error al inicializar Firebase: $e");
  }

  // ==== INYECCIÓN MANUAL DE LOGIN / AUTH ====
  final authApiService = AuthApiService();
  final authRepository = AuthRepositoryImpl(authApiService);

  final loginUseCase = LoginUseCase(authRepository);
  final registerUseCase = RegisterUseCase(authRepository);
  final googleSignInUseCase = GoogleSignInUseCase();

  const baseUrl = "https://plantcare-awcchhb2bfg3hxgf.canadacentral-01.azurewebsites.net";

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),

        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            loginUseCase: loginUseCase,
            registerUseCase: registerUseCase,
            googleSignInUseCase: googleSignInUseCase,
          ),
        ),

        ChangeNotifierProvider(
          create: (_) {
            final datasource = PostApiDataSource(baseUrl);
            final repository = PostRepositoryImpl(datasource);

            return PostProvider(
              getPostsUseCase: GetPostsUseCase(repository),
              createPostUseCase: CreatePostUseCase(repository),
              registerMemberUseCase: RegisterMemberUseCase(repository), // ✔ AGREGADO
            );
          },
        ),
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
