import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../resources/color_manager.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationsPageViewModel(),
      child: Scaffold(
        key: ValueKey(context.locale.languageCode),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'notifications'.tr(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
        body: const _NotificationsBody(),
      ),
    );
  }
}

class _NotificationsBody extends StatelessWidget {
  const _NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NotificationsPageViewModel>(context);
    final grouped = vm.groupedNotifications;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tabs(
                title: 'bus'.tr(),
                selected: vm.selectedType == NotificationType.bus,
                onTap: () => vm.switchTab(NotificationType.bus),
                TabColor: ColorManager.black,
              ),
              const SizedBox(width: 100),
              Tabs(
                title: 'emergency'.tr(),
                selected: vm.selectedType == NotificationType.emergency,
                onTap: () => vm.switchTab(NotificationType.emergency),
                TabColor: ColorManager.black,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: vm.notifications.isEmpty
              ? Center(
            child: Text(
              vm.selectedType == NotificationType.bus
                  ? 'no_bus_notifications'.tr()
                  : 'no_emergency_notifications'.tr(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            itemCount: grouped.length,
            itemBuilder: (context, index) {
              final date = grouped.keys.elementAt(index);
              final items = grouped[date]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      date,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ...items.map((notification) =>
                      Notifications(notification: notification)),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class Tabs extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  final Color TabColor;

  const Tabs({
    required this.title,
    required this.selected,
    required this.onTap,
    required this.TabColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: selected ? TabColor : ColorManager.grey,
        ),
      ),
    );
  }
}

class Notifications extends StatelessWidget {
  final NotificationItem notification;

  const Notifications({required this.notification});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NotificationsPageViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Dismissible(
        key: ValueKey(notification.id),
        direction: DismissDirection.endToStart,
        background: _buildDismissBackground(context),
        onDismissed: (_) => vm.deleteNotification(notification.id),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildIcon(),
                  if (!notification.isRead)
                    Positioned(
                      top: 16,
                      left: context.locale.languageCode == 'en' ? -30 : null,
                      right: context.locale.languageCode == 'ar' ? -30 : null,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: ColorManager.dark_blue,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      notification.subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDismissBackground(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: Colors.red.withOpacity(0.2),
        alignment: context.locale.languageCode == 'ar'
            ? Alignment.centerLeft
            : Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(Icons.delete, color: Colors.red),
      ),
    );
  }


  Widget _buildIcon() {
    if (notification.type == NotificationType.bus) {
      return const CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage('assets/images/supervisor/Reem.png'),
      );
    } else {
      return CircleAvatar(
        radius: 24,
        backgroundColor: ColorManager.grey.withOpacity(0.3),
        child: ClipOval(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              'assets/images/supervisor/emergency.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }
  }
}

// Dummy ViewModel and Model

class NotificationsPageViewModel extends ChangeNotifier {
  final List<NotificationItem> _notifications = [];
  NotificationType _selectedType = NotificationType.bus;

  NotificationsPageViewModel() {
    _loadDummyData();
  }

  List<NotificationItem> get notifications =>
      _notifications.where((n) => n.type == _selectedType).toList();

  NotificationType get selectedType => _selectedType;

  Map<String, List<NotificationItem>> get groupedNotifications {
    final Map<String, List<NotificationItem>> grouped = {};
    for (var n in notifications) {
      final dateKey = _formatDate(n.dateTime);
      grouped.putIfAbsent(dateKey, () => []).add(n);
    }
    return grouped;
  }

  void switchTab(NotificationType type) {
    _selectedType = type;
    notifyListeners();
  }

  void deleteNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'today_label'.tr();
    } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
      return 'yesterday'.tr();
    } else {
      return "${'month_${_monthName(date.month)}'.tr()} ${date.day}, ${date.year}";
    }
  }

  String _monthName(int month) {
    const months = [
      'january', 'february', 'march', 'april', 'may', 'june',
      'july', 'august', 'september', 'october', 'november', 'december'
    ];
    return months[month - 1];
  }

  void _loadDummyData() {
    _notifications.addAll([
      NotificationItem(
        id: '1',
        title: 'Bus Arrived to Reem!',
        subtitle: 'Please wait for Reem to arrive',
        dateTime: DateTime.now().subtract(const Duration(minutes: 10)),
        type: NotificationType.bus,
        isRead: false,
      ),
      NotificationItem(
        id: '2',
        title: 'Bus is about to arrive to Reem',
        subtitle: '2 mins left',
        dateTime: DateTime.now().subtract(const Duration(minutes: 5)),
        type: NotificationType.bus,
        isRead: true,
      ),
      NotificationItem(
        id: '3',
        title: 'Maintenance Notice',
        subtitle: 'Bus will not be available tomorrow',
        dateTime: DateTime.now().subtract(const Duration(minutes: 20)),
        type: NotificationType.emergency,
        isRead: false,
      ),
      NotificationItem(
        id: '4',
        title: 'Maintenance Completed',
        subtitle: 'Bus is ready for service',
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        type: NotificationType.emergency,
        isRead: true,
      ),
    ]);
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final DateTime dateTime;
  final NotificationType type;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.type,
    required this.isRead,
  });
}

enum NotificationType {
  bus,
  emergency,
}
