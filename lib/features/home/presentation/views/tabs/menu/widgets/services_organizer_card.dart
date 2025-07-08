import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/colors_manager.dart';
class ServicesOrganizerCard extends StatelessWidget {
  final String name;
  final String organizer;
  final bool isSelected;

  const ServicesOrganizerCard({
    super.key,
    required this.name,
    required this.organizer,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 162.h,
      width: 369.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        border: Border.all(
          color: isSelected ? ColorsManager.primary : const Color(0XFFCAE9FE),
          width: isSelected ? 3 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCAE9FE), 
            offset: const Offset(4, 4),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsManager.ellipse_icon,
              height: 50.h,
              width: 50.w,
            ),
            SizedBox(height: 8.h),
            Text(
              name,
              style: AppTextStyles.semiBold.copyWith(fontSize: 16.sp),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Text(
              "Organizer: $organizer",
              style: AppTextStyles.body.copyWith(fontSize: 10.sp),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
