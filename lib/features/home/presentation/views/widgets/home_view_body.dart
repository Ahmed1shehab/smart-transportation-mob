import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/features/home/presentation/views/widgets/kids_card_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  final bool hasActiveTrip = true;  

  @override
  Widget build(BuildContext context) {
    if (!hasActiveTrip) {
 
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: RichText(
            text: TextSpan(
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: 'Hi Maryam,\n',
                  style: AppTextStyles.heading.copyWith(
                    fontSize: 16,
                    color: ColorsManager.primary,
                  ),
                ),
                const TextSpan(
                  text: 'Welcome Back!',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0XFF000000),
                  ),
                ),
              ],
            ),
          ),
        
        ),
        
        body: const Padding(
          
          padding: EdgeInsets.symmetric(horizontal: 16.0),

          child: KidsCardListView(isCollapsed: false), 
        ),
      );
    }

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(30.0444, 31.2357),  
            zoom: 13.5,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.memberapp',
            ),
          
          ],
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300.h,  
            padding: const EdgeInsets.symmetric(horizontal: 16),

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.transparent],
              ),
            ),
            child: KidsCardListView(isCollapsed: true),  
          ),
        ),
      ],
    );
  }
}
