import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smart_transportation/data/network/failure.dart';
import 'package:smart_transportation/data/network/requests.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/domain/repository/repository.dart';
import 'package:smart_transportation/domain/usecase/base_usecase.dart';

class SignupUsecase
    implements BaseUseCase<SignupUsecaseInput, AuthenticationSignUp> {
  final Repository _repository;

  SignupUsecase(this._repository);

  @override
  Future<Either<Failure, AuthenticationSignUp>> execute(
      SignupUsecaseInput input) async {
    return await _repository.register(RegisterRequest(input.image,input.firstName,
        input.lastName, input.email, input.phoneNumber, input.password));
  }
}

class SignupUsecaseInput {
  File image;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;

  SignupUsecaseInput(this.image,this.firstName, this.lastName, this.email,
      this.phoneNumber, this.password);
}
