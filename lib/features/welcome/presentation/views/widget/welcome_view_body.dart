import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/core/helper/on_generate_route.dart';
import 'package:member/features/service/presentation/views/servies_view.dart';
import 'package:member/features/welcome/presentation/views/widget/steps_progress.dart';
import 'package:member/features/welcome/presentation/views/widget/show_terms_dialog.dart';

class WelcomeViewBody extends StatefulWidget {
  const WelcomeViewBody({super.key});

  @override
  State<WelcomeViewBody> createState() => _WelcomeViewBodyState();
}

class _WelcomeViewBodyState extends State<WelcomeViewBody> {
  final int currentStep = 0;
  Widget build(BuildContext context) {
    //Future.microtask(() => showTermsDialog(context));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 136.h),
          Center(child: Text("Welcome Maryam!", style: AppTextStyles.heading)),
          SizedBox(height: 40.h),
          Center(
            child: Text(
              "Please provide the following details to complete your member account",
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold,
            ),
          ),
          SizedBox(height: 60.h),

          StepsProgress(
            currentStep: 0,
            steps: [
              StepData(title: "Join Service Provider"),
              StepData(title: "Add Student’s Details"),
              StepData(title: "Add Address"),
            ],
          ),

          Spacer(flex: 2),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ServicesView(isInSettings: false,)));
              },
              child: Container(
                height: 42.h,
                width: 326.w,
                decoration: BoxDecoration(
                  color: Color(0XFF509BC7),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    "Start",
                    style: AppTextStyles.semiBold.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Center(
            child: Container(
              height: 42.h,
              width: 326.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Color(0XFF9FCBE5)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  "Switch Account Type",
                  style: AppTextStyles.semiBold.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
