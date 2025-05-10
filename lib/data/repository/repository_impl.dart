import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_transportation/app/app_prefs.dart';
import 'package:smart_transportation/data/data_source/remote_data_source.dart';
import 'package:smart_transportation/data/mapper/mapper.dart';
import 'package:smart_transportation/data/network/error_handler.dart';
import 'package:smart_transportation/data/network/failure.dart';
import 'package:smart_transportation/data/network/network_info.dart';
import 'package:smart_transportation/data/network/requests.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;

  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._appPreferences);

  @override
  Future<Either<Failure, AuthenticationSignIn>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.data?.accessToken != null) {
          await _appPreferences.saveAccessToken(response.data!.accessToken!);
          if (kDebugMode) {
            print("Token is saved successfully");
          }
        } else {
          if (kDebugMode) {
            print("Access Token is null");
          }
        }
        return response.toDomain();
      } catch (error) {
        if (kDebugMode) {
          print("Exception caught during login: $error");
        }
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationSignUp>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        return response.toDomain();
      } catch (error) {
        if (kDebugMode) {
          print("Exception caught during Register: $error");
        }
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Organizer>> createOrganization(
      CreateOrganizerRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.createOrganizer(request);
        return response.toDomain();
      } catch (error) {
        if (kDebugMode) {
          print("Exception caught during creating Organizer: $error");
        }
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
   @override
  Future<Either<Failure, Organizer>> createNewOrganization(CreateNewOrganizationRequest createNewOrganizationRequest) 
    async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.createNewOrganizer(createNewOrganizationRequest);
        return response.toDomain();
      } catch (error) {
        if (kDebugMode) {
          print("Exception caught during creating Organizer: $error");
        }
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrganizationItem>>> getAllOrganizations() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getAllOrganizationsData();
        return response.toDomain();
      } catch (error) {
        if (kDebugMode) {
          print("Exception caught during getting all organizations: $error");
        }
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, OrganizationItem>> getOrganization(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getOrganizationData(id);
        return response.toDomain();
      } catch (error) {
        if (kDebugMode) {
          print("Exception caught during getting organization by ID: $error");
        }
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Driver>> createDriver(
      CreateDriverRequest createDriverRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.createDriver(createDriverRequest);
        return response.toDomain();
      } catch (error) {
        if (kDebugMode) {
          print("Exception caught during creating Organizer: $error");
        }
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
 
}
