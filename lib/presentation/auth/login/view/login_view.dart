import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import '../../../common/state_renderer/state_rendered_impl.dart';
import '../../../../app/di.dart';
import '../../../resources/asset_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/route_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();

  final TextEditingController _userIdentifierController =
  TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _organizationIdController = TextEditingController();
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

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn && mounted) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void dispose() {
    _userIdentifierController.dispose();
    _userPasswordController.dispose();
    _organizationIdController.dispose();
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
        SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(
            ImageAssets.authBG,
            fit: BoxFit.cover,
          ),
        ),
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
                        color: ColorManager.onBoardingTitle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppPadding.p28), //
                    child: Text(
                      AppStrings.loginToAccount,
                      style: TextStyle(
                        fontSize: FontSize.s20,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppPadding.p20),
                  _buildTextField(
                    controller: _userIdentifierController,
                    labelText: AppStrings.email,
                    hintText: AppStrings.email,
                    validationStream: _viewModel.outIsIdentifierValid,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: AppPadding.p20),
                  _buildTextField(
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
                  const SizedBox(height: AppPadding.p4),
                  _buildTextField(
                    controller: _organizationIdController,
                    labelText: "Organization ID",
                    hintText: "Enter your organization ID",
                    validationStream: Stream.value(true),
                    keyboardType: TextInputType.text,
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
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.semiBold,
                            color: ColorManager.onBoardingTitle,
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

  Widget _buildTextField({
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
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              StreamBuilder<bool>(
                stream: validationStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: controller,
                    keyboardType: keyboardType,
                    obscureText: isHidden,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorManager.primary,
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      errorText:
                      (snapshot.data ?? true) ? null : "Invalid $labelText",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorManager.primary, width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorManager.primary, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorManager.red, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorManager.red, width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: obscureText
                          ? IconButton(
                        icon: Icon(
                          isHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: ColorManager.grey,
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
