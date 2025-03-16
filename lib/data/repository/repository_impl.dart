import 'package:dartz/dartz.dart';
import 'package:smart_transportation/app/app_prefs.dart';
import 'package:smart_transportation/data/data_source/remote_data_source.dart';
import 'package:smart_transportation/data/mapper/mapper.dart';
import 'package:smart_transportation/data/network/error_handler.dart';
import 'package:smart_transportation/data/network/failure.dart';
import 'package:smart_transportation/data/network/network_info.dart';
import 'package:smart_transportation/data/network/requests.dart';
import 'package:smart_transportation/data/response/response.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;

  RepositoryImpl(this._remoteDataSource, this._networkInfo, this._appPreferences);

  @override
  Future<Either<Failure, AuthenticationSignIn>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // Use AppServiceClient to make the login request
        final response = await _remoteDataSource.login(loginRequest);

        // Save the access token
        if (response.data?.accessToken != null) {
          await _appPreferences.saveAccessToken(response.data!.accessToken!);
          print("Token is saved successfully");
        } else {
          print("Access Token is null");
        }

        // Convert the response to a domain model
        return response.toDomain();
      } catch (error) {
        print("Exception caught during login: $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {

      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Organizer>> createOrganization(CreateOrganizerRequest createOrganizationRequest) async{
    if (await _networkInfo.isConnected) {
      try {
        // Use AppServiceClient to make the createOrganizer request
        final response = await _remoteDataSource.createOrganizer(createOrganizationRequest);
        // Convert the response to a domain model
        return response.toDomain();
      } catch (error) {
        print("Exception caught during creating Organizer: $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {

      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}