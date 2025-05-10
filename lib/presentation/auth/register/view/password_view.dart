import 'package:flutter/material.dart';
import 'package:smart_transportation/presentation/auth/register/viewmodel/register_viewmodel.dart';
import 'package:smart_transportation/presentation/common/widgets/background_image.dart';
import 'package:smart_transportation/presentation/resources/asset_manager.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart';
import 'package:smart_transportation/presentation/resources/font_manager.dart';
import 'package:smart_transportation/presentation/resources/route_manager.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/resources/values_manager.dart';

import '../../../common/widgets/auth/register_custom_text_field.dart';

class RegisterPasswordScreen extends StatefulWidget {
  final RegisterViewModel viewModel;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onPrevious;
  final VoidCallback onSubmit; // Changed onNext to onSubmit

  const RegisterPasswordScreen({
    Key? key,
    required this.viewModel,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.onPrevious,
    required this.onSubmit, // Changed onNext to onSubmit
  }) : super(key: key);

  @override
  State<RegisterPasswordScreen> createState() => _RegisterPasswordScreenState();
}

class _RegisterPasswordScreenState extends State<RegisterPasswordScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String _passwordStrength = '';
  Color _passwordStrengthColor = Colors.grey;

  void _updatePasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() {
        _passwordStrength = '';
        _passwordStrengthColor = Colors.grey;
      });
      return;
    }
    if (password.length < 6) {
      setState(() {
        _passwordStrength = AppStrings.passwordWeak;
        _passwordStrengthColor = Colors.redAccent;
      });
    } else if (password.length < 10) {
      setState(() {
        _passwordStrength = AppStrings.passwordMedium;
        _passwordStrengthColor = Colors.orangeAccent;
      });
    } else {
      setState(() {
        _passwordStrength = AppStrings.passwordStrong;
        _passwordStrengthColor = Colors.greenAccent;
      });
    }
  }

  bool _isPasswordMatch() {
    return widget.passwordController.text == widget.confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onPrevious,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView( // Added SingleChildScrollView here
        child: Stack(
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
                        AppStrings.step3Password, // Updated step number
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppHeight.h28, vertical: AppSize.s24),
                        child: Image.asset(
                          ImageAssets.step3, // Assuming you have a step 3 asset
                        )),
                    Text(
                      AppStrings.password,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: AppPadding.p8),
                    buildTextField(
                      context,
                      controller: widget.passwordController,
                      labelText: AppStrings.password,
                      hintText: AppStrings.passwordHint,
                      validationStream: widget.viewModel.outputIsPasswordValid,
                      errorStream: widget.viewModel.outputErrorPassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_isPasswordVisible,
                      onChanged: _updatePasswordStrength,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: AppPadding.p8),
                    Text(
                      _passwordStrength,
                      style: TextStyle(color: _passwordStrengthColor),
                    ),
                    const SizedBox(height: AppPadding.p28),
                    buildTextField(
                      context,
                      controller: widget.confirmPasswordController,
                      labelText: AppStrings.confirmPassword,
                      hintText: AppStrings.confirmPasswordHint,
                      validationStream: null,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_isConfirmPasswordVisible,
                      customValidation: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.confirmPasswordInvalid;
                        }
                        if (!_isPasswordMatch()) {
                          return AppStrings.passwordsDoNotMatch;
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: AppPadding.p40),
                    SizedBox(
                      width: double.infinity,
                      height: AppSize.s43,
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.formKey.currentState!.validate()) {
                            widget.onSubmit(); // Calls viewModel.register()
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                          ),
                        ),
                        child: const Text(
                          AppStrings.submit,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}