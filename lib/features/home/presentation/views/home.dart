import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/features/home/presentation/views/tabs/menu/menu.dart';
import 'package:member/features/home/presentation/views/tabs/notifications/notifications.dart';
import 'package:member/features/home/presentation/views/tabs/students/views/students.dart';
import 'package:member/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:badges/badges.dart' as badges;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeViewBody(),
   StudentsProfilePage(),
     NotificationsPage(),
    MenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            selectedItemColor: ColorsManager.primary,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              const BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(AssetsManager.mapicon)),
                label: 'Map',
              ),
              const BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(AssetsManager.profile_user)),
                label: 'Students',
              ),
              BottomNavigationBarItem(
                icon: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -9, end: -10),

                  showBadge: true,
                  ignorePointer: false,
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: ColorsManager.primary,
                    padding: const EdgeInsets.all(5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  badgeContent: const Text(
                    '5',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  child: const ImageIcon(
                    AssetImage(AssetsManager.notification),
                  ),
                ),
                label: 'Notifications',
              ),

              const BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(AssetsManager.menu)),
                label: 'Menu',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
