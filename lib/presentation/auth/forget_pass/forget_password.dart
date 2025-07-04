import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../resources/asset_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/values_manager.dart';

class Forget_Password extends StatelessWidget {
  const Forget_Password({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        key: ValueKey(context.locale.languageCode),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SvgPicture.asset(
                    ImageAssets.authBG,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              'forget.title'.tr(),
              style: TextStyle(
                fontSize: FontSize.s24,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.onBoardingTitle,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'forget.subtitle'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.semiBold,
                color: ColorManager.black,
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'forget.email_label'.tr(),
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: ColorManager.primary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'forget.email_hint'.tr(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.primary,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.red,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorManager.red,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'forget.email_error'.tr();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSize.s20),
                        SizedBox(
                          width: double.infinity,
                          height: AppSize.s43,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // TODO: Handle send OTP
                              }
                            },
                            child: Text(
                              'forget.send_code'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.s18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
