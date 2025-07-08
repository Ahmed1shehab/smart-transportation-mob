import 'package:flutter/material.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/show_confirm_phone_dialog.dart';

void showEditPhoneDialog(BuildContext context) {
  final phoneController = TextEditingController();
  bool isError = false;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          child: SizedBox(
                width: 360,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Title Row ---
                  
                   
                  Row(
                    children: [
                      const Spacer(),
                      const Text(
                        "Edit your Phone number",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF4EB6C1),
                          fontFamily: "Montserrat",
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, size: 18, color: ColorsManager.primary),
                      ),
                    ],
                  ),
            
                  const SizedBox(height: 20),
             Text(
                        "Your Phone Number:",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0XFF1B4865),
                          fontFamily: "Montserrat",
                        ),
                      ),
                  const SizedBox(height: 5),
                  
                  // --- Phone TextField ---
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: isError ? Colors.red : Color(0xFF4EB6C1)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: isError ? Colors.red : Color(0xFF4EB6C1), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
            
               const SizedBox(height: 20),
Text(
  "Please enter a valid phone number",
  style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10,
    color: isError ? Colors.red : Color(0XFF1B4865),
    fontFamily: "Montserrat",
  ),
),
const SizedBox(height: 5),
Text(
  "Confirmation will be sent to your phone number",
  style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10,
    color: isError ? Color(0XFF1B4865) : Color(0XFF1B4865),
    fontFamily: "Montserrat",
  ),
),

                  const SizedBox(height:16),
                  // --- Next Button ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final phone = phoneController.text;
                        if (phone.length < 8) {
                          setState(() => isError = true);
                        } else {
                          Navigator.pop(context);
                          showConfirmPhoneDialog(context, phone);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:   Color(0XFF61B6CB),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Next",
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
          ),
        );
      });
    },
  );
}
