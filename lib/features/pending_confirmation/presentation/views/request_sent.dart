import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/core/helper/on_generate_route.dart';

class RequestSent extends StatefulWidget {
  const RequestSent({super.key});

  @override
  State<RequestSent> createState() => _RequestSentState();
}
class _RequestSentState extends State<RequestSent> {
  @override
  void initState() {
    super.initState();

    // تأخير 3 ثواني ثم الانتقال لصفحة أخرى
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, OnGenerateRoute.requestIspending); // غير '/home' للمسار اللي عندك
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              AssetsManager.request_done,
              height: 210.h,
              width: 210.w,
            ),
            SizedBox(height: 30.h),
            Center(child: Text("Request Sent!", style: AppTextStyles.heading)),
            SizedBox(height: 30.h),
            Center(
              child: Text(
                "You will be notified once your \n request is accepted",
                textAlign: TextAlign.center,
                style: AppTextStyles.semiBold.copyWith(
                  color: ColorsManager.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
