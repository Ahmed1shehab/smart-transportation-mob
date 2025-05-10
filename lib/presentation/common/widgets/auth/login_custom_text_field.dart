import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';

Widget loginBuildTextField({
  required TextEditingController controller,
  required String labelText,
  required String hintText,
  required Stream<bool> validationStream,
  required TextInputType keyboardType,
  bool obscureText = false,
}) {
  bool isHidden = obscureText;
  return StatefulBuilder(
    builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.black, // Using ColorManager
              ),
            ),
            const SizedBox(height: AppSize.s8), // Using AppSize
            StreamBuilder<bool>(
              stream: validationStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  obscureText: isHidden,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorManager.primary, // Using ColorManager
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    errorText:
                    (snapshot.data ?? true) ? null : "Invalid $labelText",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorManager.primary, width: AppSize.s2), // Using ColorManager and AppSize
                      borderRadius: BorderRadius.circular(AppSize.s8), // Using AppSize
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorManager.primary, width: AppSize.s1_5), // Using ColorManager and AppSize
                      borderRadius: BorderRadius.circular(AppSize.s8), // Using AppSize
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorManager.red, width: AppSize.s1_5), // Using ColorManager and AppSize
                      borderRadius: BorderRadius.circular(AppSize.s8), // Using AppSize
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorManager.red, width: AppSize.s2), // Using ColorManager and AppSize
                      borderRadius: BorderRadius.circular(AppSize.s8), // Using AppSize
                    ),
                    suffixIcon: obscureText
                        ? IconButton(
                      icon: Icon(
                        isHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: ColorManager.grey, // Using ColorManager
                      ),
                      onPressed: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                    )
                        : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Invalid $labelText";
                    }
                    return null;
                  },
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
