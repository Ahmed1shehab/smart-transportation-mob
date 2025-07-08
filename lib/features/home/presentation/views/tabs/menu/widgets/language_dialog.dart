import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/colors_manager.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  String _selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Icon
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  size: 20.sp,
                  color: ColorsManager.primary,
                ),
              ),
            ),
            SizedBox(height: 8.h),

            // Title
            Text(
              "Language",
              style: AppTextStyles.heading.copyWith(
                fontSize: 16.sp,
                color: Color(0XFF1B4865),
              ),
            ),
            SizedBox(height: 16.h),

            // Radio buttons
            RadioListTile<String>(
              title: Text(
                "English",
                style: AppTextStyles.body.copyWith(
                  fontSize: 16.sp,
                  color: Color(0XFF000000),
                ),
              ),
              value: "English",
              groupValue: _selectedLanguage,
              activeColor: ColorsManager.primary,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
              },
              contentPadding: EdgeInsets.zero,
            ),
            RadioListTile<String>(
              title: Text(
                "Arabic",
                style: AppTextStyles.body.copyWith(
                  fontSize: 16.sp,
                  color: Color(0XFF000000),
                ),
              ),
              value: "Arabic",
              groupValue: _selectedLanguage,
              activeColor: ColorsManager.primary,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
              },
              contentPadding: EdgeInsets.zero,
            ),
            SizedBox(height: 20.h),

            // Save Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primary.withOpacity(0.85),
                minimumSize: Size(double.infinity, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
