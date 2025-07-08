import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';

class AddressGuardianForm extends StatelessWidget {
  final String city;
  final String area;
  final String streetNumber;
  final TextEditingController apartmentController;
  final TextEditingController guardianNameController;
  final TextEditingController guardianPhoneController;
  final VoidCallback? onSave;

  const AddressGuardianForm({
    super.key,
    required this.city,
    required this.area,
    required this.streetNumber,
    required this.apartmentController,
    required this.guardianNameController,
    required this.guardianPhoneController,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Details Title
            Text(
              'Address details:',
              style: AppTextStyles.heading.copyWith(fontSize: 20.sp),
            ),
            SizedBox(height: 12.h),

            // City
            _LabelField(label: "City:"),
            _DisabledTextField(initialText: city),

            SizedBox(height: 12.h),

            // Area
            _LabelField(label: "Area:"),
            _DisabledTextField(initialText: area),

            SizedBox(height: 12.h),

            // Street & Apartment
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LabelField(label: "Street Number:"),
                      _DisabledTextField(initialText: streetNumber),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LabelField(label: "Apartment:"),
                      _EnabledTextField(controller: apartmentController),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Guardian Details Title
            Text(
              'Guardian details:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: const Color(0xFF5FA8D3),
              ),
            ),
            SizedBox(height: 12.h),

            // Guardian Name
            _LabelField(label: "Guardian’s Name:"),
            _EnabledTextField(controller: guardianNameController),

            SizedBox(height: 12.h),

            // Guardian Phone
            _LabelField(label: "Guardian’s Phone Number:"),
            _EnabledTextField(controller: guardianPhoneController),

            SizedBox(height: 32.h),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD2EBFD),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabelField extends StatelessWidget {
  final String label;
  const _LabelField({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: AppTextStyles.semiBold.copyWith(fontSize: 14.sp));
  }
}

class _DisabledTextField extends StatelessWidget {
  final String initialText;
  const _DisabledTextField({required this.initialText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      controller: TextEditingController(text: initialText),
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      ),
    );
  }
}

class _EnabledTextField extends StatelessWidget {
  final TextEditingController controller;
  const _EnabledTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF5FA8D3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFF5FA8D3), width: 2),
        ),
      ),
    );
  }
}
