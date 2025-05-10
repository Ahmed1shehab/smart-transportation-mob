import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:smart_transportation/data/network/failure.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/domain/repository/repository.dart';
import 'package:smart_transportation/domain/usecase/base_usecase.dart';
import 'package:smart_transportation/data/network/requests.dart';

class CreateOrganizerUsecase implements BaseUseCase<CreateOrganizerInput, Organizer> {
  final Repository _repository;

  CreateOrganizerUsecase(this._repository);

  @override
  Future<Either<Failure, Organizer>> execute(CreateOrganizerInput input) async {
    try {
      // Create the request object from input
      final request = CreateOrganizerRequest(
        name: input.name,
        type: input.type,
        phoneNumber: input.phoneNumber,
        description: input.description,
        image: input.imageFile,
        street: input.street,
        city: input.city,
        state: input.state,
        postalCode: input.postalCode,
      );

      // Let repository handle the request
      return await _repository.createOrganization(request);
    } catch (e) {
      return Left(Failure(
          ApiInternalStatus.failure,
          "Error creating organizer: ${e.toString()}"
      ));
    }
  }
}

class CreateOrganizerInput {
  final String name;
  final String type;
  final String phoneNumber;
  final String description;
  final File imageFile; // Changed from MultipartFile to File
  final String street;
  final String city;
  final String state;
  final String postalCode;

  CreateOrganizerInput({
    required this.name,
    required this.type,
    required this.phoneNumber,
    required this.description,
    required this.imageFile,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
  });
}