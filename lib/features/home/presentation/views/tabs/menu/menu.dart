import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/on_generate_route.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/language_dialog.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/qr_code_dialog.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // --- Top bar: Menu + Organizer ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Menu",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        AssetsManager.orginzer,
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "Organizer",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // --- Profile Picture ---
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 1,
                    color: Colors.lightBlueAccent.withOpacity(0.3),
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(AssetsManager.profile),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // --- Name + QR ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Maryam",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),
                  SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const QRCodeDialog(),
                      );
                    },

                    child: Image.asset(
                      AssetsManager.qrcode,
                      height: 30.h,
                      width: 30.w,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // --- Menu Items with images ---
              buildMenuItem(
                AssetsManager.account_information,
                "Account Information",
                () {
                  Navigator.pushNamed(context, OnGenerateRoute.accountInfoPage);
                },
              ),
              buildMenuItem(AssetsManager.addresses, "Addresses", () {
                Navigator.pushNamed(
                  context,
                  OnGenerateRoute.serviceaddressespage,
                );
              }),
              buildMenuItem(AssetsManager.report, "Reports", () {
                Navigator.pushNamed(context, OnGenerateRoute.reportsPage);
              }),
              buildMenuItem(
                AssetsManager.serivce_provider,
                "Service Provider",
                () {
                  Navigator.pushNamed(
                    context,
                    OnGenerateRoute.servicesOrganizerPage,
                  );
                },
              ),
              buildMenuItem(AssetsManager.language, "Language", () {
                showDialog(
                  context: context,
                  builder: (context) => const LanguageDialog(),
                );
              }),

              buildMenuItem(AssetsManager.about_us, "About Us",(){}),
              const Spacer(),

              // --- Log out ---
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Log out",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildMenuItem(
    String imagePath,
    String title,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Image.asset(imagePath, height: 24, width: 24),
          title: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          onTap: onTap, // استخدم هنا مباشرة
        ),
        const Divider(height: 1),
      ],
    );
  }
}
