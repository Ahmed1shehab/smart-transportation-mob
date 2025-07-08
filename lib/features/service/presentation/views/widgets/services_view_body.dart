import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/core/helper/on_generate_route.dart';
import 'package:member/features/service/presentation/views/widgets/search_with_qr.dart';

class ServicesViewBody extends StatefulWidget {
    ServicesViewBody({super.key,required this.isInSettings});
bool ? isInSettings =false;
  @override
  State<ServicesViewBody> createState() => _ServicesViewBodyState();
}

class _ServicesViewBodyState extends State<ServicesViewBody> {
  int? selectedIndex;
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> serviceProviders = [
    {
      'name': 'Delta Modern Language School',
      'organizer': 'Organizer Name',
      'email': 'email@gmail.com',
      'Details': 'Address: Mansoura, Gehan Street',
    },
    {
      'name': 'Delta Modern Language School',
      'organizer': 'Organizer Name',
      'email': 'email@gmail.com',
      'Details': 'Mansoura, Gehan Street',
    },
    {
      'name': 'Delta Modern Language School',
      'organizer': 'Organizer Name',
      'email': 'email@gmail.com',
      'Details': 'Mansoura, Gehan Street',
    },
    {
      'name': 'Delta Modern Language School',
      'organizer': 'Organizer Name',
      'email': 'email@gmail.com',
      'Details': 'Mansoura, Gehan Street',
    },
    {
      'name': 'Delta Modern Language School',
      'organizer': 'Organizer Name',
      'email': 'email@gmail.com',
      'Details': 'Mansoura, Gehan Street',
    },
    {
      'name': 'Delta Modern Language School',
      'organizer': 'Organizer Name',
      'email': 'email@gmail.com',
      'Details': 'Mansoura, Gehan Street',
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Center(
            child: Text(
              "Join a Service Provider",
              style: AppTextStyles.heading,
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Text(
              "Please join a Service Provider",
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold.copyWith(color: ColorsManager.grey),
            ),
          ),
          SizedBox(height: 24.h),
          const SearchWithQR(),
          SizedBox(height: 16.h),

          /// ✅ Stack for ListView + Scroll Indicator
          Expanded(
            child: Stack(
              children: [
                NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    setState(() {});
                    return true;
                  },
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: serviceProviders.length,
                    separatorBuilder:
                        (context, index) => SizedBox(height: 16.h),
                    itemBuilder:
                        (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: OrganizerCardDetails(
                            name: serviceProviders[index]['name']!,
                            organizer: serviceProviders[index]['organizer']!,
                            email: serviceProviders[index]['email']!,
                            address: serviceProviders[index]['Details']!,
                            isSelected: selectedIndex == index,
                          ),
                        ),
                  ),
                ),

                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final trackHeight = constraints.maxHeight;
                      final thumbHeight = _getThumbHeight(trackHeight);
                      final thumbTop = _getScrollIndicatorPosition(
                        trackHeight,
                        thumbHeight,
                      );

                      return Container(
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: thumbTop,
                              child: Container(
                                width: 10.w,
                                height: thumbHeight,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade700,
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),
          Center(
            child: GestureDetector(
              onTap:
                  selectedIndex != null
                      ? () {
                     !widget.isInSettings!  ?   Navigator.pushReplacementNamed(
                          context,
                          OnGenerateRoute.step2View,
                        ) :  Navigator.pushReplacementNamed(
                          context,
                          OnGenerateRoute.home,
                        ) ;
                      }
                      : null,
              child: Container(
                height: 42.h,
                width: 376.w,
                decoration: BoxDecoration(
                  color:
                      selectedIndex != null
                          ? const Color(0XFF509BC7)
                          : const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    "Next",
                    style: AppTextStyles.semiBold.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  double _getThumbHeight(double trackHeight) {
    if (!_scrollController.hasClients) return 40.h;

    final scrollExtent = _scrollController.position.maxScrollExtent;
    final viewHeight = _scrollController.position.viewportDimension;

    final viewFraction = viewHeight / (scrollExtent + viewHeight);
    final thumbHeight = trackHeight * viewFraction;

    return thumbHeight.clamp(40.h, trackHeight);
  }

  double _getScrollIndicatorPosition(double trackHeight, double thumbHeight) {
    if (!_scrollController.hasClients) return 0;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    final availableHeight = trackHeight - thumbHeight;
    final scrollRatio = currentScroll / maxScroll;

    return availableHeight * scrollRatio;
  }
}

class OrganizerCardDetails extends StatelessWidget {
  final String name;
  final String organizer;
  final String email;
  final String address;
  final bool isSelected;

  const OrganizerCardDetails({
    super.key,
    required this.name,
    required this.organizer,
    required this.email,
    required this.address,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.h,
      width: 378.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? ColorsManager.primary : const Color(0XFF5FA8D3),
          width: isSelected ? 3 : 1,
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AssetsManager.ellipse_icon, height: 40.h, width: 40.w),
            SizedBox(height: 4.h),
            Text(
              name,
              style: AppTextStyles.semiBold.copyWith(fontSize: 14.sp),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Text(
              "Organizer: $organizer",
              style: AppTextStyles.body.copyWith(fontSize: 12.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "E-mail:",
                          style: AppTextStyles.body.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.primary,
                          ),
                        ),
                        Text(
                          email,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Details:",
                          style: AppTextStyles.body.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.primary,
                          ),
                        ),
                        Text(
                          address,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
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
