import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:supervisor_app/data/network/requests.dart'; // IMPORTANT

import '../../app/constants.dart';
import '../response/response.dart';

part 'app_api.g.dart'; // <-- Must be here

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/auth/signin")
  Future<AuthenticationSignInResponse> login(
      @Body() LoginRequest loginRequest,
      );
}
