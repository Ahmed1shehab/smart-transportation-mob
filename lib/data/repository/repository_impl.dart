import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:smart_transportation/app/constants.dart';
import 'package:smart_transportation/data/data_source/remote_data_source.dart';
import 'package:smart_transportation/data/mapper/mapper.dart';
import 'package:smart_transportation/data/network/error_handler.dart';
import 'package:smart_transportation/data/network/failure.dart';
import 'package:smart_transportation/data/network/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:smart_transportation/data/network/requests.dart';
import 'package:smart_transportation/data/response/response.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  final String baseUrl = Constants.baseUrl;

  @override
  Future<Either<Failure, AuthenticationSignIn>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/signin'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'identifier': loginRequest.identifier,
            'password': loginRequest.password,
          }),
        );

        if (response.statusCode == 201) {
          // Parse the response body
          print("success");
          final data = jsonDecode(response.body);
          final authenticationSignInResponse = AuthenticationSignInResponse.fromJson(data);

          return authenticationSignInResponse.toDomain();
        } else {
          // Handle errors
          print("error1: ${response.statusCode}");
          print("Error Response: ${response.body}");
          throw Exception('Failed to sign in: ${response.statusCode}');
        }
      } catch (error) {
        print("error2");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      print("3");
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());

    }
  }

// Add other methods as needed
}
