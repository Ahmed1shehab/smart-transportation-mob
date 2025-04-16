import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat.yMMMMd().format(DateTime.now());

    return Scaffold(
      bottomNavigationBar: Container(
        height: 88,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -1),
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedLabelStyle: const TextStyle(fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 10),
            onTap: (index) {
              // TODO: Handle nav
            },
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                activeIcon: Icon(Icons.location_on_sharp),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_outline),
                activeIcon: Icon(Icons.people),
                label: 'Students',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    Icon(Icons.notifications_none),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.red,
                        child: Text(
                          '3',
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                activeIcon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Menu',
              ),
            ],
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.titleLarge,
                children: [
                  TextSpan(
                    text: "Hi Layla,\n",
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
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: Text(
                  "Today, $currentDate",
                  style: TextStyle(
                    fontSize: 28, //
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.dark_blue,
                  ),
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
                  "Next trip is in 4 hours",
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
            Row(
              children: [
                _infoCard(Icons.directions_bus, "8900"),
                const SizedBox(width: 16),
                _infoCard(Icons.person, "Mahmoud"),
              ],
            ),
            const SizedBox(height: 30),

            // Flexible summary section
            Flexible(
              child: Column(
                children: [
                  _summaryCard("Total Students", "25"),
                  const SizedBox(height: 20),
                  _summaryCard("Present Students", "20"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Start Supervising Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Add supervising action
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
            const SizedBox(height: 10), // extra padding from bottom nav
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String label) {
    return Expanded(
      child: Container(
        height: 72,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorManager.primary.withOpacity(0.2),
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

  Widget _summaryCard(String label, String value) {
    return Container(
      height: 72,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 14)),
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
