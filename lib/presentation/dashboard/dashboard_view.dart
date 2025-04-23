import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import 'dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardTripContent();
  }
}

class DashboardTripContent extends StatelessWidget {
  const DashboardTripContent({super.key});

  String getTimeUntilTrip(DateTime tripTime) {
    final now = DateTime.now();
    final diff = tripTime.difference(now);
    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);
    return "${hours}h ${minutes}m";
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat.yMMMMd().format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
      child: Consumer<DashboardViewModel>(
        builder: (context, viewModel, _) {
          final trip = viewModel.trip;

          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (trip == null) {
            return const Center(child: Text("No upcoming trips."));
          }

          final countdown = getTimeUntilTrip(trip.departureTime);
          final driverFullName =
              "${trip.driver.firstName} ${trip.driver.lastName}";
          final supervisorName =
              "${trip.supervisor.firstName} ${trip.supervisor.lastName}";

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                      text: "Hi $supervisorName,\n",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.primary,
                      ),
                    ),
                    const TextSpan(
                      text: "Welcome Back!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Today, $currentDate",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.dark_blue,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/supervisor/paint_brush.png',
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    "Trip starts in $countdown",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.white,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(child: smallCards(Icons.directions_bus, trip.bus.model)),
                    const SizedBox(width: 12),
                    Expanded(child: smallCards(Icons.person, driverFullName)),
                  ],
                ),
              ),


              const SizedBox(height: 30),
              largeCards("Total Students", trip.totalStudents.toString()),

              const SizedBox(height: 320),

              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Button
                      print("Start Supervising pressed!");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Start Supervising!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget smallCards(IconData icon, String label) {
    return Expanded(
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: ColorManager.primary.withAlpha((0.15 * 255).toInt()),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: ColorManager.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeightManager.medium,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget largeCards(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 12 , right: 12),
      child: Container(
        height: 75,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ColorManager.primary.withAlpha((0.15 * 255).toInt()),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 16 , fontWeight: FontWeight.w500)),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
