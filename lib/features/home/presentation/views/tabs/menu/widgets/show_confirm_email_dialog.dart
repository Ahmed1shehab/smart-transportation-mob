import 'package:flutter/material.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
void showConfirmEmailDialog(BuildContext context, String email) {
final TextEditingController codeController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
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
                // Title Row
                Row(
                  children: [
                    const Spacer(),
                    const Text(
                      "Confirm your E-mail",
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
                      child: const Icon(Icons.close, size: 18,  color: ColorsManager.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Text(
                  "Enter the code we sent to your E-mail\n${_maskEmail(email)}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Color(0XFF1B4865),fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
PinCodeTextField(
  appContext: context,
  length: 4,
  controller: codeController,
  keyboardType: TextInputType.number,
  textStyle: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1B4865),
    fontFamily: "Montserrat",
  ),
  pinTheme: PinTheme(
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(6),
    fieldHeight: 50,
    fieldWidth: 50,
    inactiveColor: Color(0xFF4EB6C1),
    activeColor: Color(0xFF4EB6C1),
    selectedColor: Color(0xFF4EB6C1),
    inactiveFillColor: Colors.white,
    activeFillColor: Colors.white,
    selectedFillColor: Colors.white,
    borderWidth: 1.5,
  ),
  cursorColor: Color(0xFF1B4865),
  animationType: AnimationType.fade,
  enableActiveFill: true,
  onChanged: (value) {
    // handle input change
  },
),

                const SizedBox(height: 12),
                const Text(
                  "Resend Code",
                  style: TextStyle(color: Color(0xFF1B4865), fontSize: 12, decoration: TextDecoration.underline),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // verify logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF61B6CB),
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
        ),
      );
    },
  );
}

String _maskEmail(String email) {
  final parts = email.split('@');
  if (parts.length != 2) return email;
  final name = parts[0];
  final maskedName = name.length <= 1
      ? '*'
      : '${name[0]}${'*' * (name.length - 2)}${name[name.length - 1]}';
  return '${maskedName}@${parts[1]}';
}
