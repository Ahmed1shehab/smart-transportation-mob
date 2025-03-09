import 'package:dartz/dartz.dart';
import 'package:smart_transportation/data/network/failure.dart';
import 'package:smart_transportation/data/network/requests.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/domain/repository/repository.dart';
import 'package:smart_transportation/domain/usecase/base_usecase.dart';

class SigninUsecase
    implements BaseUseCase<SigninUsecaseInput, AuthenticationSignIn> {
  final Repository _repository;

  SigninUsecase(this._repository);

  @override
  Future<Either<Failure, AuthenticationSignIn>> execute(
      SigninUsecaseInput input) async {
    return await _repository
        .login(LoginRequest(input.identifier, input.password));
  }
}

class SigninUsecaseInput {
  String identifier;
  String password;

  SigninUsecaseInput(this.identifier, this.password);
}
