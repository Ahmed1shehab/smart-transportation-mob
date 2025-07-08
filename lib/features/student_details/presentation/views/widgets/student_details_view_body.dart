import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/on_generate_route.dart';

class StudentDetailsViewBody extends StatelessWidget {
  const StudentDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  
      
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade100),
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
  

                  // Upload Photos Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Upload photos",
                        style: TextStyle(
                          color: Color(0XFF61B6CB),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        "min 5 photos",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Upload Box
                  Container(
                    height: 159.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade100),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                     Image.asset(AssetsManager.image,height: 20.h,width: 20.w,),
                          SizedBox(height: 8.h),
                          Text(
                            "Select Photos",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // OR Button
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor:const Color(0XFF1B4865).withOpacity(.22)
,
                        padding: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 12.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: Text(
                        "Open Camera & Take Photos",
                        style: TextStyle(
                          color: Color(0XFF1B4865),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Name
                  _buildLabel("Name:"),
                  _buildTextField(),

                  // National ID
                  _buildLabel("National ID:"),
                  _buildTextField(),

                  // Grade
                  _buildLabel("Grade:"),
                  _buildTextField(),

                  // Disability Info
                  _buildLabel(
                      "If the student has disability , please provide us with further details:"),
                  _buildTextField(
                    minLines: 5,
                    maxLines: 5,
                    hint: "Optional",
                  ),
                  SizedBox(height: 24.h),

                  // Next Button
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () {

                          Navigator.pushReplacementNamed(context, OnGenerateRoute.step3View);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF63A8D3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );
      
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 6.h),
      child: Text(
        text,
        style: AppTextStyles.semiBold
      ),
    );
  }

  Widget _buildTextField({int minLines = 1, int maxLines = 1, String? hint}) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding:
            EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.blue.shade100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.blue.shade200),
        ),
      ),
    );
  }
}
