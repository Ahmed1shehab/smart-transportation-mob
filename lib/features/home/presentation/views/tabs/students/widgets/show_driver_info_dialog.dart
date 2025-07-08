import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/colors_manager.dart';
void showDriverInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      int selectedTabIndex = 0; // 0 = driver_icon, 1 = card_icon

      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            child: Container(
              constraints: BoxConstraints(maxWidth: 600.w),
              padding: EdgeInsets.all(16.r),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "September 1",
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 20.sp,
                          color: ColorsManager.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Center(child: Image.asset(AssetsManager.driver_bus_icon, height: 17.h, width: 18.w)),
                    SizedBox(height: 4.h),
                    Center(
                      child: Text(
                        "Bus Num #8900",
                        style: AppTextStyles.semiBold.copyWith(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    /// صورة السائق
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.asset(
                          AssetsManager.driver,
                          height: 120.h,
                          width: 120.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    /// الصور التفاعلية (Tabs)
              Row(
  children: [
    Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTabIndex = 0),
        child: Column(
          children: [
            Image.asset(
              AssetsManager.driver_icon,
              height: 50.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 8.h),
            Container(
              height: 4.h,
              color: selectedTabIndex == 0 ? ColorsManager.primary : Colors.grey.shade300,
            ),
          ],
        ),
      ),
    ),
    Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTabIndex = 1),
        child: Column(
          children: [
            Image.asset(
              AssetsManager.card_icon,
              height: 50.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 8.h),
            Container(
              height: 4.h,
              color: selectedTabIndex == 1 ? ColorsManager.primary : Colors.grey.shade300,
            ),
          ],
        ),
      ),
    ),
  ],
),


                    SizedBox(height: 12.h),
                  SizedBox(height: 12.h),

if (selectedTabIndex == 0) ...[
  Divider(thickness: 1.h),
  _buildInfoRow(title: "Driver Name", value: "Mahmoud"),
  SizedBox(height: 8.h),
  _buildInfoRow(title: "Violations", value: "No Violations."),
  SizedBox(height: 8.h),
  _buildInfoRow(title: "Completed Trips", value: "20"),
  SizedBox(height: 8.h),
  _buildInfoRow(title: "Safety Records", value: "No accidents reported"),
  SizedBox(height: 12.h),
  Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: _buildInfoRow(title: "Call Supervisor", value: "")),
      SizedBox(width: 8.w),
      Image.asset(AssetsManager.call, height: 24.h, width: 24.h),
    ],
  ),
  SizedBox(height: 12.h),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Rate Driver:", style: AppTextStyles.semiBold.copyWith(fontSize: 14)),
      Row(
        children: List.generate(5, (index) {
          return Icon(Icons.star, color: Color(0XFFFFC861), size: 24.sp);
        }),
      ),
    ],
  ),
  SizedBox(height: 8.h),
  TextField(
    decoration: InputDecoration(
      hintText: "Add a comment...",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      isDense: true,
      contentPadding: EdgeInsets.all(12.r),
    ),
    style: TextStyle(fontSize: 14.sp),
    maxLines: 3,
  ),
] else if (selectedTabIndex == 1) ...[
  Divider(thickness: 1.h),
  _buildInfoRow(title: "License Number", value: "162 428"),
  SizedBox(height: 8.h),
  _buildInfoRow(title: "License Issue Date", value: "20/11/2024"),
  SizedBox(height: 8.h),
  _buildInfoRow(title: "License Expiration Date", value: "20/11/2025"),
  SizedBox(height: 8.h),
  _buildInfoRowWithColor(
    title: "License Status",
    value: "Active",
    valueColor: Colors.green,
  ),
],

                    SizedBox(height: 12.h),
 

              

                    /// زر Done
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFFCAE9FE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text(
                          "Done",
                          style: AppTextStyles.heading.copyWith(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
Widget _buildTabIcon({
  required String imageUrl,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imageUrl,
          height: 40.h,
          width: 40.h,
          color: isSelected ? null : Colors.grey, // رمادي إذا غير مفعّل
        ),
        SizedBox(height: 4.h),
        Container(
          height: 4.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: isSelected ? ColorsManager.primary : Colors.grey[300],
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ],
    ),
  );
}



// دالة مساعدة لإنشاء صفوف المعلومات
Widget _buildInfoRow({
  required String title,
  required String value,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
 
      Expanded(
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: "$title: ",
                style: AppTextStyles.semiBold.copyWith(fontSize: 14),
              ),
              TextSpan(
                text: value,
                style: AppTextStyles.body.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
Widget _buildInfoRowWithColor({
  required String title,
  required String value,
  required Color valueColor,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 14.sp, color: Colors.black),
            children: [
              TextSpan(
                text: "$title: ",
                style: AppTextStyles.semiBold.copyWith(fontSize: 14),
              ),
              TextSpan(
                text: value,
                style: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
