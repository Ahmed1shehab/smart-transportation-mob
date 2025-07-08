import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/on_generate_route.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Addresses',
          style: AppTextStyles.heading.copyWith(
            color: Colors.black,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add new address
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, OnGenerateRoute.locationMapScreen);
              },
              child: Row(
                children: [
                  Icon(Icons.add, color: Color(0xFF5FA8D3)),
                  SizedBox(width: 4.w),
                  Text(
                    'Add new address',
                    style: AppTextStyles.heading.copyWith(
                      color: Color(0XFF1B4865),
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Address Cards
            Expanded(
              child: ListView(
                children: [
                  addressCard(
                    context: context,
                    icon: Icons.home_outlined,
                    name: 'Maryam',
                    address: 'Mansoura , Gehan Street\nApartment number 5',
                    phone: '+201028476529',
                    showSetAsDefault: false,
                  ),
                  SizedBox(height: 12.h),
                  addressCard(
                    context: context,

                    icon: Icons.location_on_outlined,
                    name: 'Maryam',
                    address: 'Mansoura , Gehan Street\nApartment number 5',
                    phone: '+201028476529',
                    showSetAsDefault: true,
                  ),
                  SizedBox(height: 12.h),
                  addressCard(
                    context: context,

                    icon: Icons.location_on_outlined,
                    name: 'Maryam',
                    address: 'Mansoura , Gehan Street\nApartment number 5',
                    phone: '+201028476529',
                    showSetAsDefault: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addressCard({
    required BuildContext context,
    required IconData icon,
    required String name,
    required String address,
    required String phone,
    required bool showSetAsDefault,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFF5FA8D3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 21.sp, color: Color(0XFF1B4865)),
                SizedBox(width: 6.w),
                Text(
                  name,
                  style: AppTextStyles.heading.copyWith(fontSize: 16.sp),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(address, style: TextStyle(fontSize: 13.sp)),
            SizedBox(height: 4.h),
            Text('Phone number: $phone', style: TextStyle(fontSize: 13.sp)),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, OnGenerateRoute.editAddress);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE3F2FD),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: () => showDeleteAddressDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE3F2FD),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                if (showSetAsDefault) ...[
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5FA8D3),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Set as default',
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showDeleteAddressDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button top right
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Title
              Text(
                'Delete address?',
                style: AppTextStyles.heading.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
              const SizedBox(height: 12),

              // Subtitle
              Text(
                'Are you sure you want to delete address?',
                style: AppTextStyles.heading.copyWith(
                  color: Color(0XFF1B4865).withOpacity(.6),
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Add your delete logic here
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5FA8D3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Delete',
                        style: AppTextStyles.heading.copyWith(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF5FA8D3)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.heading.copyWith(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
