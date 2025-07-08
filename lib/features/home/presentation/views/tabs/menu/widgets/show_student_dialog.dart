import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/on_generate_route.dart';

void showStudentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- Close Button ---
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close, color: Colors.grey),
                ),
              ),

              // --- Name ---
              Text(
                'Omar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),

              // --- Image ---
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/omar.png', //   غيّر المسار حسب الصورة الفعلية
                  height: 160,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.h),

              // --- Address ---
              Text(
                'Mansoura , Gehan Street',
                style: AppTextStyles.body.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFF000000),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),

              // --- Phone ---
              Text(
                '+20 1058576968',
                style: AppTextStyles.body.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFF000000),
                ),
              ),
              SizedBox(height: 24.h),

              // --- Edit Button ---
              SizedBox(
                width: 225.w,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, OnGenerateRoute.studentInformationPage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF7FB9DC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    elevation: 4,
                  ),
                  child: Text(
                    'Edit',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
