import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/core/helper/on_generate_route.dart';

class SearchWithQR extends StatelessWidget {
  const SearchWithQR({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0XFF5FA8D3)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45.h, // أو أي ارتفاع يناسب التصميم
                    alignment: Alignment.center, // مهم جداً
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for Service Provider',
                        hintStyle: TextStyle(
                          color: Color(0XFF5FA8D3),
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                Icon(Icons.search, color: Color(0XFF5FA8D3)),
              ],
            ),
          ),
        ),

        SizedBox(width: 12.w),

        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, OnGenerateRoute.qrScannerScreen);
          },
          child: Image.asset(AssetsManager.qrcode, height: 30.h, width: 30.w),
        ),
      ],
    );
  }
}
