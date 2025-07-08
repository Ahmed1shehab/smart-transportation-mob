import 'package:flutter/material.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/colors_manager.dart';

void showEditNameDialog(BuildContext context) {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Title + Close Button ---
                Row(
                  children: [
                    const Spacer(),
                      Text(
                      "Edit your Name",
                    style: AppTextStyles.heading.copyWith(fontSize: 16)
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, size: 18, color: ColorsManager.primary),
                    ),
                  ],
                ),
            
                const SizedBox(height: 20),
            
                // --- First Name ---
                  Text("First Name:", style: AppTextStyles.semiBold.copyWith(fontSize: 14)),
                const SizedBox(height: 6),
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF4EB6C1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF4EB6C1), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
            
                const SizedBox(height: 14),
            
                // --- Last Name ---
                  Text("Last Name:",  style: AppTextStyles.semiBold.copyWith(fontSize: 14)),
                const SizedBox(height: 6),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF4EB6C1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF4EB6C1), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
            
                const SizedBox(height: 20),
            
                // --- Save Button ---
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Save logic here
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:   ColorsManager.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
