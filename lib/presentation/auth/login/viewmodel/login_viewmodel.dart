import 'dart:async';
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
  final StreamController<bool> _areAllInputsValidStreamController =
  StreamController<bool>.broadcast();

  final StreamController<bool> isUserLoggedInSuccessfullyStreamController =
  StreamController<bool>();

  LoginObject signInObject = LoginObject("", "");

  final SigninUsecase _signinUsecase;

  LoginViewModel(this._signinUsecase);

  @override
  void dispose() {
    _identifierStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  Sink<String> get inputIdentifier => _identifierStreamController.sink;

  @override
  Sink<String> get inputPassword => _passwordStreamController.sink;

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

  @override
  void setIdentifier(String identifier) {
    inputIdentifier.add(identifier);
    signInObject = signInObject.copyWith(identifier: identifier);
    _validateInputs();
  }

  @override
  void setPassword(String password) {
    inputPassword.add(password);
    signInObject = signInObject.copyWith(password: password);
    _validateInputs();
  }

  @override
  Future<void> login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await _signinUsecase.execute(
        SigninUsecaseInput(signInObject.identifier, signInObject.password)))
        .fold(
            (failure) => {
          inputState.add(ErrorState(
              StateRendererType.popUpErrorState, failure.message))
        }, (data) {
      inputState.add(ContentState());
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  void start() {}

  void _validateInputs() {
    inputAreAllInputsValid.add(_areAllInputsValid());
  }

  bool _isPasswordValid(String password) => password.isNotEmpty;

  bool _isIdentifierValid(String identifier) => identifier.isNotEmpty;

  bool _areAllInputsValid() {
    return _isPasswordValid(signInObject.password) &&
        _isIdentifierValid(signInObject.identifier);
  }
}

abstract class LoginViewModelInputs {
  void setIdentifier(String identifier);
  void setPassword(String password);
  Future<void> login();

  Sink<String> get inputIdentifier;
  Sink<String> get inputPassword;
  Sink<bool> get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsIdentifierValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreAllInputsValid;
}
