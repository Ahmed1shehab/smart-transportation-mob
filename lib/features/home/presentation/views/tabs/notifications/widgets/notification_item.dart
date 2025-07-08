

 
import 'package:flutter/material.dart';
import 'package:member/core/helper/assets_manager.dart';

class NotificationItem extends StatelessWidget {
  final String name;
  final String subtitle;
  final String? time;
  final String image;
  final bool showSwipe;
  final VoidCallback? onDismissed; // جديد
  const NotificationItem({
    super.key,
    required this.name,
    required this.subtitle,
    required this.image,
    this.time,
    this.showSwipe = false,
    this.onDismissed, 

  });

  @override
  Widget build(BuildContext context) {
    // تحديد الأيقونة بناءً على النص
    final bool isArrived = name.toLowerCase().contains("arrived");
    final String badgeIcon = isArrived
        ? AssetsManager.school_bus    // لو "arrived" → باص
        : AssetsManager.arrived;      // لو "about to arrive" → علامة وصول

    final card = Stack(
      children: [
        // الكارد الأساسي
        Container(
          margin: const EdgeInsets.only(left: 20, bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  // صورة الطفل
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage(image),
                  ),
                  // الأيقونة بأسفل يمين الصورة
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC3DEEF),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          badgeIcon,
                          height: 14,
                          width: 14,
                          fit: BoxFit.contain,
                        ),
                      ),
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
                      name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // النقطة على اليسار
        const Positioned(
          left: 0,
          top: 50,
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.circle, size: 10, color: Color(0XFF1B4865)),
          ),
        ),
      ],
    );

    // دعم السحب للحذف
    if (showSwipe && onDismissed != null) {
      return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          color: Colors.red.shade400,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (_) => onDismissed!(),
        child: card,
      );
    } else {
      return card;
    }
  }
}
