import 'package:flutter/material.dart';
import 'package:smart_transportation/presentation/auth/register/viewmodel/register_viewmodel.dart';
import 'package:smart_transportation/presentation/auth/register/widgets/already_have_account_widget.dart';
import 'package:smart_transportation/presentation/common/widgets/background_image.dart';
import 'package:smart_transportation/presentation/resources/asset_manager.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart';
import 'package:smart_transportation/presentation/resources/font_manager.dart';
import 'package:smart_transportation/presentation/resources/route_manager.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/resources/values_manager.dart';

import '../../../common/widgets/auth/register_custom_text_field.dart';

class RegisterPhoneNumberAndEmailScreen extends StatefulWidget {
  final RegisterViewModel viewModel;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onPrevious; // Still keeping this for potential logic
  final VoidCallback onNext;

  const RegisterPhoneNumberAndEmailScreen({
    Key? key,
    required this.viewModel,
    required this.emailController,
    required this.phoneNumberController,
    required this.formKey,
    required this.onPrevious,
    required this.onNext,
  }) : super(key: key);

  @override
  State<RegisterPhoneNumberAndEmailScreen> createState() => _RegisterPhoneNumberAndEmailScreenState();
}

class _RegisterPhoneNumberAndEmailScreenState extends State<RegisterPhoneNumberAndEmailScreen> {
  bool _isEmailValidSnapshot = false;
  bool _isPhoneNumberValidSnapshot = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Changed Stack to Scaffold to use appBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onPrevious,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Form(
              key: widget.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.width * AppSize.s0_5),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppSize.s24, top: AppSize.s24),
                    child: Text(
                      AppStrings.step2EmailAndPassword,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppHeight.h28, vertical: AppSize.s24),
                      child: Image.asset(
                        ImageAssets.step2,
                      )),
                  buildTextField(
                    context,
                    controller: widget.emailController,
                    labelText: AppStrings.email,
                    hintText: AppStrings.emailHint,
                    validationStream: widget.viewModel.outputIsEmailValid,
                    errorStream: widget.viewModel.outputErrorEmail,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (email) {
                      widget.viewModel.outputIsEmailValid.listen((isValid) {
                        if (mounted) {
                          setState(() {
                            _isEmailValidSnapshot = isValid == null;
                          });
                        }
                      }).onError((_) {});
                    },
                  ),
                  const SizedBox(height: AppPadding.p28),
                  buildTextField(
                    context,
                    controller: widget.phoneNumberController,
                    labelText: AppStrings.phoneNumber,
                    hintText: AppStrings.phoneNumberHint,
                    validationStream: widget.viewModel.outputIsPhoneNumberValid,
                    errorStream: widget.viewModel.outputErrorPhoneNumber,
                    keyboardType: TextInputType.phone,
                    onChanged: (phoneNumber) {
                      widget.viewModel.outputIsPhoneNumberValid.listen((isValid) {
                        if (mounted) {
                          setState(() {
                            _isPhoneNumberValidSnapshot = isValid == null;
                          });
                        }
                      }).onError((_) {});
                    },
                  ),
                  const SizedBox(height: AppPadding.p40),
                  SizedBox(
                    width: double.infinity,
                    height: AppSize.s43,
                    child: ElevatedButton(
                      onPressed: _isEmailValidSnapshot && _isPhoneNumberValidSnapshot
                          ? widget.onNext
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s8),
                        ),
                      ),
                      child: const Text(
                        AppStrings.next,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppPadding.p20),
                ],
              ),
            ),
          ),
          const AlreadyHaveAccountWidget(),
        ],
      ),
    );
  }
}