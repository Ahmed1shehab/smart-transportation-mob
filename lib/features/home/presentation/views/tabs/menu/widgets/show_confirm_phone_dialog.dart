import 'package:flutter/material.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void showConfirmPhoneDialog(BuildContext context, String phone) {
  String code = "";
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                       const Spacer(),
                     GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, size: 18,  color: ColorsManager.primary),
                      ),
                   ],
                 ),
              // --- Title ---
         
              const Text(
                "Confirm your Phone Number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF4EB6C1),
                  fontFamily: "Montserrat",
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Enter the code we sent to\nthe number ending with ${phone.substring(phone.length - 4)}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontFamily: "Montserrat",fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 20),

              // --- Pin Code Input ---
              PinCodeTextField(
                appContext: context,
                length: 4,
                onChanged: (val) => code = val,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeColor: Color(0xFF4EB6C1),
                  selectedColor: Color(0xFF4EB6C1),
                  inactiveColor: Colors.grey.shade300,
                ),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  // TODO: resend code logic
                },
                child: const Text(
                  "Resend Code",
                  style: TextStyle(
                    color: Colors.black87,
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Verify Button ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (code.length == 4) {
                      Navigator.pop(context);
                      // ✅ تم التحقق من الكود
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:   ColorsManager.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Montserrat",
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
