import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:smart_transportation/app/constants.dart';
import 'package:smart_transportation/data/response/response.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  @POST("/auth/signin")
  Future<AuthenticationSignInResponse> login(
      @Field("identifier") String identifier,
      @Field("password") String password);
}
