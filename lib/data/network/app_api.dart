import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_transportation/app/constants.dart';
import 'package:smart_transportation/data/response/response.dart';

part 'app_api.g.dart'; // Generated file

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  //Login
  @POST("/api/auth/signin")
  Future<AuthenticationSignInResponse> login(
    @Field("identifier") String identifier,
    @Field("password") String password,
  );
  //Register
  @POST("/api/auth/signup")
  @MultiPart()
  Future<AuthenticationSignUpResponse> register(@Body() FormData formData);
  //create organizer onboard
  @POST('/api/organizer/onboard')
  @MultiPart()
  Future<CreateOrganizerResponse> createNewOrganizer(@Body() FormData formData);
  //create new organization 
  @POST('/api/organizer/organization')
  @MultiPart()
  Future<CreateOrganizerResponse> createNewOrganization(@Body() FormData formData);
  //Get THe organizations
  @GET('/api/organizer/organization')
  Future<GetAllOrganizationsResponse> getAllOrganizationsData();
  @GET('/api/organizer/organization/{id}')
  Future<GetOneOrganizationResponse> getOrganizationData(
      @Path("id") String id,
      );
  //
  @POST("/api/organizer/driver")
  @MultiPart()
  Future<CreateDriverResponse> createNewDriver(@Body() FormData formData);
}
