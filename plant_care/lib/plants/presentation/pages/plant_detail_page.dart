import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:plant_care/plants/domain/entities/plant.dart';
import 'package:plant_care/plants/domain/value_objetcs/plant_status.dart';
import 'package:plant_care/plants/presentation/widgets/metrics_card.dart'; 

class PlantDetailPage extends StatelessWidget {
  final Plant plant; 

  const PlantDetailPage({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text(plant.name)),
      
      body: SafeArea(
        top: false,
        bottom: true,
        child: PlantDetailPageContent(plant: plant),
      ),
    );
  }
}

class PlantDetailPageContent extends StatelessWidget {
  final Plant plant;
  const PlantDetailPageContent({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    
    const backgroundColor = Color(0xFFF2F2F7);

    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(), 
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                40 + MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  
                  Text(
                    plant.type.toUpperCase(),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),

                  
                  _buildInfoRow(context),
                  const SizedBox(height: 24),

                  
                  _iOSSectionTitle('Biography'),
                  _iOSContentContainer(
                    child: Text(
                      plant.bio,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Color(0xFF3A3A3C), 
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  
                  _iOSSectionTitle('Irrigation Cycle'),
                  Row(
                    children: [
                      Expanded(
                        child: _WateringTile(
                          label: 'Last watering',
                          date: plant.lastWatered,
                          icon: Icons.water_drop_rounded,
                          color: const Color(0xFF007AFF), 
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _WateringTile(
                          label: 'Next watering',
                          date: plant.nextWatering,
                          icon: Icons.access_alarm_rounded,
                          color: const Color(0xFFFF9500), 
                          isNext: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

               
                  _iOSSectionTitle('Live sensors'),
                  if (plant.latestMetric != null)
                  
                    MetricsCard(metric: plant.latestMetric!)
                  else
                    _iOSContentContainer(
                      child: const Center(
                        child: Text('Connecting sensors...'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350,
      backgroundColor: Colors.transparent,
      stretch: true,
      pinned: true,
      leading: Container(
        margin: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: const Color.fromARGB(127, 255, 255, 255),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: const Color.fromARGB(127, 255, 255, 255),
                child: IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 18,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
           
            Image.network(plant.imgUrl, fit: BoxFit.cover),
            
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.2), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helpers iOS-like ---
  Widget _buildInfoRow(BuildContext context) {
    Color statusColor;
    String statusText;
    switch (plant.status) {
      case PlantStatus.HEALTHY:
        statusColor = Colors.green;
        statusText = 'Healthy';
        break;
      case PlantStatus.WARNING:
        statusColor = Colors.orange;
        statusText = 'Warning';
        break;
      case PlantStatus.DANGER:
        statusColor = Colors.red;
        statusText = 'In danger';
        break;
      case PlantStatus.CRITICAL:
        statusColor = Colors.deepPurple;
        statusText = 'Critical';
        break;
      case PlantStatus.UNKNOWN:
        statusColor = Colors.grey;
        statusText = 'Unknown';
        break;
    }

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: statusColor.withAlpha(31),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Colors.grey,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  plant.location,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _iOSSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _iOSContentContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _WateringTile({
    required String label,
    required DateTime date,
    required IconData icon,
    required Color color,
    bool isNext = false,
  }) {
    final formatted = '${date.day}/${date.month}/${date.year}';
    return _iOSContentContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha(31),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(formatted, style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ],
          ),
          if (isNext) ...[
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                elevation: 0,
              ),
              child: const Text('Mark as watered'),
            ),
          ],
        ],
      ),
    );
  }
}
