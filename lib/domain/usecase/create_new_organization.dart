import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:smart_transportation/data/network/failure.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/domain/repository/repository.dart';
import 'package:smart_transportation/domain/usecase/base_usecase.dart';
import 'package:smart_transportation/data/network/requests.dart';

class CreateNewOrganizerUsecase implements BaseUseCase<CreateNewOrganizerInput, Organizer> {
  final Repository _repository;

  CreateNewOrganizerUsecase(this._repository);

  @override
  Future<Either<Failure, Organizer>> execute(CreateNewOrganizerInput input) async {
    try {
      final request = CreateNewOrganizationRequest(
        name: input.name,
        type: input.type,
        phoneNumber: input.phoneNumber,
        description: input.description,
        image: input.imageFile,
        addressId: input.addressId,
      );

      return await _repository.createNewOrganization(request);
    } catch (e) {
      return Left(Failure(
          ApiInternalStatus.failure,
          "Error creating organizer: ${e.toString()}"
      ));
    }
  }
}

class CreateNewOrganizerInput {
  final String name;
  final String type;
  final String phoneNumber;
  final String description;
  final File imageFile; 
  final String addressId;
  CreateNewOrganizerInput({
    required this.name,
    required this.type,
    required this.phoneNumber,
    required this.description,
    required this.imageFile,
    required this.addressId,
  });
}