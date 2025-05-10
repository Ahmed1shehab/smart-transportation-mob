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
        accountType: data.accountType ?? Constants.empty,
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

// Mapper for SignUp
// Mapper for UserDataResponse
// Mapper for UserDataResponse
extension UserDataResponseMapper on UserDataResponse {
  User toDomain() {
    return User(
      id: id.toString(),
      // Convert to String explicitly
      firstName: firstName ?? Constants.empty,
      lastName: lastName ?? Constants.empty,
      email: email ?? Constants.empty,
      phoneNumber: phoneNumber ?? Constants.empty,
      password: password ?? Constants.empty,
      status: status ?? Constants.empty,
      v: v ?? 0,
    );
  }
}

// Mapper for AuthenticationSignUpResponse
extension AuthenticationSignUpResponseMapper on AuthenticationSignUpResponse? {
  Either<Failure, AuthenticationSignUp> toDomain() {
    if (this == null) {
      return Left(Failure(ApiInternalStatus.failure, Constants.nullString));
    }

    final data = this?.data;
    if (data == null) {
      return Left(Failure(ApiInternalStatus.failure, AppStrings.dataFieldFail));
    }

    try {
      final authenticationSignUp = AuthenticationSignUp(
        user: data.toDomain(),
        message: statusMessage() ?? Constants.empty,
        timestamp: this?.timestamp ?? Constants.empty,
        path: this?.path ?? Constants.empty,
      );

      return Right(authenticationSignUp);
    } catch (error) {
      return Left(Failure(ApiInternalStatus.failure, error.toString()));
    }
  }

  String? statusMessage() {
    final status = this?.status;
    final message = this?.message;

    switch (status) {
      case 201:
        return AppStrings.registrationSuccessful;
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
      id: organizerId,
      v: v,
    );
  }
}

// Mapper for OwnerData
// Mapper for OwnerData
extension OwnerDataMapper on OwnerData {
  Owner toDomain() {
    return Owner(
      id: ownerId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      status: status,
      image: image.replaceAll('\\', '/'),
      // Optional: Fix image URL slashes
      v: v,
    );
  }
}

//get All Organizations
//get one organization

extension OrganizationResponseMapper on OrganizationResponse? {
  Either<Failure, OrganizationItem> toDomain() {
    if (this == null) {
      return Left(Failure(ApiInternalStatus.failure, Constants.nullString));
    }

    try {
      final organization = OrganizationItem(
          id: this?.id ?? Constants.empty,
          name: this?.name ?? Constants.empty,
          type: this?.type ?? Constants.empty,
          image: this?.image ?? Constants.empty,
          description: this?.description ?? Constants.empty,
          address: this?.address ?? Constants.empty,
          owner: this?.owner ?? Constants.empty,
          v: this?.v ?? Constants.zero);
      return Right(organization);
    } catch (error) {
      return Left(Failure(ApiInternalStatus.failure, error.toString()));
    }
  }
}

// Mapper for GetAllOrganizationsDataResponse
extension GetAllOrganizationsDataResponseMapper
    on GetAllOrganizationsDataResponse? {
  Either<Failure, List<OrganizationItem>> toDomain() {
    if (this == null || this?.results == null) {
      return Left(Failure(ApiInternalStatus.failure, Constants.nullString));
    }

    try {
      final organizations = this
              ?.results
              ?.map(
                  (response) => response.toDomain().fold((l) => null, (r) => r))
              .whereType<OrganizationItem>()
              .toList() ??
          [];
      return Right(organizations);
    } catch (error) {
      return Left(Failure(ApiInternalStatus.failure, error.toString()));
    }
  }
}

// Mapper for GetAllOrganizationsResponse
extension GetAllOrganizationsResponseMapper
    on BaseResponse<GetAllOrganizationsDataResponse>? {
  // Use the generic BaseResponse
  Either<Failure, List<OrganizationItem>> toDomain() {
    if (this == null) {
      return Left(Failure(ApiInternalStatus.failure, Constants.nullString));
    }

    final data = this?.data;
    if (data == null) {
      return Left(Failure(ApiInternalStatus.failure, AppStrings.dataFieldFail));
    }

    return data.toDomain();
  }
}

// Mapper for GetOneOrganizationResponse
extension GetOneOrganizationResponseMapper
    on BaseResponse<OrganizationResponse>? {
  // Use the generic BaseResponse
  Either<Failure, OrganizationItem> toDomain() {
    if (this == null) {
      return Left(Failure(ApiInternalStatus.failure, Constants.nullString));
    }

    final data = this?.data;
    if (data == null) {
      return Left(Failure(ApiInternalStatus.failure, AppStrings.dataFieldFail));
    }

    return data.toDomain();
  }
}
// Mapper for CreateDriverResponse
// Mapper for DriverEmployeeData
// Mapper for CreateDriverResponse
extension CreateDriverResponseMapper on CreateDriverResponse? {
  Either<Failure, Driver> toDomain() {
    if (this == null) {
      return Left(Failure(ApiInternalStatus.failure, Constants.nullString));
    }

    final data = this?.data;
    if (data == null) {
      return Left(Failure(ApiInternalStatus.failure, AppStrings.dataFieldFail));
    }

    try {
      final driver = Driver(
        licenseInfo: data.licenseInfo ?? '',
        licenseDate: DateTime.parse(data.licenseDate ?? DateTime.now().toIso8601String()),
        employee: data.employee?.toDomain() ?? OrganizationEmployee(
          firstName: '',
          lastName: '',
          email: '',
          phoneNumber: '',
          password: '',
          image: '',
          status: '',
          organizationId: '',
          id: '',
          v: 0,
        ),
        organizationId: data.organization ?? '',
        id: data.id ?? '',
        createdAt: DateTime.parse(data.createdAt ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(data.updatedAt ?? DateTime.now().toIso8601String()),
        v: data.v ?? 0,
      );

      return Right(driver);
    } catch (error) {
      return Left(Failure(ApiInternalStatus.failure, error.toString()));
    }
  }
}
extension EmployeeDataMapper on EmployeeData {
  OrganizationEmployee toDomain() {
    return OrganizationEmployee(
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      phoneNumber: phoneNumber ?? '',
      password: password ?? '',
      image: image?.replaceAll('\\', '/') ?? '',
      status: status ?? '',
      organizationId: organization ?? '',
      id: this.id ?? '',
      v: v ?? 0,
    );
  }
}
