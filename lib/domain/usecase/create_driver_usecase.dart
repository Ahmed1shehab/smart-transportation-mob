import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:smart_transportation/data/network/failure.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/domain/repository/repository.dart';
import 'package:smart_transportation/domain/usecase/base_usecase.dart';
import 'package:smart_transportation/data/network/requests.dart';

class CreateDriverUsecase implements BaseUseCase<CreateDriverInput, Driver> {
  final Repository _repository;

  CreateDriverUsecase(this._repository);

  @override
  Future<Either<Failure, Driver>> execute(CreateDriverInput input) async {
    try {
      final request = CreateDriverRequest(
        licenseInfo: input.licenseInfo,
        licenseDate: input.licenseDate,
        image: input.imageFile,
        firstName: input.firstName,
        lastName: input.lastName,
        email: input.email,
        phoneNumber: input.phoneNumber,
        password: input.password,
        organization: input.organizationId,
      );
      return await _repository.createDriver(request);
    } catch (e) {
      return Left(Failure(
          ApiInternalStatus.failure,
          "Error creating driver: ${e.toString()}"
      ));
    }
  }
}

class CreateDriverInput {
  final String licenseInfo;
  final DateTime licenseDate;
  final File imageFile;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String organizationId;

  CreateDriverInput({
    required this.licenseInfo,
    required this.licenseDate,
    required this.imageFile,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.organizationId,
  });
}