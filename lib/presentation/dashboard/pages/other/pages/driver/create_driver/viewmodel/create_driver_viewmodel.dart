import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:smart_transportation/app/app_prefs.dart';
import 'package:smart_transportation/domain/usecase/create_driver_usecase.dart';
import 'package:smart_transportation/presentation/base/baseviewmodel.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';

class CreateDiverViewModel extends BaseViewModel
    implements CreateDiverViewModelInputs, CreateDiverViewModelOutputs {
  // Stream controllers
  final BehaviorSubject<File?> _imageController =
      BehaviorSubject<File?>.seeded(null);
  final BehaviorSubject<String?> _firstNameController =
      BehaviorSubject<String?>.seeded(null);
  final BehaviorSubject<String?> _lastNameController =
      BehaviorSubject<String?>.seeded(null);
  final BehaviorSubject<String?> _emailController =
      BehaviorSubject<String?>.seeded(null);
  final BehaviorSubject<String?> _phoneNumberController =
      BehaviorSubject<String?>.seeded(null);
  final BehaviorSubject<String?> _passwordController =
      BehaviorSubject<String?>.seeded(null);
  final BehaviorSubject<String?> _organizationIdController =
      BehaviorSubject<String?>.seeded(null);
  final BehaviorSubject<String?> _licenseInfoController =
      BehaviorSubject<String?>.seeded(null);
  final BehaviorSubject<DateTime?> _licenseDateController =
      BehaviorSubject<DateTime?>.seeded(null);
  final BehaviorSubject<bool> _isDriverRegisteredSuccessfullyController =
      BehaviorSubject<bool>();
final AppPreferences _appPreferences;

  final CreateDriverUsecase _createDriverUsecase;

  CreateDiverViewModel(this._createDriverUsecase, this._appPreferences);

  // -- Inputs --
  @override
  void setImage(File image) {
    _imageController.add(image);
    _validateAllInputs();
  }

  @override
  void setFirstName(String firstName) {
    _firstNameController.add(firstName);
    _validateAllInputs();
  }

  @override
  void setLastName(String lastName) {
    _lastNameController.add(lastName);
    _validateAllInputs();
  }

  @override
  void setEmail(String email) {
    _emailController.add(email);
    _validateAllInputs();
  }

  @override
  void setPhoneNumber(String phoneNumber) {
    _phoneNumberController.add(phoneNumber);
    _validateAllInputs();
  }

  @override
  void setPassword(String password) {
    _passwordController.add(password);
    _validateAllInputs();
  }

  @override
  void setOrganizationId(String organizationId) {
    _organizationIdController.add(organizationId);
    _validateAllInputs();
  }

  @override
  void setLicenseInfo(String licenseInfo) {
    _licenseInfoController.add(licenseInfo);
    _validateAllInputs();
  }

  @override
  void setLicenseDate(DateTime licenseDate) {
    _licenseDateController.add(licenseDate);
    _validateAllInputs();
  }

  @override
  void setProfilePicture(File? image) {
    if (image != null) {
      _imageController.add(image);
    }
    _validateAllInputs();
  }

  @override
  Future<void> register() async {
    if (!(await _areAllInputsValid().first)) {
      inputState.add(ErrorState(StateRendererType.popUpErrorState,
          "Please fill all required fields correctly"));
      return;
    }

    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    final result = await _createDriverUsecase.execute(CreateDriverInput(
      licenseInfo: _licenseInfoController.value!,
      licenseDate: _licenseDateController.value!,
      imageFile: _imageController.value!,
      firstName: _firstNameController.value!,
      lastName: _lastNameController.value!,
      email: _emailController.value!,
      phoneNumber: _phoneNumberController.value!,
      password: _passwordController.value!,
      organizationId: _organizationIdController.value!,
    ));

    result.fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popUpErrorState, failure.message));
      _isDriverRegisteredSuccessfullyController.add(false);
    }, (driver) {
      inputState.add(SuccessState("Driver registered successfully!"));
      _isDriverRegisteredSuccessfullyController.add(true);
    });
  }
Future<String?> getActiveOwnerId() async {
  return _appPreferences.getActiveOwner();
}
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _imageController.close();
    _firstNameController.close();
    _lastNameController.close();
    _emailController.close();
    _phoneNumberController.close();
    _passwordController.close();
    _organizationIdController.close();
    _licenseInfoController.close();
    _licenseDateController.close();
    _isDriverRegisteredSuccessfullyController.close();
    super.dispose();
  }

  // -- Outputs --
  @override
  Stream<File?> get outputImage => _imageController.stream;

  @override
  Stream<String?> get outputFirstName => _firstNameController.stream;

  @override
  Stream<String?> get outputLastName => _lastNameController.stream;

  @override
  Stream<String?> get outputEmail => _emailController.stream;

  @override
  Stream<String?> get outputPhoneNumber => _phoneNumberController.stream;

  @override
  Stream<String?> get outputPassword => _passwordController.stream;

  @override
  Stream<String?> get outputOrganizationId => _organizationIdController.stream;

  @override
  Stream<String?> get outputLicenseInfo => _licenseInfoController.stream;

  @override
  Stream<DateTime?> get outputLicenseDate => _licenseDateController.stream;


  @override
  Stream<bool> get outputIsDriverRegisteredSuccessfully =>
      _isDriverRegisteredSuccessfullyController.stream;

  // Validation Streams
  @override
  Stream<String?> get outputImageError => _imageController.stream
      .map((image) => image != null ? null : "Image is required");

  @override
  Stream<String?> get outputFirstNameError => _firstNameController.stream
      .map((name) => _isNameValid(name) ? null : "First name is required");

  @override
  Stream<String?> get outputLastNameError => _lastNameController.stream
      .map((name) => _isNameValid(name) ? null : "Last name is required");

  @override
  Stream<String?> get outputEmailError => _emailController.stream
      .map((email) => _isEmailValid(email) ? null : "Invalid email format");

  @override
  Stream<String?> get outputPhoneNumberError =>
      _phoneNumberController.stream.map((phone) =>
          _isPhoneNumberValid(phone) ? null : "Invalid phone number");

  @override
  Stream<String?> get outputPasswordError =>
      _passwordController.stream.map((pass) => _isPasswordValid(pass)
          ? null
          : "Password must be at least 6 characters");

  @override
  Stream<String?> get outputOrganizationIdError =>
      _organizationIdController.stream.map((id) =>
          id?.isNotEmpty ?? false ? null : "Organization ID is required");

  @override
  Stream<String?> get outputLicenseInfoError =>
      _licenseInfoController.stream.map((info) =>
          info?.isNotEmpty ?? false ? null : "License info is required");

  @override
  Stream<String?> get outputLicenseDateError => _licenseDateController.stream
      .map((date) => _isLicenseDateValid(date) ? null : "Invalid license date");

  @override
  Stream<bool> get outputAreAllInputsValid => _areAllInputsValid();

  // -- Private Methods --
  Stream<bool> _areAllInputsValid() => Rx.combineLatest9(
      outputImage.map((image) => image != null),
      outputFirstName.map(_isNameValid),
      outputLastName.map(_isNameValid),
      outputEmail.map(_isEmailValid),
      outputPhoneNumber.map(_isPhoneNumberValid),
      outputPassword.map(_isPasswordValid),
      outputOrganizationId.map((id) => id?.isNotEmpty ?? false),
      outputLicenseInfo.map((info) => info?.isNotEmpty ?? false),
      outputLicenseDate.map(_isLicenseDateValid),
      (a, b, c, d, e, f, g, h, i) =>
          a && b && c && d && e && f && g && h && i).distinct();

  bool _isNameValid(String? name) => name?.isNotEmpty ?? false;

  bool _isEmailValid(String? email) =>
      email != null &&
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);


  bool _isPhoneNumberValid(String? phoneNumber) =>
      phoneNumber != null && phoneNumber.length >= 8;

  bool _isPasswordValid(String? password) =>
      password != null && password.length >= 6;

  bool _isLicenseDateValid(DateTime? date) =>
      date != null && !date.isAfter(DateTime.now());

  void _validateAllInputs() {
    // Validation happens reactively through the outputAreAllInputsValid stream
  }
}

abstract class CreateDiverViewModelInputs {
  void setImage(File image);
  void setFirstName(String firstName);
  void setLastName(String lastName);
  void setEmail(String email);
  void setPhoneNumber(String phoneNumber);
  void setPassword(String password);
  void setOrganizationId(String organizationId);
  void setLicenseInfo(String licenseInfo);
  void setLicenseDate(DateTime licenseDate);
  void setProfilePicture(File? image);
  Future<void> register();
  void start();
  void dispose();
}

abstract class CreateDiverViewModelOutputs {
  // Data streams
  Stream<File?> get outputImage;
  Stream<String?> get outputFirstName;
  Stream<String?> get outputLastName;
  Stream<String?> get outputEmail;
  Stream<String?> get outputPhoneNumber;
  Stream<String?> get outputPassword;
  Stream<String?> get outputOrganizationId;
  Stream<String?> get outputLicenseInfo;
  Stream<DateTime?> get outputLicenseDate;

  // Validation error streams
  Stream<String?> get outputImageError;
  Stream<String?> get outputFirstNameError;
  Stream<String?> get outputLastNameError;
  Stream<String?> get outputEmailError;
  Stream<String?> get outputPhoneNumberError;
  Stream<String?> get outputPasswordError;
  Stream<String?> get outputOrganizationIdError;
  Stream<String?> get outputLicenseInfoError;
  Stream<String?> get outputLicenseDateError;

  // Status streams
  Stream<bool> get outputAreAllInputsValid;
  Stream<bool> get outputIsDriverRegisteredSuccessfully;
}
