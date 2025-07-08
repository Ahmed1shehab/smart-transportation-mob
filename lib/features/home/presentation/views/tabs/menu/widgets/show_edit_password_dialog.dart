import 'package:flutter/material.dart';
import 'package:member/core/helper/colors_manager.dart';

void showEditPasswordDialog(BuildContext context) {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLengthValid = false;
  bool hasNumber = false;
  bool isMatch = true;

  String strength = 'Weak';
  Color strengthColor = Colors.red;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        void validatePassword(String password) {
          setState(() {
            isLengthValid = password.length >= 8;
            hasNumber = RegExp(r'\d').hasMatch(password);
            if (password.length >= 12 && hasNumber) {
              strength = "Strong";
              strengthColor = Colors.green;
            } else if (password.length >= 8 && hasNumber) {
              strength = "Medium";
              strengthColor = Colors.orange;
            } else {
              strength = "Weak";
              strengthColor = Colors.red;
            }

            isMatch = password == confirmPasswordController.text;
          });
        }

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          child: SizedBox(
            width: 360,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // --- Header ---
                  Row(
                    children: [
                      const Spacer(),
                      const Text(
                        "Edit your Password",
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

                  // --- New Password ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "New Password:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF1B4865),
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    onChanged: validatePassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4EB6C1)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4EB6C1), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // --- Strength Feedback ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password Strength : $strength",
                          style: TextStyle(color: strengthColor, fontSize: 12),
                        ),
                        Text(
                          "At least 8 letters",
                          style: TextStyle(
                            color: isLengthValid ? Colors.green : Colors.red,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Must contain a number",
                          style: TextStyle(
                            color: hasNumber ? Colors.green : Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- Confirm Password ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm Password:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF1B4865),
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    onChanged: (val) => setState(() {
                      isMatch = val == newPasswordController.text;
                    }),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4EB6C1)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4EB6C1), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  if (!isMatch)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Passwords do not match",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // --- Save Button ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (isLengthValid && hasNumber && isMatch)
                          ? () {
                              // تنفيذ الحفظ
                              Navigator.pop(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF61B6CB),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Save",
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
