import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/core/helper/on_generate_route.dart';

class RequestIsPending extends StatefulWidget {
  const RequestIsPending({super.key});

  @override
  State<RequestIsPending> createState() => _RequestIsPendingState();
}

class _RequestIsPendingState extends State<RequestIsPending> {
    @override
  void initState() {
    super.initState();

    // تأخير 3 ثواني ثم الانتقال لصفحة أخرى
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, OnGenerateRoute.home); // غير '/home' للمسار اللي عندك
    });
  }

  void _showSwitchAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent, // نخليه شفاف عشان نظبط الحجم
        insetPadding: EdgeInsets.symmetric(horizontal: 16), // padding خارجي
        child: UnconstrainedBox(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9, // العرض 90%
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, color: ColorsManager.primary,size: 20,),
                ),
              ),
             
                Text(
                  "Switch Account?",
                  style: AppTextStyles.heading.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.h),

          
                Text(
                  "Would you like to switch your account to Organizer account?",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: const Color(0XFF365E78),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "An Organizer manages the services, bus routes, driver assignments.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: const Color(0XFF365E78),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),

                
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                     
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      "Confirm",
                      style: AppTextStyles.semiBold.copyWith(
                        color: Colors.white,
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
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 192.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AssetsManager.pending, height: 161.h, width: 111.w),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "Your request is\n Pending!",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading.copyWith(
                    color: Color(0XFF1B4865).withOpacity(.8),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "You will be notified once your request\n is accepted by Service Provider",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.semiBold.copyWith(
                    color: Color(0XFF1B4865),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "If you apply to multiple service providers, approval of\n the first request will grant you access to the account.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFFCF5F5F),
                  ),
                ),
              ),
              
              Spacer(flex: 2),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Add your logic for adding service provider here
                  },
                  child: Container(
                    height: 45.h,
                    width: 326.w,
                    decoration: BoxDecoration(
                      color: ColorsManager.primary.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        "Add Service Provider",
                        style: AppTextStyles.semiBold.copyWith(
                          color: Color(0XFF1B4865),
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
          
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showSwitchAccountDialog(context);
                  },
                  child: Container(
                    height: 45.h,
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
                          color: Color(0XFF1B4865),
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}