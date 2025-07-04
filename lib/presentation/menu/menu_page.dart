import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/font_manager.dart';
import '../account_info/account_info.dart';
import '../account_info/account_info_viewmodel.dart';
import '../reports/reports.dart';
import '../reports/reports_viewmodel.dart';
import '../resources/route_manager.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            'menu'.tr(),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeightManager.semiBold,
              fontSize: 22.0,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20.0),

            /// Profile Picture between lines
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(child: Divider(color: ColorManager.primary, thickness: 1.0)),
                  const SizedBox(width: 10.0),
                  FutureBuilder<String?>(
                    future: _loadProfileImagePath(),
                    builder: (context, snapshot) {
                      final imagePath = snapshot.data;
                      return Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: imagePath != null
                              ? DecorationImage(
                            image: FileImage(File(imagePath)),
                            fit: BoxFit.cover,
                          )
                              : const DecorationImage(
                            image: AssetImage('assets/images/supervisor/Reem.png'),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: ColorManager.primary, width: 2.0),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(child: Divider(color: ColorManager.primary, thickness: 1.0)),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Layla",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.primary,
              ),
            ),
            const SizedBox(height: 34.0),

            /// Menu List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  items(
                    icon: Icons.person_outline,
                    title: 'account_info'.tr(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => AccountInfoViewModel(),
                            child: const AccountInfo(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  items(
                    icon: Icons.insert_drive_file_outlined,
                    title: 'reports'.tr(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => ReportsViewModel(),
                            child: const ReportsPage(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20.0),
                  items(
                    icon: Icons.language_outlined,
                    title: 'language'.tr(),
                    onTap: () => LanguageDialog(context),
                  ),
                  const SizedBox(height: 20.0),
                  items(
                    icon: Icons.info_outline,
                    title: 'about_us'.tr(),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            /// Logout
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: TextButton(
                  onPressed: () => LogoutDialog(context),
                  child: Text(
                    'logout'.tr(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget items({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: ColorManager.black),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeightManager.semiBold,
              color: ColorManager.black,
            ),
          ),
          onTap: onTap,
        ),
        Divider(height: 1, color: ColorManager.black.withOpacity(0.1)),
      ],
    );
  }

  void LogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          content: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'logout_confirmation'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.secondary,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text('cancel'.tr()),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove('token');
                        Navigator.of(dialogContext).pop();
                        Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
                      },
                      child: Text(
                        'logout'.tr(),
                        style: const TextStyle(color: Colors.red),
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
  Future<String?> _loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profileImagePath');
  }

  void LanguageDialog(BuildContext context) {
    String selected = context.locale.languageCode;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            final isArabic = context.locale.languageCode == 'ar';

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              content: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            'language'.tr(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RadioListTile<String>(
                          title: Text('english'.tr()),
                          value: 'en',
                          groupValue: selected,
                          onChanged: (val) => setState(() => selected = val!),
                        ),
                        RadioListTile<String>(
                          title: Text('arabic'.tr()),
                          value: 'ar',
                          groupValue: selected,
                          onChanged: (val) => setState(() => selected = val!),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              context.setLocale(Locale(selected));
                              Navigator.pop(context);
                            },
                            child: Text(
                              'save'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 0,
                    right: isArabic ? null : 0,
                    left: isArabic ? 0 : null,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}
