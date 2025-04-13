import 'package:dartz/dartz.dart';
import '../../app/constants.dart';
import '../../domain/model/models.dart';
import '../network/failure.dart';
import '../response/response.dart';

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
      return Left(Failure(ApiInternalStatus.failure, "Null response"));
    }

    final data = this?.data;
    if (data == null) {
      return Left(Failure(ApiInternalStatus.failure, "Data field is missing in response"));
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
        return "Login successful";
      default:
        return message ?? Constants.empty;
    }
  }
}
