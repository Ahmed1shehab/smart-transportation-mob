import 'package:flutter/material.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/show_confirm_email_dialog.dart';

void showEditEmailDialog(BuildContext context) {
  final emailController = TextEditingController();
  final confirmEmailController = TextEditingController();
  bool isError = false;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
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
                    // Title + Close
                    Row(
                      children: [
                        const Spacer(),
                        const Text(
                          "Edit your E-mail",
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

                    const Text(
                      "New E-mail:",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0XFF1B4865)),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                    if (isError)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "Please enter a valid E-mail address",
                          style: TextStyle(color: Colors.red, fontSize: 11),
                        ),
                      ),
                    const SizedBox(height: 12),

                    const Text(
                      "Confirm E-mail:",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0XFF1B4865)),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: confirmEmailController,
                      keyboardType: TextInputType.emailAddress,
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
                    const SizedBox(height: 8),
                    const Text(
                      "Confirmation will be sent to your E-mail",
                      style: TextStyle(fontSize: 10, color: Color(0XFF1B4865)),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final email = emailController.text.trim();
                          final confirmEmail = confirmEmailController.text.trim();
                          final isValid = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(email);

                          if (!isValid || email != confirmEmail) {
                            setState(() => isError = true);
                          } else {
                            Navigator.pop(context);
                            showConfirmEmailDialog(context, email);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF61B6CB),
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
        },
      );
    },
  );
}
