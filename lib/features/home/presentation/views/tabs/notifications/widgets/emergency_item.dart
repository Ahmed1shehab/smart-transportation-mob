

 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
class EmergencyItem extends StatelessWidget {
  final String name;
  final String subtitle;
  final String? time;
  final bool showSwipe;
  final VoidCallback? onDismissed; // جديد

  const EmergencyItem({
    super.key,
    required this.name,
    required this.subtitle,
    this.time,
    this.showSwipe = false,
    this.onDismissed, // جديد
  });

  @override
  Widget build(BuildContext context) {
    final card = Stack(
      children: [
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
              ClipOval(
                child: Container(
                  height: 60,
                  width: 60,
                  color: const Color(0XFFEDEDED),
                  child: Center(
                    child: Image.asset(
                      AssetsManager.emergency,
                      height: 24,
                      width: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.heading.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0XFF000000),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          left: 0,
          top: 50,
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.circle, size: 10, color: Color(0XFFE84141)),
          ),
        ),
      ],
    );

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
