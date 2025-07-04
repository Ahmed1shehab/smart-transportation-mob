import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/usecase/signin_usecase.dart';
import '../../../base/baseviewmodel.dart';
import '../../../common/freezed_data_classes.dart';
import '../../../common/state_renderer/state_rendered.dart';
import '../../../common/state_renderer/state_rendered_impl.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController<String> _identifierStreamController =
  StreamController<String>.broadcast();
  final StreamController<String> _passwordStreamController =
  StreamController<String>.broadcast();
  final StreamController<String> _organizationIdStreamController =
  StreamController<String>.broadcast();
  final StreamController<bool> _areAllInputsValidStreamController =
  StreamController<bool>.broadcast();

  final StreamController<bool> isUserLoggedInSuccessfullyStreamController =
  StreamController<bool>();

  LoginObject signInObject = LoginObject(
    identifier: "",
    password: "",
    organizationId: "",
  );

  final SigninUsecase _signinUsecase;

  LoginViewModel(this._signinUsecase);

  @override
  void dispose() {
    _identifierStreamController.close();
    _passwordStreamController.close();
    _organizationIdStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  Sink<String> get inputIdentifier => _identifierStreamController.sink;

  @override
  Sink<String> get inputPassword => _passwordStreamController.sink;

  @override
  Sink<String> get inputOrganizationId => _organizationIdStreamController.sink;

  @override
  Sink<bool> get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream;

  @override
  Stream<bool> get outIsIdentifierValid => _identifierStreamController.stream
      .map((identifier) => _isIdentifierValid(identifier));

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  Stream<bool> get outIsOrganizationIdValid =>
      _organizationIdStreamController.stream.map(_isOrganizationIdValid);

  @override
  void setIdentifier(String identifier) {
    inputIdentifier.add(identifier.trim());
    signInObject = signInObject.copyWith(identifier: identifier.trim());
    _validateInputs();
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password.trim());
    signInObject = signInObject.copyWith(password: password.trim());
    _validateInputs();
  }

  @override
  void setOrganizationId(String id) {
    inputOrganizationId.add(id.trim());
    signInObject = signInObject.copyWith(organizationId: id.trim());
    _validateInputs();
  }



  @override
  Future<void> login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    (await _signinUsecase.execute(
        SigninUsecaseInput(
          signInObject.identifier,
          signInObject.password,
          signInObject.organizationId,
        )
    ))
        .fold(
            (failure) => {
            print("LOGIN FAILED: ${failure.message}"),
        inputState.add(ErrorState(
              StateRendererType.popUpErrorState, failure.message))
        }, (data) async {
      inputState.add(ContentState());
      isUserLoggedInSuccessfullyStreamController.add(true);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data.token);
    }
    );
  }

  @override
  void start() {}
  void _validateInputs() {
    inputAreAllInputsValid.add(_areAllInputsValid());
  }

  bool _isPasswordValid(String password) => password.isNotEmpty;

  bool _isIdentifierValid(String identifier) => identifier.isNotEmpty;


  bool _isOrganizationIdValid(String id) => id.isNotEmpty;

  bool _areAllInputsValid() {
    return _isIdentifierValid(signInObject.identifier) &&
        _isPasswordValid(signInObject.password) &&
        _isOrganizationIdValid(signInObject.organizationId);
  }
  // TODO: Remove!!
  void validate() {
    _validateInputs();
  }


}

abstract class LoginViewModelInputs {
  void setIdentifier(String identifier);
  void setPassword(String password);
  void setOrganizationId(String id);

  Future<void> login();

  Sink<String> get inputIdentifier;
  Sink<String> get inputPassword;
  Sink<String> get inputOrganizationId;
  Sink<bool> get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsIdentifierValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outIsOrganizationIdValid;
  Stream<bool> get outAreAllInputsValid;
}
