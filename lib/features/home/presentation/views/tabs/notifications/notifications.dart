import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/features/home/presentation/views/tabs/notifications/widgets/Emergency_item.dart';
import 'package:member/features/home/presentation/views/tabs/notifications/widgets/circle_tab.dart';
import 'package:member/features/home/presentation/views/tabs/notifications/widgets/notification_item.dart';
import 'package:member/features/home/presentation/views/tabs/notifications/widgets/section_header.dart';
 
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int selectedTabIndex = 0; // 0 = Bus, 1 = Emergency

  List<Map<String, dynamic>> todayBusNotifications = [
    {
      "name": "Reem's bus arrived!",
      "subtitle": "Please meet the bus outside",
      "time": null,
      "image": AssetsManager.kid2,
      "showSwipe": true,
    },
    {
      "name": "Reem's bus is about to arrive",
      "subtitle": "2 mins left",
      "time": "2 mins left",
      "image": AssetsManager.kid2,
      "showSwipe": true,
    },
    {
      "name": "Omar’s bus arrived!",
      "subtitle": "Please meet the bus outside",
      "time": null,
      "image": AssetsManager.kid1,
      "showSwipe": true,
    },
    {
      "name": "Omar’s bus is about to arrive",
      "subtitle": "1 min left",
      "time": "1 min left",
      "image": AssetsManager.kid1,
      "showSwipe": true,
    },
  ];

  List<Map<String, dynamic>> yesterdayBusNotifications = [
    {
      "name": "Omar’s bus arrived!",
      "subtitle": "Please meet the bus outside",
      "time": null,
      "image": AssetsManager.kid1,
      "showSwipe": true,
    },
  ];

  List<Map<String, String>> todayEmergencyNotifications = [
    {
      "name": "Omar’s Bus was in an accident!",
      "subtitle": "We will notify you with more details"
    },
    {
      "name": "Omar’s Bus was in an accident!",
      "subtitle": "We will notify you with more details"
    },
    {
      "name": "Omar’s Bus was in an accident!",
      "subtitle": "We will notify you with more details"
    },
  ];

  List<Map<String, String>> yesterdayEmergencyNotifications = [
    {
      "name": "Omar’s Bus was in an accident!",
      "subtitle": "We will notify you with more details"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Notifications",
                  style: AppTextStyles.heading.copyWith(
                      color: const Color(0XFF000000), fontSize: 20)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => selectedTabIndex = 0),
                    child: CircleTab(title: "Bus", selected: selectedTabIndex == 0),
                  ),
                  SizedBox(width: 100.w),
                  GestureDetector(
                    onTap: () => setState(() => selectedTabIndex = 1),
                    child: CircleTab(title: "Emergency", selected: selectedTabIndex == 1),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: selectedTabIndex == 0
                      ? _buildBusNotifications()
                      : _buildEmergencyNotifications(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

List<Widget> _buildBusNotifications() {
  return [
    const SectionHeader(title: "Today"),
    ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: todayBusNotifications.length,
      itemBuilder: (context, index) {
        final item = todayBusNotifications[index];
        return NotificationItem(
          key: ValueKey('today_${item['name']}_${item['subtitle']}_$index'),
          name: item["name"],
          subtitle: item["subtitle"],
          time: item["time"],
          image: item["image"],
          showSwipe: item["showSwipe"],
          onDismissed: () {
            setState(() {
              todayBusNotifications.removeAt(index);
            });
          },
        );
      },
    ),
    const SizedBox(height: 16),
    const SectionHeader(title: "Yesterday , September 1"),
    ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: yesterdayBusNotifications.length,
      itemBuilder: (context, index) {
        final item = yesterdayBusNotifications[index];
        return NotificationItem(
          key: ValueKey('yesterday_${item['name']}_${item['subtitle']}_$index'),
          name: item["name"],
          subtitle: item["subtitle"],
          time: item["time"],
          image: item["image"],
          showSwipe: item["showSwipe"],
          onDismissed: () {
            setState(() {
              yesterdayBusNotifications.removeAt(index);
            });
          },
        );
      },
    ),
  ];
}



  List<Widget> _buildEmergencyNotifications() {
    return [
      const SectionHeader(title: "Today"),
      ...todayEmergencyNotifications.asMap().entries.map(
        (entry) => EmergencyItem(
          name: entry.value["name"]!,
          subtitle: entry.value["subtitle"]!,
          time: null,
          showSwipe: true,
          onDismissed: () {
            setState(() {
              todayEmergencyNotifications.removeAt(entry.key);
            });
          },
        ),
      ),
      const SectionHeader(title: "Yesterday , September 1"),
      ...yesterdayEmergencyNotifications.asMap().entries.map(
        (entry) => EmergencyItem(
          name: entry.value["name"]!,
          subtitle: entry.value["subtitle"]!,
          time: null,
          showSwipe: true,
          onDismissed: () {
            setState(() {
              yesterdayEmergencyNotifications.removeAt(entry.key);
            });
          },
        ),
      ),
    ];
  }
}
