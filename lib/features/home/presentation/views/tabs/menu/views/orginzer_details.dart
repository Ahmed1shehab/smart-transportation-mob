import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/details_tab.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/show_student_dialog.dart';

class OrginzerDetails extends StatelessWidget {
  const OrginzerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // عدد التابات
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              // --- School Logo ---
              CircleAvatar(
                radius: 45.r,
                backgroundImage: AssetImage(AssetsManager.ellipse_icon),
              ),
              SizedBox(height: 12.h),

              // --- School Name ---
              Text(
                "Delta Modern Language School",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),

              // --- Action Buttons ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ActionButton(
                    imagePath: AssetsManager.person,
                    label: "Add Student",
                    onPressed: () {},
                  ),
                  SizedBox(width: 12.w),
                  _ActionButton(
                    imagePath: AssetsManager.huge_icon,
                    label: "Call Organizer",
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // --- Tabs ---
              Container(
                margin: EdgeInsets.only(bottom: 16.h),
                child: TabBar(
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Color(0xFF98C9E2), // لون الخط الأزرق الفاتح
                      width: 5.h,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  labelColor: Color(0xFF164863), // لون النص المحدد (كحلي غامق)
                  unselectedLabelColor: Colors.grey.shade400,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp, // تكبير حجم النص
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Students",
                          style: AppTextStyles.body.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Details",
                          style: AppTextStyles.body.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // --- Tab Content ---
              Expanded(
                child: TabBarView(
                  children: [
                    // --- Students Tab ---
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      children:   [
                        GestureDetector(
                            onTap: () => showStudentDialog(context),
                          child: _StudentCard(
                            name: "Omar",
                            imagePath: AssetsManager.omar,
                          ),
                        ),
                        _StudentCard(
                          name: "Reem",
                          imagePath: AssetsManager.reem,
                        ),
                      ],
                    ),

                    // --- Details Tab ---
                    Center(
                      child:DetailsTab()
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.imagePath,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165.w,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF5FA8D3).withOpacity(.7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        ),
        icon: Image.asset(
          imagePath,
          height: 18.h,
          width: 18.w,
          fit: BoxFit.contain,
        ),
        label: Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  final String name;
  final String imagePath;

  const _StudentCard({required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 187.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E0E0),
            offset: const Offset(2, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: const Color(0xFF5FA8D3),
              height: 36.h,
              alignment: Alignment.center,
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
