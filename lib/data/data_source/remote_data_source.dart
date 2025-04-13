import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import '../../app/constants.dart';
import '../network/app_api.dart';
import '../network/requests.dart';


class RemoteDataSource {
  final AppServiceClient appServiceClient;

  RemoteDataSource(this.appServiceClient);

  Future<http.Response> login(LoginRequest request) async {
    final url = Uri.parse('${Constants.baseUrl}/signin');
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'identifier': request.identifier,
        'password': request.password,
      }),
    );
  }

// Add other methods as needed
}
