import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/address_guardian_form.dart';

class AddressOverview extends StatelessWidget {
  const AddressOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: SingleChildScrollView(
            child: AddressGuardianForm(
  city: "Mansoura",
  area: "Gehan Street",
  streetNumber: "12",
  apartmentController: TextEditingController(text: "1"),
  guardianNameController: TextEditingController(text: "Eman"),
  guardianPhoneController: TextEditingController(text: "+20 1127364598"),
  onSave: () {
    // logic
  },
)

          ),
        ),
      ),
    );
  }
}
 