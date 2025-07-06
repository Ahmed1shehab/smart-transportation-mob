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
import 'package:smart_transportation/presentation/utils/size.config.dart';
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
  Widget build(BuildContext context) {
    SizeConfig.init(context); // ✅ Add this line
    return Scaffold(
      body: StreamBuilder(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
            _viewModel.login();
          }) ?? _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        bool isTablet = screenWidth >= 600;
        return Column(
          children: [
            isTablet ? const SizedBox.shrink() : const BackgroundImage(),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.scaleWidth(20), // equivalent to ~5% of 375
                    vertical: SizeConfig.scaleHeight(14),
                  ),
                  child: ConstrainedBox(
                    constraints:  BoxConstraints(
                      maxWidth: SizeConfig.scaleWidth(500),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            AppStrings.welcomeBack,
                            style: TextStyle(
                              fontSize: isTablet ? 28 : 20,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.primary2,
                            ),
                          ),
                          Text(
                            AppStrings.loginToAccount,
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 16,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.black,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          loginBuildTextField(
                            controller: _userIdentifierController,
                            labelText: AppStrings.emailOrPhone,
                            hintText: AppStrings.emailOrPhone,
                            validationStream: _viewModel.outIsIdentifierValid,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          loginBuildTextField(
                            controller: _userPasswordController,
                            labelText: AppStrings.password,
                            hintText: AppStrings.password,
                            validationStream: _viewModel.outIsPasswordValid,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                // TODO: Navigate to forgot password
                              },
                              child: Text(
                                AppStrings.forgetPassword,
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          StreamBuilder<bool>(
                            stream: _viewModel.outAreAllInputsValid,
                            builder: (context, snapshot) {
                              return SizedBox(
                                width: double.infinity,
                                height: SizeConfig.scaleHeight(60),

                                child: ElevatedButton(
                                  onPressed: (snapshot.data ?? false)
                                      ? _viewModel.login
                                      : null,
                                  child: const Text(
                                    AppStrings.login,
                                    style: TextStyle(color: Colors.white,fontSize: FontSize.s14),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            AppStrings.orContinueWith,
                            style: TextStyle(
                              fontSize: isTablet ? 18 : 14,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManager.primary,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Wrap(
                            spacing: 10,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildSocialIcon(ImageAssets.googleLogo),
                              _buildSocialIcon(ImageAssets.facebookLogo),
                              _buildSocialIcon(ImageAssets.appleLogo),
                              _buildSocialIcon(ImageAssets.microsoftLogo),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            AppStrings.newUser,
                            style: TextStyle(
                              fontSize: isTablet ? 18 : 14,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManager.primary,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.register);
                              },
                              child: Text(
                                AppStrings.registerNow,
                                style: TextStyle(
                                  fontSize: isTablet ? 22 : 16,
                                  fontWeight: FontWeightManager.semiBold,
                                  color: ColorManager.primary2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
