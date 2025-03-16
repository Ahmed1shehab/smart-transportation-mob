import 'package:dartz/dartz.dart';
import 'package:smart_transportation/app/constants.dart';
import 'package:smart_transportation/data/network/failure.dart';
import 'package:smart_transportation/data/response/response.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';

// Mapper for DataResponse
extension DataResponseMapper on DataResponse {
  AccessToken toDomain() {
    return AccessToken(accessToken ?? Constants.empty);
  }
}

// Mapper for AuthenticationSignInResponse
extension AuthenticationSignInResponseMapper on AuthenticationSignInResponse? {
  Either<Failure, AuthenticationSignIn> toDomain() {
    if (this == null) {
      return Left(Failure(ApiInternalStatus.failure, Constants.nullString));
    }

    final data = this?.data;
    if (data == null) {
      return Left(Failure(ApiInternalStatus.failure, AppStrings.dataFieldFail));
    }

    try {
      final authenticationSignIn = AuthenticationSignIn(
        token: data.accessToken ?? Constants.empty,
        message: statusMessage() ?? Constants.empty,
      );

      return Right(authenticationSignIn);
    } catch (error) {
      return Left(Failure(ApiInternalStatus.failure, error.toString()));
    }
  }

  String? statusMessage() {
    final status = this?.status;
    final message = this?.message;

    switch (status) {
      case 201:
        return AppStrings.loginSuccessful;
      default:
        return message ?? Constants.empty;
    }
  }
}

// Mapper for CreateOrganizerResponse
extension CreateOrganizerResponseMapper on CreateOrganizerResponse? {
  Either<Failure, Organizer> toDomain() {
    if (this == null) {
      return Left(Failure(ApiInternalStatus.failure, Constants.nullString));
    }

    final data = this?.data;
    if (data == null) {
      return Left(Failure(ApiInternalStatus.failure, AppStrings.dataFieldFail));
    }

    try {
      // Convert OrganizerData to Organizer domain model
      final organizer = Organizer(
        name: data.name,
        type: data.type,
        image: data.image,
        description: data.description,
        address: data.address,
        owner: data.owner.toDomain(),
        // Convert OwnerData to Owner domain model
        id: data.organizerId,
        v: data.v,
      );

      return Right(organizer);
    } catch (error) {
      return Left(Failure(ApiInternalStatus.failure, error.toString()));
    }
  }
}

// Mapper for OrganizerData
extension OrganizerDataMapper on OrganizerData {
  Organizer toDomain() {
    return Organizer(
      name: name,
      type: type,
      image: image,
      description: description,
      address: address,
      owner: owner.toDomain(),
      // Convert OwnerData to Owner domain model
      id: organizerId,
      v: v,
    );
  }
}

// Mapper for OwnerData
extension OwnerDataMapper on OwnerData {
  Owner toDomain() {
    return Owner(
      user: user.toDomain(), // Convert UserData to User domain model
      id: ownerId,
      v: v,
    );
  }
}

// Mapper for UserData
extension UserDataMapper on UserData {
  User toDomain() {
    return User(
      id: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      status: status,
      v: v,
    );
  }
}
