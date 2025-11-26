import 'package:flutter/material.dart';
import '../pages/plants_list_page.dart';

// Minimal placeholder for MyPlantsView referenced by the router.
class MyPlantsView extends StatelessWidget {
  const MyPlantsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Show the PlantsListPage with fake data so the UI can be previewed
    // without requiring the Cubit or remote API to be available.
    return const PlantsListPage(useFakeData: true);
  }
}
