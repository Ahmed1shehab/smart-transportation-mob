import 'package:flutter/material.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart';

import '../../../resources/values_manager.dart';

Widget buildTextField(
  BuildContext context, {
  required TextEditingController controller,
  required String labelText,
  required String hintText,
  Stream<String?>? validationStream,
  Stream<String?>? errorStream,
  required TextInputType keyboardType,
  bool obscureText = false,
  Widget? suffixIcon,
  ValueChanged<String>? onChanged,
  String? Function(String?)? customValidation,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelText,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorManager.black,
            ),
      ),
      const SizedBox(height: AppSize.s8),
      StreamBuilder<String?>(
        stream: validationStream,
        builder: (context, snapshot) {
          return TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: snapshot.data,
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorManager.primary, width: AppSize.s2),
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppSize.s8)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: AppSize.s1),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorManager.red, width: AppSize.s1),
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppSize.s8)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorManager.red, width: AppSize.s2),
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppSize.s8)),
              ),
              suffixIcon: suffixIcon,
            ),
            onChanged: onChanged,
            validator: customValidation,
          );
        },
      ),
    ],
  );
}
