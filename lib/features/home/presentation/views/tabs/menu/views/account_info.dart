import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/show_edit_email_dialog.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/show_edit_name_dialog.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/show_edit_password_dialog.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/show_edit_phone_dialog.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/show_upload_photo_dialog.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
            
                // --- Top bar ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, size: 20),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'Account Info',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(Icons.mic_none),
                  ],
                ),
            
                const SizedBox(height: 24),
            
                // --- Profile photo ---
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(AssetsManager.profile),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetsManager.upload,
                            height: 20.h,
                            width: 18.w,
                          ),
                          SizedBox(width: 6),
                          GestureDetector(
                            onTap: () => showUploadPhotoDialog(context),
                            child: Text(
                              "Upload new photo",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0XFF000000),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 32),
            
                // --- Name ---
                buildField(title: "Name:", value: "Maryam", context: context),
            
                const SizedBox(height: 16),
            
                // --- Phone Number ---
                buildField(
                  title: "Phone Number:",
                  value: "+20 99999999",
                  context: context,
                ),
            
                const SizedBox(height: 16),
            
                // --- Email ---
                buildField(
                  title: "E-mail:",
                  value: "aaaaa@gmail.com",
                  context: context,
                ),
            
                const SizedBox(height: 16),
            
                // --- Password ---
                buildField(
                  title: "Password:",
                  value: "********",
                  context: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField({
    required String title,
    required String value,
    required BuildContext context, // ✅ لازم يكون required
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
                fontFamily: "Montserrat",
              ),
            ),

            /// ✅ القلم قابل للضغط
            GestureDetector(
              onTap: () {
                print("Clicked pen!");
                if (title == "Name:") {
                  showEditNameDialog(context);
                } else if (title == "Phone Number:") {
                  showEditPhoneDialog(context);
                } else if (title == "E-mail:") {
                  showEditEmailDialog(context);
                } else if (title == "Password:") {
                  showEditPasswordDialog(context);
                }
                // ممكن تزود باقي الحالات لو حبيت
              },
              child: Image.asset(AssetsManager.pen, height: 30.h, width: 30.w),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  enabled: false,
                  controller: TextEditingController(text: value),
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
