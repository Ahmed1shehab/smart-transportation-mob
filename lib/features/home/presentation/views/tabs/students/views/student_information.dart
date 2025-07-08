import 'package:flutter/material.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/core/helper/on_generate_route.dart';

class StudentInformationPage extends StatelessWidget {
  const StudentInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student’s information",

          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // الخلفية المائلة
                Transform.rotate(
                  angle: -0.07,
                  child: Container(
                    height: 630,
                    width: 320,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCAE9FE),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),

                // النموذج الأساسي
                Container(
                  width: 320,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            "Omar",
                            style: AppTextStyles.heading.copyWith(
                              color: Color(0XFF1B4865),
                              fontSize: 20,
                            ),
                          ),
                          Positioned(
                            right: 10,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  OnGenerateRoute.uploadPhotosPage,
                                );
                              },
                              child: Image.asset(AssetsManager.photo),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // الاسم
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Name:",
                          style: AppTextStyles.heading.copyWith(
                            color: Color(0XFF000000),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        initialValue: "Omar",
                        decoration: _inputDecoration(),
                      ),
                      const SizedBox(height: 12),

                      // المزود
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Service Provider:",
                          style: AppTextStyles.heading.copyWith(
                            color: Color(0XFF000000),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Material(
                        type: MaterialType.transparency,
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          items:
                              ["Provider A", "Provider B"]
                                  .map(
                                    (provider) => DropdownMenuItem(
                                      value: provider,
                                      child: Text(provider),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {},
                          decoration: _inputDecoration(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // العنوان الافتراضي
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Default Address:",
                          style: AppTextStyles.heading.copyWith(
                            color: Color(0XFF000000),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        value: "Mansoura , Gehan Street",
                        items:
                            [
                                  "Mansoura , Gehan Street",
                                  "Address 2",
                                  "Address 3",
                                ]
                                .map(
                                  (address) => DropdownMenuItem(
                                    value: address,
                                    child: Text(address),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {},
                        decoration: _inputDecoration(),
                      ),
                      const SizedBox(height: 12),

                      // ملاحظات عن الإعاقة
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "If the student has disability , please provide us with further details:",

                          style: AppTextStyles.heading.copyWith(
                            color: Color(0XFF000000),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        maxLines: 4,
                        decoration: _inputDecoration(hint: "Optional"),
                      ),
                      const SizedBox(height: 20),

                      // زر Save
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B4865),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Save",
                            style: AppTextStyles.heading.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // زر Shared Access
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              OnGenerateRoute.sharedAccessPage,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.primary,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Shared Access",
                            style: AppTextStyles.heading.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black26),
      ),
    );
  }
}
