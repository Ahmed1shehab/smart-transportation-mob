import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/features/welcome/presentation/views/widget/build_step_with_line.dart';

class StepData {
  final String title;

  StepData({required this.title});
}
class StepsProgress extends StatelessWidget {
  final List<StepData> steps;
  final int currentStep;

  const StepsProgress({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isActive = index == currentStep;
        final isCompleted = index < currentStep;
        final isLast = index == steps.length - 1;

        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // مؤشر الدائرة والخط
              Column(
                children: [
                  // دائرة
                  buildStepCircle(isActive, isCompleted),

                  // خط تحت الدائرة
                  if (!isLast)
                    Container(
                      width: 1.5.w,
                      height: 72.h,
                      color: isCompleted || isActive
                          ? ColorsManager.primary
                          : ColorsManager.primary.withOpacity(0.3),
                    ),
                ],
              ),
              SizedBox(width: 12.w),

              // نص الخطوة
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step ${index + 1}:",
                    style: AppTextStyles.semiBold.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    step.title,
                    style: AppTextStyles.semiBold.copyWith(
                      fontSize: 14.sp,
                      color: ColorsManager.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
 
}
