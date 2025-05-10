import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // Import necessary for showDialog
import 'package:rxdart/rxdart.dart'; // Import for Rx.combineLatest2
import 'package:smart_transportation/app/functions.dart';
import 'package:smart_transportation/domain/usecase/signup_usecase.dart';
import 'package:smart_transportation/presentation/base/baseviewmodel.dart';
import 'package:smart_transportation/presentation/common/freezed_data_classes.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/resources/route_manager.dart'; // Import for Routes

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController<File> _imageStreamController =
  StreamController<File>.broadcast();
  final StreamController<String> _firstNameStreamController =
  StreamController<String>.broadcast();
  final StreamController<String> _lastNameStreamController =
  StreamController<String>.broadcast();
  final StreamController<String> _emailStreamController =
  StreamController<String>.broadcast();
  final StreamController<String> _phoneNumberStreamController =
  StreamController<String>.broadcast();
  final BehaviorSubject<String> _passwordSubject =
  BehaviorSubject<String>.seeded(''); // Use BehaviorSubject to hold the latest password
  final StreamController<bool> _areAllInputsValidStreamController =
  StreamController<bool>.broadcast();
  final StreamController<bool> _isUserRegisteredSuccessfullyStreamController =
  StreamController<bool>();

  final SignupUsecase _signupUsecase;
  var registerObject = RegisterObject(File(""), "", "", "", "", "");

  RegisterViewModel(this._signupUsecase);

  // inputs
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _imageStreamController.close();
    _firstNameStreamController.close();
    _lastNameStreamController.close();
    _emailStreamController.close();
    _phoneNumberStreamController.close();
    _passwordSubject.close(); // Close the BehaviorSubject
    _areAllInputsValidStreamController.close();
    _isUserRegisteredSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  Sink<File> get inputImage => _imageStreamController.sink;

  @override
  Sink<String> get inputFirstName => _firstNameStreamController.sink;

  @override
  Sink<String> get inputLastName => _lastNameStreamController.sink;

  @override
  Sink<String> get inputEmail => _emailStreamController.sink;

  @override
  Sink<String> get inputPhoneNumber => _phoneNumberStreamController.sink;

  @override
  Sink<String> get inputPassword => _passwordSubject.sink; // Use the BehaviorSubject sink

  @override
  Sink<bool> get inputAllInputsValid => _areAllInputsValidStreamController.sink;
  @override
  @override
  Future<void> register() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
    );

    final result = await _signupUsecase.execute(SignupUsecaseInput(
      registerObject.image,
      registerObject.firstName,
      registerObject.lastName,
      registerObject.email,
      registerObject.phoneNumber,
      registerObject.password,
    ));

    result.fold((failure) {
      if (kDebugMode) {
        print("Failure: ${failure.message} (Code: ${failure.status})");
      }

      inputState.add(ErrorState(
        StateRendererType.popUpErrorState,
        failure.message,
      ));
    }, (authentication) {
      if (kDebugMode) {
        print("Success: $authentication");
      }

      // Show success popup
      inputState.add(SuccessState("Registration successful!"));

      // Emit success signal
      _isUserRegisteredSuccessfullyStreamController.add(true);
    });
  }



  @override
  void setImage(File image) {
    inputImage.add(image);
    registerObject = registerObject.copyWith(image: image);
    _validate();
  }

  @override
  void setFirstName(String firstName) {
    inputFirstName.add(firstName);
    registerObject = registerObject.copyWith(firstName: firstName);
    _validateName(); // Call _validateName when first name changes
  }

  @override
  void setLastName(String lastName) {
    inputLastName.add(lastName);
    registerObject = registerObject.copyWith(lastName: lastName);
    _validateName(); // Call _validateName when last name changes
  }

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  void setPhoneNumber(String phoneNumber) {
    inputPhoneNumber.add(phoneNumber);
    if (_isPhoneNumberValid(phoneNumber)) {
      registerObject = registerObject.copyWith(phoneNumber: phoneNumber);
    } else {
      registerObject = registerObject.copyWith(phoneNumber: "");
    }
    _validate();
  }

  @override
  void setPassword(String password) {
    _passwordSubject.add(password); // Add to the BehaviorSubject
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    _validate();
  }

  // New method to set the profile picture
  @override
  void setProfilePicture(File? image) {
    if (image != null) {
      inputImage.add(image);
      registerObject = registerObject.copyWith(image: image);
    } else {
      // Handle the case where the image is null (e.g., user cancels)
      // You might want to set a default image or handle validation accordingly
      registerObject = registerObject.copyWith(image: File("")); // Or some default
    }
    _validate();
  }

  // -- outputs

  @override
  Stream<File?> get outputIsImageValid =>
      _imageStreamController.stream.map((image) => _isImageValid(image));

  @override
  Stream<String?> get outputErrorImage => outputIsImageValid.map(
          (isImageValid) => isImageValid == null ? AppStrings.imageRequired : null);

  @override
  Stream<String?> get outputIsFirstNameValid =>
      _firstNameStreamController.stream
          .map((firstName) => _isFirstNameValid(firstName));

  @override
  Stream<String?> get outputErrorFirstName =>
      outputIsFirstNameValid.map((isFirstNameValid) =>
      isFirstNameValid == null ? AppStrings.firstNameInvalid : null);

  @override
  Stream<String?> get outputIsLastNameValid => _lastNameStreamController.stream
      .map((lastName) => _isLastNameValid(lastName));

  @override
  Stream<String?> get outputErrorLastName =>
      outputIsLastNameValid.map((isLastNameValid) =>
      isLastNameValid == null ? AppStrings.lastNameInvalid : null);

  @override
  Stream<String?> get outputIsEmailValid => _emailStreamController.stream
      .map((email) => isEmailValid(email) ? null : AppStrings.emailInvalid);

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map(
          (isEmailValid) => isEmailValid == null ? null : AppStrings.emailInvalid);

  @override
  Stream<String?> get outputIsPhoneNumberValid =>
      _phoneNumberStreamController.stream.map((phoneNumber) =>
      _isPhoneNumberValid(phoneNumber)
          ? null
          : AppStrings.phoneNumberInvalid);

  @override
  Stream<String?> get outputErrorPhoneNumber =>
      outputIsPhoneNumberValid.map((isPhoneNumberValid) =>
      isPhoneNumberValid == null ? null : AppStrings.phoneNumberInvalid);

  @override
  Stream<String?> get outputIsPasswordValid =>
      _passwordSubject.stream.map((password) => // Listen to the BehaviorSubject
      _isPasswordValid(password) ? null : AppStrings.passwordInvalid);

  @override
  Stream<String?> get outputErrorPassword =>
      outputIsPasswordValid.map((isPasswordValid) =>
      isPasswordValid == null ? null : AppStrings.passwordInvalid);

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream;

  @override
  Stream<bool> get outputIsUserRegisteredSuccessfully =>
      _isUserRegisteredSuccessfullyStreamController.stream;

  @override
  Stream<bool> get outputIsNameValid => Rx.combineLatest2<String?, String?, bool>(
    outputIsFirstNameValid,
    outputIsLastNameValid,
        (firstNameError, lastNameError) =>
    firstNameError == null && lastNameError == null,
  ).distinct();

  // -- private functions

  File? _isImageValid(File? image) {
    if (image != null && image.existsSync()) {
      return image; // Return the File object if it's valid
    }
    return null; // Return null if it's not valid
  }

  String? _isFirstNameValid(String? firstName) {
    if (firstName != null && firstName.length >= 2) {
      return null;
    }
    return AppStrings.firstNameInvalid;
  }

  String? _isLastNameValid(String? lastName) {
    if (lastName != null && lastName.length >= 2) {
      return null;
    }
    return AppStrings.lastNameInvalid;
  }

  bool _isPhoneNumberValid(String? phoneNumber) {
    return phoneNumber != null && phoneNumber.length >= 8;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _areAllInputsValid() {
    return registerObject.image.existsSync() &&
        _isFirstNameValid(registerObject.firstName) == null &&
        _isLastNameValid(registerObject.lastName) == null &&
        isEmailValid(registerObject.email) &&
        _isPhoneNumberValid(registerObject.phoneNumber) &&
        _isPasswordValid(registerObject.password);
  }

  void _validate() {
    inputAllInputsValid.add(_areAllInputsValid());
  }

  void _validateName() {
    // No need to add to inputAllInputsValid here, outputIsNameValid handles it
  }


}

abstract class RegisterViewModelInput {
  Sink<File> get inputImage;

  Sink<String> get inputFirstName;

  Sink<String> get inputLastName;

  Sink<String> get inputEmail;

  Sink<String> get inputPhoneNumber;

  Sink<String> get inputPassword;

  Sink<bool> get inputAllInputsValid;

  void setImage(File image);

  void setFirstName(String firstName);

  void setLastName(String lastName);

  void setEmail(String email);

  void setPhoneNumber(String phoneNumber);

  void setPassword(String password);

  void setProfilePicture(File? image); // Added the abstract method

  Future<void> register();
}

abstract class RegisterViewModelOutput {
  Stream<File?> get outputIsImageValid;

  Stream<String?> get outputErrorImage;

  Stream<String?> get outputIsFirstNameValid;

  Stream<String?> get outputErrorFirstName;

  Stream<String?> get outputIsLastNameValid;

  Stream<String?> get outputErrorLastName;

  Stream<String?> get outputIsEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<String?> get outputIsPhoneNumberValid;

  Stream<String?> get outputErrorPhoneNumber;

  Stream<String?> get outputIsPasswordValid; // Added output

  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputAreAllInputsValid;

  Stream<bool> get outputIsUserRegisteredSuccessfully;

  Stream<bool> get outputIsNameValid;
//Stream<FlowState> get outputState;
}
