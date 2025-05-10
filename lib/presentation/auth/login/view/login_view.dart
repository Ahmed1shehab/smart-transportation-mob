import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:smart_transportation/app/app_prefs.dart';
import 'package:smart_transportation/app/di.dart';
import 'package:smart_transportation/presentation/auth/login/viewmodel/login_viewmodel.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';
import 'package:smart_transportation/presentation/common/widgets/auth/login_custom_text_field.dart';
import 'package:smart_transportation/presentation/common/widgets/background_image.dart';
import 'package:smart_transportation/presentation/resources/asset_manager.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart';
import 'package:smart_transportation/presentation/resources/font_manager.dart';
import 'package:smart_transportation/presentation/resources/route_manager.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _userIdentifierController =
      TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  void _bind() {
    _viewModel.start();
    _userIdentifierController.addListener(
        () => _viewModel.setIdentifier(_userIdentifierController.text));
    _userPasswordController.addListener(
        () => _viewModel.setPassword(_userPasswordController.text));

    _viewModel.accountTypeStream.listen((accountType) {
      if (!mounted) return;

      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setUserLoggedIn();

        if (accountType == 'none') {
          Navigator.pushReplacementNamed(context, Routes.accountType);
        } else if (accountType == 'organizer') {
          Navigator.pushReplacementNamed(context, Routes.dashboard);
        } else if (accountType == 'member') {
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        } else {
          //todo remove this shit
          if (kDebugMode) {
            print("enta meen ya sa7by");
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _userIdentifierController.dispose();
    _userPasswordController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Column(
      children: [
        const BackgroundImage(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: AppPadding.p8),
                  Text(
                    AppStrings.welcomeBack,
                    style: TextStyle(
                        fontSize: FontSize.s24,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.primary2),
                  ),
                  Text(
                    AppStrings.loginToAccount,
                    style: TextStyle(
                        fontSize: FontSize.s20,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.black),
                  ),
                  const SizedBox(height: AppPadding.p28),
                  loginBuildTextField(
                    controller: _userIdentifierController,
                    labelText: AppStrings.emailOrPhone,
                    hintText: AppStrings.emailOrPhone,
                    validationStream: _viewModel.outIsIdentifierValid,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: AppPadding.p28),
                  loginBuildTextField(
                    controller: _userPasswordController,
                    labelText: AppStrings.password,
                    hintText: AppStrings.password,
                    validationStream: _viewModel.outIsPasswordValid,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: AppPadding.p4),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          AppStrings.forgetPassword,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppPadding.p20),
                  StreamBuilder<bool>(
                    stream: _viewModel.outAreAllInputsValid,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p28),
                        child: SizedBox(
                          width: double.infinity,
                          height: AppSize.s43,
                          child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? _viewModel.login
                                : null,
                            child: const Text(
                              AppStrings.login,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

// OR Continue With
                  const SizedBox(height: AppPadding.p20),
                  Text(
                    AppStrings.orContinueWith,
                    style: TextStyle(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.primary),
                  ),

// Social Media Icons
                  const SizedBox(height: AppPadding.p20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(ImageAssets.googleLogo),
                      _buildSocialIcon(ImageAssets.facebookLogo),
                      _buildSocialIcon(ImageAssets.appleLogo),
                      _buildSocialIcon(ImageAssets.microsoftLogo),
                    ],
                  ),

// New User? Text
                  const SizedBox(height: AppPadding.p20),
                  Text(
                    AppStrings.newUser,
                    style: TextStyle(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.primary),
                  ),
// Register Now Button
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p28),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.register);
                        },
                        child: Text(
                          AppStrings.registerNow,
                          style: TextStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.semiBold,
                            color: ColorManager.primary2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String asset) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          // Handle social login
        },
        child: Image.asset(
          asset,
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
