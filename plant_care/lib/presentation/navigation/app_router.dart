import 'package:go_router/go_router.dart';

import '../../community/presentation/views/community_screen.dart';
import '../../community/presentation/views/create_post_view.dart';
import '../../iam/presentation/widgets/login_view.dart';
import '../../dashboard/presentation/widgets/dashboard_view.dart';
import '../../plant_detail/presentation/widgets/plant_detail_view.dart';
import '../../history/presentation/widgets/history_view.dart';
import '../views/settings_view.dart';
import '../../iam/presentation/widgets/register_view.dart';
import '../views/search_filter_view.dart';
import '../../subscription/presentation/pages/subscription_view.dart';
import '../../plants/presentation/widgets/myplants_view.dart';
import 'package:plant_care/presentation/views/splash_view.dart';

// 👇 AGREGAR ESTE IMPORT
import '../../community/presentation/views/comunity_feed_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashView(),
    ),
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
      name: 'plant_detail',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
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
    GoRoute(
      path: '/subscription',
      name: 'subscription',
      builder: (context, state) => const SubscriptionView(),
    ),
    GoRoute(
      path: '/community',
      name: 'community',
      builder: (context, state) => const CommunityScreen(),
    ),
    GoRoute(
      path: '/create-post',
      name: 'createPost',
      builder: (context, state) => const CreatePostView(),
    ),

  ],
);
