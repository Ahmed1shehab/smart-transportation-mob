import 'package:dartz/dartz.dart';
import 'package:supervisor_app/data/data_source/remote_data_source.dart';
import 'package:supervisor_app/data/mapper/mapper.dart';
import 'package:supervisor_app/data/network/error_handler.dart';
import 'package:supervisor_app/data/network/failure.dart';
import 'package:supervisor_app/data/network/network_info.dart';
import 'package:supervisor_app/domain/model/models.dart';
import 'package:supervisor_app/domain/repository/repository.dart';

import '../network/requests.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AuthenticationSignIn>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        return response.toDomain(); // Uses your mapper logic
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

// Add other methods as needed...
}
