import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/address_guardian_form.dart';
import 'package:member/features/location_picker/presentation/views/location_picker.dart';

class EditAddress extends StatelessWidget {
  const EditAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
           backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Edit address',
          style: AppTextStyles.heading.copyWith(color: Colors.black,fontSize: 20.sp)
        ),
 
      ),
      body: SingleChildScrollView(
        child: Column(children: [
         
                  Padding(
                    padding: const EdgeInsets.only(top:  33.0,left: 33, right: 33),
                    child:  Stack(children: [
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
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const LocationPickerScreen()),
                                  );
                                },
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),




                            Center(
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
                                  ],
                                ),
                              ),
                            ),
                    ],)
                  ),
        
                    SizedBox(height: 24.h),
                    AddressGuardianForm(
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
        
        
        ],),
      ),
    );
  }
}