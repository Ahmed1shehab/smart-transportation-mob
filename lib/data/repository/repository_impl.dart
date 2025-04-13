import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:supervisor_app/data/mapper/mapper.dart';

import '../../app/constants.dart';
import '../../domain/model/models.dart';
import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import '../network/requests.dart';
import '../response/response.dart';

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
