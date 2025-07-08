import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/on_generate_route.dart';
import 'package:member/features/location_picker/presentation/views/location_picker.dart';

class AddressDetailsScreen extends StatelessWidget {
  const AddressDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Address Details",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
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
                  // ⬅ Back + Title
                  SizedBox(height: 24.h),

                  // 🌍 OpenStreetMap
               Stack(children: [
                      Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.blue.shade100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Stack(
                                  children: [
                            FlutterMap(
                              options: MapOptions(
                                center: LatLng(30.0444, 31.2357), // Cairo, Egypt
                                zoom: 13.0,
                                onTap: (tapPosition, latlng) {
                                  debugPrint('Selected location: $latlng');
                                },
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  subdomains: const ['a', 'b', 'c'],
                                ),
                              ],
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Container(
                                color: Colors.transparent,
                              ),
                            ),




                            Center(
                              child: GestureDetector(
                                onTap: () {
                                        Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const LocationPickerScreen()),
                                  );
                                },
                                child: Column(
                                  
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                   Image.asset(AssetsManager.set_location),
                                   SizedBox(height: 5.h,),
                                Text(
                                  "Set on map",
                                  style: AppTextStyles.body.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                                
                                
                                ],),
                              ),
                            ),
                                  ],
                                ),
                              ),
                            ),
                    ],)
,                  SizedBox(height: 24.h),

                  // Form Fields
                  _buildLabel("City:"),
                  _buildTextField(),

                  _buildLabel("Area:"),
                  _buildTextField(),

                  _buildLabel("Street Number:"),
                  _buildTextField(),

                  _buildLabel("Apartment:"),
                  _buildTextField(),

                  _buildLabel("Additional Details:"),
                  _buildTextField(minLines: 3, maxLines: 3),

                  SizedBox(height: 24.h),

                  // 🔵 Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 44.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          OnGenerateRoute.requestSent,
                        );
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 6.h),
      child: Text(text, style: AppTextStyles.semiBold),
    );
  }

  Widget _buildTextField({int minLines = 1, int maxLines = 1}) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
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
