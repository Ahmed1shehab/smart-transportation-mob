import 'package:flutter/material.dart';
import 'Gallery.dart';
import 'Home(Track).dart';
import 'Notifications/Notification.dart';
import 'Profile Management/Profile Management.dart';
import 'map.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    Gallery(),
    NotificationsScreen(),
    ProfileManagement(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F1F1),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  const MapScreen()));
          },
          backgroundColor: const Color(0xff5fa8d3),
          child: Image.asset(
            'assets/images/map3.png',
            width: 40,
            height: 40,
            //color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.location_on_outlined, "Map", 0),
            _buildNavItem(Icons.photo_library_outlined, "Gallery", 1),
            _buildNavItem(Icons.notifications_none_rounded, "Notifications", 2),
            _buildNavItem(Icons.person_outline_rounded, "Profile", 3),
          ],
        ),
      ),
      body: _screens[_currentIndex],

    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? const Color(0xff73B3D8) : const Color(0xff727272)),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xff73B3D8) : const Color(0xff727272),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
