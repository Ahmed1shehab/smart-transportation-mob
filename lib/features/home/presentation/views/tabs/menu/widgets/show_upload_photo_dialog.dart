import 'package:flutter/material.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/colors_manager.dart';

void showUploadPhotoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- Title + Close Button ---
              Row(
                children: [
                  const Spacer(),
                  const Text(
                    "Upload photo",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF4EB6C1),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 18,  color: ColorsManager.primary),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --- Select Photo Box ---
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF4EB6C1), width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:   [
                 Image.asset(AssetsManager.imagesbank),
                    SizedBox(height: 8),
                    Text(
                      "Select Photo",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0XFF1B4865),
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // --- OR + Camera Button ---
              const Text(
                "or",
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),

              const SizedBox(height: 8),

              OutlinedButton(
                onPressed: () {
                  // TODO: فتح الكاميرا
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.transparent),
                  backgroundColor: const Color(0XFF61B6CB).withOpacity(.22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                child: const Text(
                  "Open Camera & Take Photo",
                  style: TextStyle(
                    color: Color(0XFF1B4865),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
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
      );
    },
  );
}
