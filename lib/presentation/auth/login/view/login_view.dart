import 'package:easy_localization/easy_localization.dart';
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
import '../../forget_pass/forget_password.dart';
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

    // TODO: Remove it !!
    _userIdentifierController.text = "ahmed@example.com";
    _userPasswordController.text = "Supervisor@123";
    _organizationIdController.text = "6802a6df5bf86eefa5f3fbaa";

    _viewModel.setIdentifier(_userIdentifierController.text);
    _viewModel.setPassword(_userPasswordController.text);
    _viewModel.setOrganizationId(_organizationIdController.text);

    _viewModel.validate();
  }


  void _bind() {
    _viewModel.start();
    _userIdentifierController.addListener(
            () => _viewModel.setIdentifier(_userIdentifierController.text));
    _userPasswordController.addListener(
            () => _viewModel.setPassword(_userPasswordController.text));
    _organizationIdController.addListener(
            () => _viewModel.setOrganizationId(_organizationIdController.text));


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
      key: ValueKey(context.locale.languageCode),
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
                    'login.welcome_back'.tr(),
                    style: TextStyle(
                      fontSize: FontSize.s24,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.onBoardingTitle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppPadding.p28),
                    child: Text(
                      'login.login_to_account'.tr(),
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
                    labelText: 'login.email'.tr(),
                    hintText: 'login.email'.tr(),
                    validationStream: _viewModel.outIsIdentifierValid,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: AppPadding.p20),
                  _buildTextField(
                    controller: _userPasswordController,
                    labelText: 'login.password'.tr(),
                    hintText: 'login.password'.tr(),
                    validationStream: _viewModel.outIsPasswordValid,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: AppPadding.p4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Forget_Password()),
                          );
                        },
                        child: Text(
                          'login.forget_password'.tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppPadding.p4),
                  _buildTextField(
                    controller: _organizationIdController,
                    labelText: 'login.organization_id'.tr(),
                    hintText: 'login.organization_hint'.tr(),
                    validationStream: Stream.value(true),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: AppPadding.p20),
                  StreamBuilder<bool>(
                    stream: _viewModel.outAreAllInputsValid,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                        child: SizedBox(
                          width: double.infinity,
                          height: AppSize.s43,
                          child: ElevatedButton(
                            onPressed: (snapshot.data ?? false) ? _viewModel.login : null,
                            child: Text(
                              'login.button'.tr(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
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
                      errorText: (snapshot.data ?? true) ? null : '${'login.invalid'.tr()} $labelText',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.primary, width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.primary, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.red, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.red, width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: obscureText
                          ? IconButton(
                        icon: Icon(
                          isHidden ? Icons.visibility_off : Icons.visibility,
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
                        return '${'login.invalid'.tr()} $labelText';
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
}
