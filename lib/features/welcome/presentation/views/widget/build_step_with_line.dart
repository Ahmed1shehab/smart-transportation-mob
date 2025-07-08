
  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/colors_manager.dart';

  Widget buildStepCircle(bool isActive, bool isCompleted) {
    if (isCompleted) {
      return Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          color: ColorsManager.primary,
          shape: BoxShape.circle,
        ),
      );
    } else if (isActive) {
      return Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: ColorsManager.primary, width: 1.5),
        ),
        child: Center(
          child: Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManager.primary,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          color: const Color(0xFFBFDCED).withOpacity(.5),
          shape: BoxShape.circle,
          border: Border.all(color: ColorsManager.primary, width: 1.5),
        ),
      );
    }
  }