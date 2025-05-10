import 'dart:async';
import 'package:smart_transportation/app/app_prefs.dart';
import 'package:smart_transportation/domain/usecase/signin_usecase.dart';
import 'package:smart_transportation/presentation/base/baseviewmodel.dart';
import 'package:smart_transportation/presentation/common/freezed_data_classes.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';

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

  final StreamController<String> _accountTypeController = StreamController<String>.broadcast();
  Stream<String> get accountTypeStream => _accountTypeController.stream;


  LoginObject signInObject = LoginObject("", "");

  final SigninUsecase _signinUsecase;

  final AppPreferences _appPreferences;

  LoginViewModel(this._signinUsecase, this._appPreferences);


  @override
  void dispose() {
    _accountTypeController.close();
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
  Sink<bool> get inputAreAllInputsValid =>
      _areAllInputsValidStreamController.sink;

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
      LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
    );

    (await _signinUsecase.execute(
      SigninUsecaseInput(signInObject.identifier, signInObject.password),
    )).fold(
          (failure) {
        inputState.add(
          ErrorState(StateRendererType.popUpErrorState, failure.message),
        );
      },
          (data) async {
        await _appPreferences.deleteAccessToken();

        await _appPreferences.saveAccessToken(data.token);
        _accountTypeController.add(data.accountType ?? 'none');

        inputState.add(ContentState());
        isUserLoggedInSuccessfullyStreamController.add(true);
      },
    );
  }



  @override
  void start() {
    inputState.add(ContentState());
  }

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
