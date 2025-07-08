import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';

void showCallDialog(BuildContext context, String supervisorName, VoidCallback onCallPressed) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Call Supervisor $supervisorName?',
              style: AppTextStyles.heading.copyWith(color: Colors.black,fontSize: 16.sp)
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CD7A5),  
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              icon: const Icon(Icons.call, color: Colors.white),
              label: const Text(
                'Call',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              ),
              onPressed: onCallPressed,
            ),
          ],
        ),
      ),
    ),
  );
}
