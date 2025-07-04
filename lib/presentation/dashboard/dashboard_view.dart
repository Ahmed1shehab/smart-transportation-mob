import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import 'dashboard_viewmodel.dart';
import 'map.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool _isSupervising = false;

  void _startSupervising() {
    if (mounted) {
      setState(() {
        _isSupervising = true;
      });
    }
  }

  void _stopSupervising() {
    if (mounted) {
      setState(() {
        _isSupervising = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DashboardViewModel>(context, listen: false);
    final supervisorName = viewModel.supervisorName;

    return _isSupervising
        ? MapScreen(
      onBack: _stopSupervising,
      supervisorName: viewModel.supervisorName ?? 'Supervisor',
      tripId: viewModel.tripId ?? '',
    )
        : DashboardTripContent(
      onStart: _startSupervising,
      supervisorName: supervisorName ?? 'Supervisor',
    );
  }
}

class DashboardTripContent extends StatelessWidget {
  final VoidCallback onStart;
  final String supervisorName;

  const DashboardTripContent({
    super.key,
    required this.onStart,
    required this.supervisorName,
  });

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
          final isLoading = viewModel.isLoading;

          final hasTrip = trip != null;
          final driverName =
          hasTrip ? "${trip.driver.firstName} ${trip.driver.lastName}" : "-";
          final busModel = hasTrip ? trip.bus.model : "-";
          final studentCount = hasTrip ? trip.totalStudents.toString() : "-";
          final tripCountdown = hasTrip
              ? tr("trip_starts_in", args: [getTimeUntilTrip(trip.departureTime)])
              : tr("no_upcoming_trips");

          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                      text: "${tr("hi")} $supervisorName,\n",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.primary,
                      ),
                    ),
                    TextSpan(
                      text: tr("welcome_back"),
                      style: const TextStyle(
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
                  'today_with_date'.tr(args: [currentDate]),
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
                    tripCountdown,
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
                    Expanded(child: smallCard(Icons.directions_bus, busModel)),
                    const SizedBox(width: 12),
                    Expanded(child: smallCard(Icons.person, driverName)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              largeCard(tr("total_students"), studentCount),
              const SizedBox(height: 320),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: hasTrip ? onStart : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      tr("start_supervising"),
                      style: const TextStyle(
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

  Widget smallCard(IconData icon, String label) {
    return Container(
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
    );
  }

  Widget largeCard(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 75,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ColorManager.primary.withAlpha((0.15 * 255).toInt()),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500)),
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
    );
  }
}
