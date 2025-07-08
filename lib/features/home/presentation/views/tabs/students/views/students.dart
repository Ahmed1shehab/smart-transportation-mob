import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/on_generate_route.dart';

class StudentsProfilePage extends StatelessWidget {
  const StudentsProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          "Student’s information",
          style: AppTextStyles.heading.copyWith(
            color: Color(0XFF000000),
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F9FF),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: -0.1,

              child: Container(
                height: 596.h,
                width: 354.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6ECFF),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),

            // ✅ Main card
            Container(
              height: 596.h,
              width: 354.w,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Name and edit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        "Omar",
                        style: AppTextStyles.heading.copyWith(
                          color: Color(0XFF1B4865),
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, OnGenerateRoute.studentInformationPage);
                        },
                        child: Image.asset(
                          AssetsManager.edit,
                          height: 24.h,
                          width: 23.w,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Image
                  Container(
                    width: 230.h,
                    height: 220.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage(AssetsManager.kid),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Address and phone
                  Text(
                    "Mansoura , Gehan Street\n+20 1058576968",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  Spacer(),

                  // Instruction text
                  Text(
                    "For Attendance Management\n& Previous Trip Info",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading.copyWith(
                      color: Color(0XFF1B4865),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Calendar button
                  SizedBox(
                    width: 176.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B4865),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {

                        Navigator.pushNamed(context, OnGenerateRoute.calendarPage);
                      },
                      child:   Text(
                        "Calendar",
             style: AppTextStyles.heading.copyWith(color: Colors.white,fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
