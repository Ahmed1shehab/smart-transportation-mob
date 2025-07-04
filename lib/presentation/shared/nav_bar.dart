import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../dashboard/dashboard_view.dart';
import '../dashboard/dashboard_viewmodel.dart';
import '../students/students_page.dart';
import '../students/students_viewmodel.dart';
import '../notifications/notifications_page.dart';
import '../menu/menu_page.dart';
import '../resources/color_manager.dart';

/// Bottom Navigation Bar Widget
class Nav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Nav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          key: ValueKey(context.locale.languageCode),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: onTap,
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: Colors.grey,
          iconSize: 28,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.location_on),
              label: 'nav.map'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(currentIndex == 1 ? Icons.people : Icons.people_outline),
              label: 'nav.students'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(currentIndex == 2
                      ? Icons.notifications
                      : Icons.notifications_none),
                  if (currentIndex != 2)
                    const Positioned(
                      top: -3,
                      right: -2,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text(
                          '3',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              label: 'nav.notifications'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu),
              label: 'nav.menu'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Root screen managing tabs and content
class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;
  late StudentsViewModel studentsViewModel;

  @override
  void initState() {
    super.initState();
    studentsViewModel = StudentsViewModel();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = Provider.of<DashboardViewModel>(context);
    final tripId = dashboardViewModel.tripId ?? '';

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StudentsViewModel>.value(value: studentsViewModel),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const DashboardView(),
            dashboardViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : StudentsPage(tripId: tripId),
            const NotificationsPage(),
            const MenuPage(),
          ],
        ),
        bottomNavigationBar: Nav(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}
