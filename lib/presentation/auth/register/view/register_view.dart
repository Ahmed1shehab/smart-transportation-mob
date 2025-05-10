import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_transportation/app/app_prefs.dart';
import 'package:smart_transportation/app/di.dart';
import 'package:smart_transportation/presentation/auth/register/view/email_and_number.dart';
import 'package:smart_transportation/presentation/auth/register/view/password_view.dart';
import 'package:smart_transportation/presentation/auth/register/view/register_name_view.dart';
import 'package:smart_transportation/presentation/auth/register/viewmodel/register_viewmodel.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';
import 'package:smart_transportation/presentation/resources/route_manager.dart';

import '../../../resources/constants_manager.dart';
import '../../../resources/strings_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final PageController _pageController = PageController(initialPage: 0);

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyEmailAndPhoneNumber = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  void _bind() {
    _viewModel.start();

    _firstNameController.addListener(() => _viewModel.setFirstName(_firstNameController.text));
    _lastNameController.addListener(() => _viewModel.setLastName(_lastNameController.text));
    _phoneNumberController.addListener(() => _viewModel.setPhoneNumber(_phoneNumberController.text));
    _emailController.addListener(() => _viewModel.setEmail(_emailController.text));
    _passwordController.addListener(() => _viewModel.setPassword(_passwordController.text));

    _viewModel.outputIsUserRegisteredSuccessfully.listen((isRegistered) {
      if (isRegistered && mounted) {
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pushReplacementNamed(context, Routes.login);
        });
      }
    });
  }


  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _pageController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: AppConstants.sliderAnimation),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: AppConstants.sliderAnimation),
      curve: Curves.easeInOut,
    );
  }

  void _submitRegistration() {
    if (_formKeyPassword.currentState!.validate()) {
      _viewModel.register();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final state = snapshot.data!;
            return state.getScreenWidget(context, _getContentWidget(), () {});
          } else {
            return _getContentWidget();
          }
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        RegisterNameScreen(
          viewModel: _viewModel,
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          formKey: _formKeyName,
          onNext: () {
            if (_formKeyName.currentState!.validate()) {
              _nextPage();
            }
          },
        ),
        RegisterPhoneNumberAndEmailScreen(
          viewModel: _viewModel,
          emailController: _emailController,
          phoneNumberController: _phoneNumberController,
          formKey: _formKeyEmailAndPhoneNumber,
          onPrevious: _previousPage,
          onNext: () {
            if (_formKeyEmailAndPhoneNumber.currentState!.validate()) {
              _nextPage();
            }
          },
        ),
        RegisterPasswordScreen(
          viewModel: _viewModel,
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          formKey: _formKeyPassword,
          onPrevious: _previousPage,
          onSubmit: _submitRegistration,
        ),
        const Center(child: Text(AppStrings.uploadImageScreenPlaceholder)),
        const Center(child: Text(AppStrings.finalRegistrationScreenPlaceholder)),
      ],
    );
  }
}