import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Importa las vistas que usaremos
import '../views/login_view.dart';
import '../views/dashboard_view.dart';
import '../views/myplants_view.dart';
import '../views/plant_detail_view.dart';
import '../views/history_view.dart';
import '../views/settings_view.dart';
import '../views/register_view.dart'; // futura pantalla de registro
import '../views/search_filter_view.dart'; // futura pantalla de búsqueda y filtros

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: '/myplants',
      name: 'myplants',
      builder: (context, state) => const MyPlantsView(),
    ),
    GoRoute(
      path: '/plant/:id',
      name: 'plantDetail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return PlantDetailView(plantId: id);
      },
    ),
    GoRoute(
      path: '/history',
      name: 'history',
      builder: (context, state) => const HistoryView(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsView(),
    ),
    GoRoute(
      path: '/search',
      name: 'searchFilter',
      builder: (context, state) => const SearchFilterView(),
    ),
  ],
);
