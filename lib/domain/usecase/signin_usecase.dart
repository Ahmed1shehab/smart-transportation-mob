import 'package:dartz/dartz.dart';


import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

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
  final String identifier;
  final String password;
  final String organizationId;

  SigninUsecaseInput(this.identifier, this.password, this.organizationId); // Update constructor
}

