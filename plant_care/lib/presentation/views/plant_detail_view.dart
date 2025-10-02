import 'package:flutter/material.dart';

class PlantDetailView extends StatelessWidget {
  final String plantId;
  const PlantDetailView({super.key, required this.plantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Plant Detail: $plantId")),
      body: const Center(child: Text("Plant Detail View")),
    );
  }
}
